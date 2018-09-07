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


