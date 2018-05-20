title: PCA降维分类详解
date: 2018-05-20 14:01:56
tags: 图像处理
---
记录详解PCA的过程与用法
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 效果图
这次使用PCA对[MNIST](http://yann.lecun.com/exdb/mnist/)数据集中数字0和1进行降维分类，分别使用Matlab和Python来实验，结果如下:
![将数字图片降低到两个维度，红点为数字0的图像降维结果，蓝点为数字1的降维结果](http://zhaochenqiu.github.io/imgs/pca/exp1.png)

# 背景知识
## 特征值与特征向量,以及奇异值分解
### 特征值与特征向量定义
特征向量的定义为：\\[A \vec{v} = \lambda \vec{v} \\]
其中\\(\vec{v}\\)就是\\(A\\)就是特征向量,而对应的\\(\lambda\\)。

在Matlab里使用`eig`函数来求，使用方法为:

    clear all
    close all
    clc

    mat = rand(3,3);
    [V D] = eig(mat); % V 为特征向量,列向量，D为特征值
    
    mat*V(:, 1) - D(1, 1)*V(:, 1)
    mat*V(:, 2) - D(2, 2)*V(:, 2)
    mat*V(:, 3) - D(3, 3)*V(:, 3)
注意，一个矩阵会有多个特征向量，2维矩阵会有两个，3维矩阵会有三个，夹在特征向量之间的空间
就被称为**特征空间**。例如二维矩阵就会有两个，关键在于\\(\vec{v}\\)是把矩阵向左转了
还是向右转了,如下图
![特征向量和特征空间](http://zhaochenqiu.github.io/imgs/pca/exp2.png)

一个矩阵可以看作一个运动，
特征向量就是指这个运动的方向，特征值就是在该方向运动的距离.


