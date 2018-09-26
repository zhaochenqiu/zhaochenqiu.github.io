title: 高斯混合模型(GMM)与EM算法
date: 2018-09-05 14:01:56
tags: 图像处理
---
详解并实现高斯混合模型与EM(expectation–maximization)算法
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 简介
高斯混合模型，就是用多个高斯函数去模拟数据的分布，经常用于无监督的分类的问题。而EM(expectation–maximization)算法,最大期望算法,则是用来解高斯混合模型的各项参数，是一个迭代型的算法，具体的过程如下图（随着迭代次数的增加，效果在慢慢变好）。

![GMM与EM算法，迭代过程图](https://image.ibb.co/kdoswp/exp1.png)

这里详细记录**GMM的贝叶斯理解过程，以及EM算法迭代公式的推导，实现以及用模拟数据验证算法是否正确。**


# 高斯混合模型(Gaussian Mixture Model)
假设有随机变量X，高斯混合模型可以表示为：

\\[
P(x) = \sum\limits_{k=1}^{K} \pi_k \mathcal{N}(x|\mu_k, \Sigma_k)
\tag{1}
\\]

其中\\(\mathcal{N}(x|\mu_k, \Sigma_k\\)为模型中的第\\(k\\)个分量，\\(K\\)为聚类数量，\\(\pi_k\\)为混合系数其满足：

\\[
\sum\limits_{k=1}^{K}\pi_k = 1 \quad 0 \leq \pi_k \leq 1
\\]

GMM一般用于聚类问题，用于聚类时，会假设数据服从高斯分布。根据数据来反推GMM的概率密度分布，这一步叫做**density estimation**。得到其概率密度后，估计其中的参数被称为**参数估计**。
如上图中的数据：

![无类别数据](https://image.ibb.co/eZZbNU/exp2.png)

很明显，有3个类别，因此可以定义\\(K = 3\\)，因此GMM的表达变为：

\\[
P(x) = \pi_1\mathcal{N}(x|\mu_1, \Sigma_1) + \pi_2\mathcal{N}(x|\mu_2, \Sigma_2) + \pi_1\mathcal{N}(x|\mu_3, \Sigma_3)
\\]

这个例子一共有9个未知数\\(\pi_1, \mu_1, \Sigma_1, \pi_2, \mu_2, \Sigma_2, \pi_3, \mu_3, \Sigma_3 \\)，而EM算法就可以用来求出这些参数。


# GMM的贝叶斯理解
使用贝叶斯去理解GMM是为了更方便的利用EM算法去估计参数，推导EM迭代的公式，首先是GMM的原始表达式：

\\[
P(x) = \sum\limits_{k=1}^{K} \pi_k \mathcal{N}(x|\mu_k, \Sigma_k)
\\]

\\(\pi_k\\)可以看成是第\\(k\\)类被选中的概率。为了表达具体是那个类别被选中，可以引入新的随机变量\\(z_k\\)。\\(z_k \(1 \leq k \leq K \) \\)
只能取0或1两个值。而\\(z_k = 1\\)表示第\\(k\\)个类别被选中的概率，也就是说\\(P(z_k = 1) = \pi_k\\)，数学表达形式如下:
\\[
z_k \in \{0, 1\} \quad \sum\limits_{k = 1}^{K} z_k = 1
\\]

\\(z_k\\)的维度也就代表了类别的个数.以之前的数据图为例,类别数量为3,那么\\(z_k\\)的维度也就是3.
对应着某点分别属于3个特定类别的\\(z_k\\)的值也就是为\\(z_k = [1, 0, 0], [0, 1, 0], [0, 0, 1]\\).
接着假设\\(z_k\\)之间独立同分布，而且已知\\(P(z_k = 1) = \pi_k\\)的情况下，可以得到\\(Z\\)的联合概率分布为：

\\[
P(Z) = P(z_1)P(z_2)P(z_3)\cdots P(z_k)=\prod_{k=1}^{K}{\pi_k}^{z_k}
\tag{2}
\\]

其中由于只有一个\\(z_k\\)为1,其他都为0 ，所以只有被选中的\\(\pi_k\\)开了1次方保留了原值，其他的都被0次方变成了1.
例如假设现在第二个类被选中，也就是说\\(Z = [z_1, z_2, z_3 \cdots, z_K] = [0, 1, 0, \cdots, 0]\\)，代如上式：

\\[
P(\{0, 1, 0, \cdots 0\}) = \prod_{k = 1}^{K} {\pi_k}^{z_k} = {\pi_k}^{[0, 1, 0, \cdots 0]} = {\pi_1}^{0} {\pi_2}^{1} {\pi_3}^{0} \cdots {\pi_k}^{0} = \pi_2
\\]

即：\\(P(z_2 = 1) = \pi_2\\)。现在通过引入\\(z_k\\)描述了某个点具体是那个类别被选中，但是这个点有多大的概率被这个类别生成，或者说这个点属于这个类别的概率是多少还需要考虑。
为此，我们把GMM在\\(z_k\\)的条件概率分布表达列出来，如下:

\\[
P(x|z_k = 1) = \mathcal{N}(x|\mu_k, \Sigma_k)
\\]

进而推出：

\\[
P(x|Z) = \prod_{k = 1}^{K} \mathcal{N}(x|\mu_k, \Sigma_k)^{z_k}
\tag{3}
\\]

最后根据条件概率公式:

\\[
\begin{aligned}
   & P(A|B) = \frac{P(A \cap B)}{P(B)}  \\\\
\Rightarrow & P(A \cap B) = P(A|B)P(B) \\\\
\Rightarrow & P(x \cap Z) = P(x|Z) p(Z)
\end{aligned}
\tag{4}
\\]

合并(2)(3)两式可以得：

\\[
\begin{aligned}
P(x) = & \sum\limits_{Z}^{} P(Z)P(x|Z) = \sum\limits_{Z}^{} \prod_{k=1}^{K}{\pi_k}^{z_k} \prod_{k = 1}^{K} \mathcal{N}(x|\mu_k, \Sigma_k)^{z_k} =  \sum\limits_{Z}^{} \prod_{k = 1}^{K} {\pi_k}^{z_k} \mathcal{N}(x|\mu_k, \Sigma_k)^{z_k}   \\\\
 = & {\pi_1}^{1}  {\pi_2}^{0} \cdots {\pi_k}^{0} \mathcal{N}(x|\mu_1, \Sigma_1)^{1} \mathcal{N}(x|\mu_2, \Sigma_2)^{0} \cdots +  {\pi_1}^{0}  {\pi_2}^{1} \cdots {\pi_k}^{0} \mathcal{N}(x|\mu_1, \Sigma_1)^{0} \mathcal{N}(x|\mu_2, \Sigma_2)^{1} \cdots + \cdots \\\\
 = & \sum\limits_{k=1}^{K} \pi_k \mathcal{N}(x|\mu_k, \Sigma_k) \quad z_k = 0的项为1,省略
\end{aligned}
\\]

上式与(1)中的GMM一样，只是引入了一个\\(z_k\\)来表达具体的类别。**\\(z_k\\)被称为隐含变量，用来描述“知道数据具体分成几类，但是无法观察数据具体属于那一个类别”**。

# EM(expectation-maximization) 迭代公式推导
在贝叶斯(Bayes)的思想下，P(Z)为先验概率(Prior probability), P(x|Z)为条件概率(Conditional probability),那么很自然就可以想要求出后验概率(Posterior probability).

根据贝叶斯公式:

\\[
P(A|B) = \frac{P(A)P(B|A)}{P(B)}
\\]

套用到\\(x\\)与\\(Z\\)中可以得到：

\\[
\gamma(z_k)  = P(z_k = 1|x) = \frac{P(z_k=1)P(x|z_k = 1)}{P(x, z_k = 1)}
\tag{5}
\\]

又有全概率公式：

\\[
Pr(A) = \sum\limits_{n}^{A \cap B_n}
\\]

以及(4)中的条件概率公式,可以得到：

\\[
Pr(A) = \sum\limits_{}^{n} Pr(A|B_n) Pr(B_n)
\tag{6}
\\]

接着，根据(6)式去修改(5)式可以得到如下表达式:

\\[
\gamma(z_k) = p(z_k = 1|x) = \frac{P(z_k=1)P(x|z_k=1)}{}
\\]



可以得到


GMM 示例代码：

    clear all
    close all
    clc

    num = 5000;
    rate = [0.2 0.25 0.55];

    mu1 = [2 3];
    sig1 = [0.1 0 
              0   0.2];

    mu2 = [1 1];
    sig2 = [0.25 0
              0    0.4];

    mu3 = [4 1];
    sig3 = [0.2 0
             0   0.36];


    data1 = mvnrnd(mu1, sig1, num*rate(1));
    data2 = mvnrnd(mu2, sig2, num*rate(2));
    data3 = mvnrnd(mu3, sig3, num*rate(3));

    %data1 = mvnrnd(mu1, sigma1, num*portion(1));

    figure
    plot(data1(:, 1), data1(:, 2), '.b')
    hold on
    plot(data2(:, 1), data2(:, 2), '.r')
    hold on
    plot(data3(:, 1), data3(:, 2), '.y')


    data = [data1; data2; data3];
    [row_data column_data] = size(data);

    idx = randperm(row_data);
    data = data(idx, :);

    % parameter initialization
    wei = [1/3 1/3 1/3];

    sig_mat = zeros(2, 2, 3);
    sig_mat(:, :, 1) = [1 0
                        0 1];

    sig_mat(:, :, 2) = [1 0
                        0 1];

    sig_mat(:, :, 3) = [1 0
                        0 1];

    mu_mat = zeros(3, 2);
    mu_mat(:, 2) = (max(data(:, 2)) + min(data(:,2)))/2;

    mu_mat(1, 1) = (1/4)*max(data(:, 1)) + (3/4)*min(data(:, 1));
    mu_mat(2, 1) = (2/4)*max(data(:, 1)) + (2/4)*min(data(:, 1));
    mu_mat(3, 1) = (3/4)*max(data(:, 1)) + (1/4)*min(data(:, 1));

    [row_mu column_mu] = size(mu_mat);

    r = zeros(row_data, row_mu);

    iter = 40;
    for i = 1:iter
        for k = 1:row_mu
            r(:, k) = wei(k)*mvnpdf(data, mu_mat(k, :), sig_mat(:, :, k));
        end
    %    r = r ./ repmat(sum(r, 2), 1, row_mu);
        r = r ./ sum(r, 2);


        % update the weight
        for k = 1:row_mu
            wei(k) = sum(r(:, k))/row_mu;
        end

        % update the mu
        for k = 1:row_mu
            mu_mat(k, 1) = sum(r(:, k) .* data(:, 1)) / sum(r(:, k));
            mu_mat(k, 2) = sum(r(:, k) .* data(:, 2)) / sum(r(:, k));
        end

        % update the sigma
        for k = 1:row_mu
            sig_mat(:, :, k) = ((data - mu_mat(k, :))' * ((data - mu_mat(k, :)) .* r(:, k))) / sum(r(:, k));
        end
    end

    % Estimation
    [value pos] = max(r, [], 2);

    idx1 = find(pos == 1);
    idx2 = find(pos == 2);
    idx3 = find(pos == 3);

    figure
    plot(data(idx1, 1), data(idx1, 2), '.b');
    hold on
    plot(data(idx2, 1), data(idx2, 2), '.r');
    hold on
    plot(data(idx3, 1), data(idx3, 2), '.y');
