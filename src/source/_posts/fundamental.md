title: 基本数据处理方法记录
date: 2018-09-06 14:01:56
tags: 图像处理
---
记录常用的基础的数据处理方法
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 均值和方差
假设有随机变量 \\( X = \\{ X_1, X_2, \dots, X_N \\} \\), \\(N\\)该变量产生的**总的样本数量**。
均值和方差计算公式如下：
\\[
\mu = E(X) = \frac{1}{n}\sum\limits\_{i = 1}^{N} X_i \\\\
\sigma^2 = E[(X - \mu)^2] = \frac{1}{n}\sum\limits\_{i = 1}^{N} (X_i - \mu)^2
\\]

接着示例代码如下：

    clear all
    close all
    clc

    num = 50000000;
    mu = 1;
    sigma = 0.5;

    % the sigma^2 instead of sigma is used for generating data 
    data = normrnd(mu, sigma, 1, num);

    mu_calc = 0;
    sigma_calc = 0;

    for i = 1:num
        mu_calc = mu_calc + data(i);
    end

    mu_calc = mu_calc/num;

    for i = 1:num
        sigma_calc = sigma_calc + (data(i) - mu_calc)^2;
    end

    sigma_calc = sigma_calc/num;

    [mu mu_calc sigma sigma_calc^(0.5)]

代码结果输出：

    ans =

        1.0000    0.9999    0.5000    0.4999

    >> 


# 样本方差的无偏估计
现在假设有一个数据个数非常大的随机变量，由于数据个数过大，没有办法直接计算均值和方差，只能进行采样，然后从样本中估计出该变量的均值和方差（统计一亩田中，麦穗中麦子的个数的均值和方差）。
这被称为**样本估计**。但是直接计算出样本的均值和方法的当作随机变的均值和方差是有偏差的，所以要进行**无偏估计**。假设采集到的样本为\\( X = \\{ X_1, X_2, \dots, X_N \\} \\),此时的\\(N\\)
为样本数量。无偏估计公式如下：


\\[
\mu = \bar{X} = \frac{1}{n} \sum\limits\_{i = 1}^{n} X_i
\\]

\\[
\sigma^2 = \frac{1}{n - 1} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2
\\]

示例代码:

    clear all
    close all
    clc

    mu = 1;
    sigma = 0.5;
    num = 1000000;


    data = normrnd(mu, sigma, 1, num);


    n = 10;

    idx = randperm(num);
    data = data(idx);

    sample = data(1:n);
    sample = sample - mean(sample);

    value = sum(sample .* sample);
    value = value/(n - 1);
    str = sprintf('value with 1 time iteration: %f', value);
    disp(str);


    num_sample = 500;
    idxlist = randperm(num);

    result = zeros(1, num_sample);
    for i = 1:num_sample
        idx = idxlist(i*n:i*n + 9);

        sample = data(idx);
        sample = sample - mean(sample);

        value = sum(sample .* sample);
        value = value/(n - 1);
        
        result(i) = value;
    end

    str = sprintf('value with 500 times iteration: %f', mean(result));
    disp(str);

代码结果输出(涉及随机数输出，打印多次结果。):

    value with 1 time iteration: 0.118847
    value with 500 times iteration: 0.243565
    >> exp1
    value with 1 time iteration: 0.171856
    value with 500 times iteration: 0.252303
    >> exp1
    value with 1 time iteration: 0.171001
    value with 500 times iteration: 0.245947
    >> exp1
    value with 1 time iteration: 0.346157
    value with 500 times iteration: 0.254011


# 数据协方差与相关性系数
协方差用于衡量两个变量总体的误差。方差是协方差的一个特殊情况，即两个变量相同的情况。
协方差公式：

\\[
\begin{aligned}
E(X) & = \mu \\\\
E(Y) & = \nu \\\\
cov(X, Y) & = E[(X - \mu)(Y - \nu)] = E(X \cdot Y) - \mu \nu
\end{aligned}
\\]

当两个变量相互独立是，协方差为0，因为：

\\[
E(X \cdot Y) = E(X) \cdot E(Y) = \mu \nu \\
cov(X, Y) = E(X \cdot Y) - \mu \nu = \mu \nu - \mu \nu = 0;
\\]

接着相关性系数\\(\eta\\)计算方法：

\\[
\eta = \frac{cov(X, Y)}{\sqrt{var(X) \cdot var(Y)}}
\\]

协方差示例代码：

    clear all
    close all
    clc

    mu1 = 1.5;
    sigma1 = 2.5;

    mu2 = 20.3;
    sigma2 = 3.6;

    % num1 must equal num2
    num1 = 1000;
    num2 = 1000;

    data1 = normrnd(mu1, sigma1, 1, num1);
    data2 = normrnd(mu2, sigma2, 1, num2);

    value1 = data1 - mean(data1);
    value2 = data2 - mean(data2);

    covvalue = mean(value1 .* value2);
    covvalue

    % 无偏估计，分母用的n - 1
    mat = cov(data1, data2)

    value = mat(1, 2) / (mat(1, 1)*mat(2, 2));
    value

输出结果：

    covvalue =

        0.0394


    mat =

        6.5329    0.0394
        0.0394   12.8252


    value =

       4.7029e-04

    >> 

# 高斯分布相关
如果**随机变量**\\(X\\)服从一个位置参数为\\(\mu\\),尺度参数为\\(\sigma\\)的高斯分布，通常记做：
\\[
X \sim \mathcal{N}(\mu, \sigma^2)
\\]

其概率密度函数为:
\\[
f(x) = \frac{1}{\sigma \sqrt{2 \pi}} e^{-\frac{(x - \mu)^2}{2\sigma^2}}
\\]

接着二维高斯分布，就是两个随机变量的联合分布,假设这两个随机变量为\\(X\\)和\\(Y\\),而且他们相互独立:
\\[
P(XY) = P(X) \times P(Y) = \frac{1}{\sqrt{2 \pi}}e^{-\frac{x^2}{2}} \times \frac{1}{\sqrt{2 \pi}}e^{-\frac{y^2}{2}} = \frac{1}{2\pi} e^{-\frac{x^2 + y^2}{2}}
\\]

最后他们不相互独立的时候，引入协方差,然后扩展到高维形式,\\(X\\)现在变成了一个\\(N\\)维度的随机变量,
即\\(X = \\{ x_1, x_2, \cdots, x_N \\}\\)，然后其概率密度函数为(同时也是高斯函数的一般形式)：
\\[
P(X) = \frac{1}{\sqrt{(2\pi)^k|\Sigma|}} e^{-\frac{1}{2}(X-\mu)^T \Sigma^{-1} (X - \mu) }
\\]

