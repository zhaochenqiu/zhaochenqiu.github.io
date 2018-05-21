title: PCA降维分类详解
date: 2018-05-20 14:01:56
tags: 图像处理
---
记录详解PCA的过程与用法
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 效果图
这次使用PCA对[MNIST](http://yann.lecun.com/exdb/mnist/)数据集中数字0和1进行降维分类，分别使用Matlab和Python来实验，结果如下:

![将数字图片降低到两个维度，红点为数字0的图像降维结果，蓝点为数字1的降维结果](https://image.ibb.co/b97PmT/exp1.png)

# 背景知识
## 特征值与特征向量,以及奇异值分解
### 特征值与特征向量定义
特征向量的定义为：\\[A \vec{v} = \lambda \vec{v} \\]
其中\\(\vec{v}\\)就是\\(A\\)就是特征向量,而对应的\\(\lambda\\)就是特征值

在Matlab里使用`eig`函数来求，使用方法为:

    clear all
    close all
    clc

    mat = rand(3,3);
    [V D] = eig(mat); % V 为特征向量,列向量，D为特征值
    
    mat*V(:, 1) - D(1, 1)*V(:, 1)
    mat*V(:, 2) - D(2, 2)*V(:, 2)
    mat*V(:, 3) - D(3, 3)*V(:, 3)
注意，一个矩阵可能会有多个特征向量，而且通常情况下**特征向量相互独立**也就是线性无关(为什么无关可以用[反证法](https://zhuanlan.zhihu.com/p/30454490))，就是不同特征向量的乘积为0。
如果把矩阵理解为多维空间的运动，特征向量就是坐标轴了，
那么2维矩阵会有两个，3维矩阵会有三个，特征向量所在直线
就被称为**特征空间**。例如二维矩阵就会有两个，关键在于\\(\vec{v}\\)是把矩阵向左转了
还是向右转了,如下图

![特征向量和特征空间](https://image.ibb.co/ki2JY8/exp3.png)

### 特征向量定义与特征分解公式
再回到之前的特征向量定义:
\\[A \vec{V} = \lambda \vec{v}  \\]
然后是矩阵特征值分解的公式:
\\[A = P \Lambda P^{-1}  \\]
其中的\\(\Lambda\\)就是矩阵A的特征值，而\\(P^{-1}\\)的列向量就是矩阵的特征向量。

特征向量的定义如何推导出特征值分解公式。
假设\\(A\\)为对角矩阵，那么他肯定是一个[可对角化矩阵](https://zh.wikipedia.org/wiki/%E5%8F%AF%E5%AF%B9%E8%A7%92%E5%8C%96%E7%9F%A9%E9%98%B5)。
那么他的特征向量两两正交。现在假设它有\\(m\\)个不同的特征值为\\(\lambda_i \\),对应的
特征向量为\\(x_i\\)则有:
\\[
Ax_1 = \lambda_1 x_1 \\\\
Ax_2 = \lambda_2 x_2 \\\\
\cdots \\\\
Ax_m = \lambda_m x_m
\\]
进而得到:
\\[AU = U\Lambda \\]
其中
\\[
U = [x_1 x_2 \cdots x_m] \quad \quad
\Lambda = \begin{pmatrix} 
	\lambda_1   & \cdots & 0 \\\\
	\vdots      & \ddots & \vdots \\\\
	0           & \cdots & \lambda_m \\\\
\end{pmatrix}
\\]
最后也就是推出了:
\\[
A = U\Lambda U^{-1} = U\Lambda U^{T}
\\]
其中，由于特征向量两两正交，所以\\(U\\)为[正交阵](https://zh.wikipedia.org/wiki/%E6%AD%A3%E4%BA%A4%E7%9F%A9%E9%98%B5),
正交矩阵的逆等于转置。Matlab的验证程序如下:




一个矩阵可以看作一个运动，
特征向量就是指这个运动的方向，特征值就是在该方向运动的距离.


