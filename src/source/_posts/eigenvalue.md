title: 奇异值分解及其应用
date: 2018-12-06 21:08:00
tags: 图像处理
---
详述奇异值分解与PCA，最小二乘，数据拟合，3D转换的关系
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 奇异值分解
奇异值分解的目的是将一个\\(m \times n \\)的矩阵\\( A \\)分解成另外三个矩阵\\(U, \Sigma, V^T \\).其中\\(U\\)和\\(V\\)分别为\\(m \times m\\)和\\(n \times n\\)的方阵,
\\(\Sigma\\)为\\(m \times n\\)的矩阵.数学表达形式如下:
\\[
\large
A_{m \times n} = U_{m \times m} \Sigma_{m \times n} V^T_{n \times n}
\\]

## 特征值与特征值分解
谈奇异值之前必须要介绍特征值分解，因为奇异值分解实际是特征值分解的一个扩展.
特征值分解是将一个矩阵分解成他的特征值以及特征向量,先来看特征值与特征向量的定义:
\\[
\large
A \vec{v} = \lambda \vec{v}
\\]
如上式，特征向量就是只矩阵与这个向量运算后得到的向量，只有长度的变化，没有方向的变化。更甚着，这种运算可以理解为矩阵在这个向量上的投影（之后会解释为什么可以理解为投影）。
而且，矩阵的特征向量是不唯一的。如果将矩阵所有特征向量和特征值综合到一起，就可以得到矩阵的特征值分解公式，具体过程如下：
\\[
\begin{split}
& A \vec{v}_1 = \lambda_1 \vec{v}_1 \\\\
& A \vec{v}_2 = \lambda_2 \vec{v}_2 \\\\
& \cdots \\\\
& A \vec{v}_m = \lambda_m \vec{v}_m \\\\
\\\\
 \Rightarrow  & A[\vec{v}_1 \ \vec{v}_2 \ \cdots \vec{v}_m] = [\lambda_1\vec{v}_1 \ \lambda_2\vec{v}_2 \ \cdots \lambda_m\vec{v}_m] \\\\
\Rightarrow & A[\vec{v}_1 \ \vec{v}_2 \ \cdots \vec{v}_m] = \begin{bmatrix}
\lambda_1 & 0 & \cdots & 0\\\\
0 & \lambda_2  & \cdots & 0\\\\
\vdots & \vdots & \ddots & \vdots \\\\
0 & 0 & \cdots & \lambda_m
\end{bmatrix} [\vec{v}_1 \ \vec{v}_2 \ \cdots \vec{v}_m] \\\\
\Rightarrow & AV = \Lambda V,  \quad V = [\vec{v}_1 \ \vec{v}_2 \ \cdots \vec{v}_m], \quad \Lambda = \begin{bmatrix}
\lambda_1 & 0 & \cdots & 0\\\\
0 & \lambda_2  & \cdots & 0\\\\
\vdots & \vdots & \ddots & \vdots \\\\
0 & 0 & \cdots & \lambda_m
\end{bmatrix} 
\end{split} \\\\
\\]
得到\\( AV = \Lambda V \\)后，我们需要讨论下他的一个性质好继续推导


## 奇异值分解与特征值分解


## 奇异值特征值分解的意义

### 向量的内积与投影

### 奇异值分解与矩阵投影



# 奇异值分解的应用


## 奇异分解与主成分分析(PCA)


## 奇异值分解与最小二乘

### 最小二乘法与数据拟合


### 最小二乘法与多项式拟合












# 向量的基，内积与向量投影
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
把上式变的更矩阵化一点，可以得到下式：
\\[
\begin{bmatrix}
1 & 0\\\\
0 & 1
\end{bmatrix} \begin{bmatrix}
3 \\\\
4
\end{bmatrix} = \begin{bmatrix}
3\\\\
4
\end{bmatrix} = \begin{bmatrix}
\frac{3}{5} & \frac{3}{5}\\\\
\frac{4}{5} & -\frac{4}{5}
\end{bmatrix}\begin{bmatrix}
5\\\\
0
\end{bmatrix}
\\]
其中矩阵的每一个行向量都是对应的基向量。
也就是，同一个向量，在不同的基向量下，向量的形式是不同的。而向量中的数字其本质表示的是在对应基向量上的模长。
即:
\\[
\vec{v} = [\vec{v}_1, \vec{v}_2, \cdots, \vec{v}_n] [\lambda_1, \lambda_2, \cdots, \lambda_n]^T
\tag{1}
\\]
也就说，同一个向量，虽然在不用的基下的向量形式不用，但通过上式计算后，都可以得到同一个结果。
例如上面式(1)所示，向量\\( (3,4) \\)在两个不同的基下的最终结果就是相等的。

那么如何得到一个向量在不同基下的形式呢？这里就要使用向量的内积。首先是向量内积的定义：
\\[
\vec{a} \cdot \vec{b}= \sum\limits_{i = 1}^{n} a_ib_i = a_1b_1 + a_2b_2 + \cdots + a_nb_b
\\]
然后我们把内积转化为另一种空间上的形式：
\\[
\vec{a} \cdot \vec{b} = |\vec{a}| |\vec{b}| cos(a)
\\]
接着再进一步，假设\\( |\vec{b}| = 1 \\),也就得到了:
\\[
\vec{a} \cdot \vec{b} = |\vec{a}| cos(a)
\\]
因此可以看出，当基向量的模长为1时，向量与基向量的内积可以理解为了向量的在基向量上投影的模长。
也就如下图：

![盗个图](https://i.ibb.co/5LFKJTk/36936572-25.png)

因此通过向量的内积运算，我们就可以很容易的得到向量在基向量上的投影模长。
即通过向量的内积运算，就可以很容易的将向量在不同基向量上的进行转换。
例如之前的向量\\( (3,4) \\), 在基向量\\( (\frac{3}{5}, \frac{4}{5})  \\)和
\\( (\frac{3}{5}, - \frac{4}{5})  \\)
下的投影也就是表现值就是：
\\[
(3,4)^T \cdot (\frac{3}{5}, \frac{4}{5})^T = 5 \\\\
(3,4)^T \cdot (\frac{3}{5}, \frac{4}{5})^T = 0
\\]
即：
\\[
\begin{bmatrix}
\frac{3}{5} & \frac{3}{5}\\\\
\frac{4}{5} & -\frac{4}{5}
\end{bmatrix}^T \begin{bmatrix}
3\\\\ 
4
\end{bmatrix} = \begin{bmatrix}
5\\\\ 
0
\end{bmatrix}
\\]
也就得到了\\((5,0) \\)这个新的向量。
所以可以看到**向量是可以在不同的基下转换的,而且在不同的基下，向量的形式不一样**.
而将向量转换会标准形式只要需要左乘上这组基向量即可。如下:
\\[
\begin{bmatrix}
\frac{3}{5} & \frac{4}{5} \\\\
\frac{4}{5} & -\frac{3}{5}
\end{bmatrix} \begin{bmatrix}
\frac{3}{5} & \frac{4}{5} \\\\
\frac{4}{5} & -\frac{3}{5}
\end{bmatrix}^T \begin{bmatrix}
3\\\\
4
\end{bmatrix} = \begin{bmatrix}
\frac{3}{5} & \frac{4}{5} \\\\
\frac{4}{5} & -\frac{3}{5}
\end{bmatrix} \begin{bmatrix}
5\\\\
0
\end{bmatrix} = \begin{bmatrix}
3\\\\
4
\end{bmatrix}
\\]

# 特征值与特征向量
之前我们展示了向量是可以投影到另一个向量上的。
那么扩展一下，矩阵是不是也可以投影到一个向量上呢？
答案是肯定的，特征值和特征向量就可以办到。

首先看一下特征向量的定义：
\\[
A\vec{V} = \lambda\vec{V} \\\\
A = P \Lambda P^{-1} 
\\]
上式的几何意义就是矩阵A，在向量\\( \vec{V} \\)只产生拉升变换，而不产生旋转变换。也就是如下图：

![特征向量和特征空间](https://image.ibb.co/ki2JY8/exp3.png)i

似乎是有点抽象，可能会问：这啥玩意儿？这玩意儿有啥用?不要慌，我们来举一个实际的例子.
假设现在有一个点\\(p\\) 和一个矩阵 \\( A \\)。如下：
\\[
p = \begin{bmatrix}
1\\\\
2
\end{bmatrix} \quad A = \begin{bmatrix}
1 & 3\\\\
3 & 1
\end{bmatrix}
\\]
强调一下，这里的\\( p \\)既可以指一个点，同样也可以表示为一个从原点到该点的向量。
接着我把这个点和矩阵运算一下：
\\[
 \begin{bmatrix}
1 & 3\\\\
3 & 1
\end{bmatrix}\begin{bmatrix}
1\\\\
2
\end{bmatrix} = \begin{bmatrix}
7\\\\
5
\end{bmatrix}
\\]
可以看到，矩阵\\( A \\)就是一个把点\\( (1,2) \\)转换到了\\( (7,5)  \\)的运动。

接着，我们把矩阵\\( A \\)进行特征值分解可以得到:


再接着，我们把向量\\( (1,2) \\) 投影到新的基向量上。




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


