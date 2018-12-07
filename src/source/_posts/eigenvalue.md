title: 奇异值分解详解
date: 2018-12-06 21:08:00
tags: 图像处理
---
奇异值原理详解
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 向量的基，内积分与向量投影
首先给一个普通的向量\\( (3,4)  \\),其中的数字3,4表示的是向量在x轴与y轴上的分量,也就是这个向量在
\\( (1, 0) \\)与\\( (0, 1) \\)方向上的**模长**.所以其实向量可以表达成下面这样：
\\[
(3,4) = 3 \times (1, 0)^T + 4 \times (0, 1)^T
\\]

而\\( (1, 0) \\)与\\( (0, 1) \\)就可以作为\\( (3,4) \\)一个基础。更甚者，所有二维向量其实都可以用
这两个向量通过乘上不用的模来组成，所以这两个向量就是二维向量的一组基。
所以我们也就得到的基向量的定义，**向量空间的基是它的一个特殊的子集，基的元素称为基向量。
向量空间中任意一个元素，都可以唯一地表示成基向量的线性组合。**

但是\\( (1, 0) \\)与\\( (0, 1) \\) 并不是二维向量空间中唯一的基。
其实我们还可以找到另一组基例如\\( (\frac{3}{5}, \frac{4}{5})  \\)和\\( (\frac{3}{5}, - \frac{4}{5})  \\).
而在这组基下，原来的向量\\( (3,4) \\)就变成了\\( (5, 0) \\)，因为:
\\[
5 \times (\frac{3}{5}, \frac{4}{5})^T + 0 \times (\frac{3}{5}, - \frac{4}{5})^T = (3, 4) = 3 \times (1, 0)^T + 4 \times (0, 1)^T
\\]

现在数学化一点，假设两个不用的基为\\(V_1 = \\{ (1,0)^T, (0, 1)^T \\}  \\)和\\(V_2 = \\{(\frac{3}{5}, \frac{4}{5})^T, (\frac{3}{5}, -\frac{4}{5})^T \\}     \\).
在不用的基下，向量的表达形式也就不用。在\\(V_1\\)下为\\( (3,4) \\), 在\\( V_2\\)下为 \\( (5,0) \\)
    





# 效果图
这次使用PCA对[MNIST](http://yann.lecun.com/exdb/mnist/)数据集中数字0和1进行降维分类，分别使用Matlab和Python来实验，结果如下:

![将数字图片降低到两个维度，红点为数字0的图像降维结果，蓝点为数字1的降维结果](https://image.ibb.co/b97PmT/exp1.png)

# 特征值与特征向量定义
特征向量的定义为：\\[A \vec{v} = \lambda \vec{v} \\]
其中\\(\vec{v}\\)就是\\(A\\)就是特征向量,而对应的\\(\lambda\\)就是特征值

在Matlab里使用`eig`函数来求，使用方法为:
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
![图像的主成分分析](https://image.ibb.co/eZsuqy/image.png)


