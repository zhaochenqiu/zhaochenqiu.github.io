title: PCA详解记录
date: 2018-06-01 14:01:56
tags: 机器学习
---
详细记录PCA的过程
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

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
S^2 = \frac{1}{n} \sum\limits\_{i = 1}^{n}(X_i - \mu)^2
\\]

更甚者，我们连\\(\mu\\) 都是不知道的，只知道样本的均值\\( \bar{X}\\),且:

\\[
\bar{X} = \frac{1}{n} \sum\limits\_{i = 1}^{n} X_i
\\]

最后然后\\(S^2\\)的计算公式就变成:

\\[
S^2 = \frac{1}{n - 1} \sum\limits\_{i = 1}^{n}(X_i - \bar{X})^2
\\]

和协方差公式一样，分母变成了\\(n - 1\\),那么为什么要把分母变成\\(n - 1 \\).
在解释之前，先实验验证下，是不是\\( n - 1 \\)比\\(n\\)好.


![将数字图片降低到两个维度，红点为数字0的图像降维结果，蓝点为数字1的降维结果](https://image.ibb.co/b97PmT/exp1.png)






lab里使用`eig`函数来求，使用方法为:
{% codeblock lang:matlab %}
clear all
close all
clc

mat = rand(3,3);
[V D] = eig(mat); % V 为特征向量,列向量，D为特征值

mat*V(:, 1) - D(1, 1)*V(:, 1)
mat*V(:, 2) - D(2, 2)*V(:, 2)
mat*V(:, 3) - D(3, 3)*V(:, 3)
{% endcodeblock %}

