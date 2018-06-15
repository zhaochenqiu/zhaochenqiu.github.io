title: 样本方差无偏估计详解
date: 2018-06-01 2018-06-15
tags: 概率与统计
---
样本方差无偏估计的过程，理论，实验验证
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  TeX: { equationNumbers: { autoNumber: "AMS" } }
});
</script>

# 样本方差无偏估计
先来一个协方差的定义，假设现在有两个随机变量\\(X\\)和\\(Y\\)，
这两个随机变量的期望分别为\\(E(X) = \mu \\)和\\(E(Y) = \nu \\)，
这两个随机变量的之间的协方差定义为：
\\[
cov(X, Y) = E[(X - \mu)(Y - \nu)]
\\]
得到协方差之后，就可以计算相关性系数(var 表示随机变量的方差)：
\\[
\eta = \frac{cov(X, Y)}{\sqrt{var(X) \cdot var(Y) }}
\\]

在实际中，我们是无法获得随机变量\\(X\\)和\\(Y\\)的所有的值的，只能通过观测得到的一些样本来估计。
现在假设观测到的样本为\\(X_i\\)和\\(Y_i\\)，协方差矩阵的计算公式为：

\\[
cov(X, Y) = \frac{ \sum\limits\_{i = 1}^{n} (X_i - \bar{X}) (Y_i - \bar{Y}) }{n - 1}
\\]

这个地方为什么会是\\(n - 1\\)而不是\\(n\\)呢？为什么要减一？这就涉及到样本的无偏估计.
假设已知随机变量X,而且还知道他的期望是\\(\mu\\),那么方差的计算方法如下:

\\[
\sigma^2 = E[(X - \mu)^2]
\\]

但实际中我们我是得不到Ｘ的具体分布的，只能通过采样来算，所以上式的具体计算过程变成了:

\\[
\begin{equation}
\label{eq1}
S^2 = \frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2
\end{equation}
\\]

根据中心极限定理，上式就是\\( \sigma^2 \\)的无偏估计，所以可以用\\( S^2 \\)来替代\\( \sigma^2 \\)。
更甚者，我们连\\(\mu\\) 都是不知道的，只知道样本的均值\\( \bar{X}\\),且:

\\[
\bar{X} = \frac{1}{n} \sum\limits\_{i = 1}^{n} X_i
\\]

最后然后\\(S^2\\)的计算公式就变成:

\\[
\begin{equation}
\label{eq2}
S^2 = \frac{1}{n - 1} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2
\end{equation}
\\]

和协方差公式一样，分母变成了\\(n - 1\\),那么为什么要把分母变成\\(n - 1 \\),而不是直接使用n或者用\\(n - 2\\)呢？
在解释之前，先实验验证下，是不是\\( n - 1 \\)比\\(n\\)或者\\(n - 2\\)好.

# 无偏估计实验验证
这里生成一个服从高斯分布的随机变量,及\\(X \approx N(1, 0.5^2) \\).为了保证样本足够，我们生成一百万个数字。

    mu = 1;
    sigma = 0.5;

    data = normrnd(mu, sigma, 1, num);

此处的`data`数组就保存了一百万个服从\\( \approx N(1, 0.5^2) \\)的数据，如果用直方图统计的话就可以看到一个很完美的正态分布图。
这里再验证下：

    figure
    hist(data, -2:0.001:4)

然后就可以看到很完美的正态分布图：

![随机变量X直方图](https://image.ibb.co/ck2HyT/exp1.png)

接下来就是利用样本方差的公式来估计下方差，这里分别测试除以\\( n, n - 1, n - 2\\)的结果，看看是不是
样本方差的公式的 \\( n - 1 \\) 的效果最好:

    n = 10;
    num_sample = 500;

    result = zeros(num_sample,4);

    for i = 1:num_sample
        idx = randperm(num);
        data = data(idx);

        sample = data(1:n);
        temp = sample - mean(sample);
        value = sum(temp.*temp);

        s1 = value/n;
        s2 = value/(n - 1);
        s3 = value/(n - 2);

        l1 = [s1 s2 s3 sigma^2];

        result(i, :) = l1;
        i
    end

    mean(result)

大体的意思就是随机采样500次，每次随机采10个数字，按照三个不同的分母计算出1500个方差，
然后均值出来3个最终结果，这样的话就是利用 \\( 500 \times 10 = 5000 \\) 个样本估计
一百万个数据的方差，最后程序输出如下：

    ans =

        0.2213    0.2459    0.2766    0.2500

看结果，分母为\\( n -1 \\) 的公式效果最好，为0.2459和真实值0.2500只差0.0001.所以样本方差公式分母为n - 1**正确无误**。

# 无偏估计公式理解
现在就来介绍为什么样本方差分母会是\\( n - 1\\)而不是\\( n \\)。因为我们只是想验证理解，
所以用反推的方式。

仔细观察公式\ref{eq1}和公式\ref{eq2}，
当把\\(\bar{X}\\)换成\\(\mu\\)时候，分母就由\\(n\\)变成了\\(n - 1\\)。
当分母变成了\\( n - 1\\)时，估计出来的值会增大，就是说当使用\\(\bar{X}\\)的时候，估计值偏小。
也就是说：
\\[
\sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2 \leq \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 
\\]

上式的前半部分\\( \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2 \\)，描述的是某一次采样的过程。
对于这次采样，只有当\\( \mu = \bar{X} \\)时，该式才取得最小值。因为采样的关系，\\( \bar{X} \\)的值对于\\( \mu \\)有一定的偏差，
所以才会产生上式。接着继续推公式：
\\[
\begin{aligned}
\Rightarrow   \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2 & \leq \sum\limits\_{i = 1}^{n}(X_i - \mu)^2  \\\\
\Rightarrow   \frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2 & \leq \frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 \\\\
\Rightarrow   E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2] & \leq E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2] = \sigma^2 \\\\
\end{aligned}
\\]

也就是说，如果使用：
\\[
S^2 = \frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2 
\\]
估计方差，\\( S^2 \\)就会服从一个偏离\\( \sigma^2 \\)的分布，而且倾向于低估\\( \sigma^2 \\)，
那么具体小了多少呢？继续推公式:
\\[
\begin{aligned}
E[S^2] & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2 ] = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}((X_i - \mu) - (\bar{X} - \mu))^2]  \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}((X_i - \mu)^2 - 2(X_i - \mu)(\bar{X} - \mu) + (\bar{X} - \mu)^2)] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - \frac{2}{n}(\bar{X} - \mu)\sum\limits\_{i = 1}^{n}(X_i - \mu) + \frac{1}{n}(\bar{X} - \mu)^2\sum\limits\_{i = 1}^{n}1 ] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - \frac{2}{n}(\bar{X} - \mu)\sum\limits\_{i = 1}^{n}(X_i - \mu) + \frac{1}{n}(\bar{X} - \mu)^2n ] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - \frac{2}{n}(\bar{X} - \mu)\sum\limits\_{i = 1}^{n}(X_i - \mu) + (\bar{X} - \mu)^2 ] \\\\
\end{aligned}
\\]

其中:
\\[
\bar{X} - \mu = \frac{1}{n} \sum\limits\_{i = 1}^{n}X_i - \mu = \frac{1}{n}\sum\limits\_{i = 1}^{n}X_i - \frac{1}{n}\sum\limits\_{i = 1}^{n}\mu = \frac{1}{n}\sum\limits\_{i = 1}^{n}(X_i - \mu)
\\]

也就是说:
\\[
n(\bar{X} - \mu) = \sum\limits\_{i = 1}^{n}(X_i - \mu)
\\]

继续把上式带入\\( E[S^2] \\)中进行推导:
\\[
\begin{aligned}
E[S^2] & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - \frac{2}{n}(\bar{X} - \mu)\sum\limits\_{i = 1}^{n}(X_i - \mu) + (\bar{X} - \mu)^2 ] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - \frac{2}{n}(\bar{X} - \mu)n(\bar{X} - \mu)   + (\bar{X} - \mu)^2 ] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - 2(\bar{X} - \mu)^2   + (\bar{X} - \mu)^2 ] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2 - (\bar{X} - \mu)^2] \\\\
 & = E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2] - E[(\bar{X} - \mu)^2] \\\\
 & = \sigma^2 - E[(\bar{X} - \mu)^2] \\\\
\end{aligned}
\\]

其中
\\[
\begin{aligned}
E[(\bar{X} - \mu)^2] & =  E(\bar{X} - E[\bar{X}])^2 = var(\bar(X)) = var(\frac{ \sum\limits\_{i = 1}^{n}X_i}{n}) \\\\
& = \frac{1}{n^2}\sum\limits\_{i = 1}^{n}var(X_i) = \frac{n}{n^2} \sigma^2 = \frac{\sigma^2}{n} \\\\
\end{aligned}
\\]

然后也把上式代入\\( E(S^2) \\)，继续推导:
\\[
E[S^2] = \sigma^2 - E[(\bar{X} - \mu)^2] = \sigma^2 - \frac{1}{n}\sigma^2 = \frac{n - 1}{n} \sigma^2
\\]

也就是说：
\\[
\sigma^2 = \frac{n}{n - 1} E[S^2] = \frac{n}{n - 1}E[\frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2] = \frac{1}{n - 1}E[\sum\limits\_{i = 1}^{n}(X_i - \bar{X}^2] 
\\]

这就是分母\\( n - 1 \\)的由来，同时也是为什么\\( \frac{1}{n - 1} \sum\limits\_{i = 1}^{n}(X_i - \bar(X))^2 \\)是样本方差的无偏估计。
