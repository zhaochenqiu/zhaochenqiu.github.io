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
如上式，特征向量就是指矩阵与这个向量运算后得到的向量，只有长度的变化，没有方向的变化。更甚着，这种运算可以理解为矩阵在这个向量上的投影（之后会解释为什么可以理解为投影）。
而且，矩阵的特征向量是不唯一的。如果将矩阵所有特征向量和特征值综合到一起，就可以得到矩阵的特征值分解公式，具体过程如下：
\\[
\begin{split}
& A \vec{v}_1 = \lambda_1 \vec{v}_1 \\\\
& A \vec{v}_2 = \lambda_2 \vec{v}_2 \\\\
& \cdots \\\\
& A \vec{v}_m = \lambda_m \vec{v}_m \\\\
\\\\
 \Rightarrow  & A[\vec{v}_1 \ \vec{v}_2 \ \cdots \vec{v}_m] = [\lambda_1\vec{v}_1 \ \lambda_2\vec{v}_2 \ \cdots \lambda_m\vec{v}_m] =  \begin{bmatrix}
\lambda_1 v_{1,1} & \lambda_2 v_{1,2} & \cdots & \lambda_m v_{1,m} \\\\
\lambda_1 v_{2,1} & \lambda_2 v_{2,2} & \cdots & \lambda_m v_{2,m} \\\\
\vdots & \vdots & \ddots & \vdots \\\\
\lambda_1 v_{m,1} & \lambda_2 v_{m,2} & \cdots & \lambda_m v_{m,m}
\end{bmatrix} \\\\
& = \begin{bmatrix}
v_{1,1} & v_{1,2} & \cdots & v_{1,m} \\\\
v_{2,1} & v_{2,2} & \cdots & v_{2,m} \\\\
\vdots & \vdots & \ddots & \\\\
v_{m,1} & v_{m,2} & \cdots & v_{m,m}
\end{bmatrix} \begin{bmatrix}
\lambda_1 & 0 & \cdots & 0 \\\\
0 & \lambda_2 & \cdots & 0 \\\\
\vdots & \vdots & \ddots & \vdots \\\\
0 & 0 & \cdots & \lambda_m
\end{bmatrix} \\\\
& = [\vec{v}_1 \ \vec{v}_2 \cdots \vec{v}_m] \begin{bmatrix}
\lambda_1 & 0 & \cdots & 0 \\\\
0 & \lambda_2 & \cdots & 0 \\\\
\vdots & \vdots & \ddots & \vdots \\\\
0 & 0 & \cdots & \lambda_m
\end{bmatrix} \\\\
\Rightarrow & AV = V \Lambda, \quad V = [\vec{v}_1 \ \vec{v}_2 \cdots \vec{v}_m] \quad \Lambda = \begin{bmatrix}
\lambda_1 & 0 & \cdots & 0 \\\\
0 & \lambda_2 & \cdots & 0 \\\\
\vdots & \vdots & \ddots & \vdots \\\\
0 & 0 & \cdots & \lambda_m
\end{bmatrix}  \\\\
\Rightarrow & A = V \Lambda V^{-1} \\\\
\end{split} \\\\
\\]
到这一步已经得到的特征值分解的如下定义：
\\[
A = V \Lambda V^{-1}, \quad V = [\vec{v}_1 \ \vec{v}_2 \cdots \vec{v}_m] \quad \Lambda = \begin{bmatrix}
\lambda_1 & 0 & \cdots & 0 \\\\
0 & \lambda_2 & \cdots & 0 \\\\
\vdots & \vdots & \ddots & \vdots \\\\
0 & 0 & \cdots & \lambda_m
\end{bmatrix} 
\\]
更甚者，**当\\(A\\)是一个实对阵矩阵的时，他不同特征值对应的特征向量两两正交**，也就是说上式的\\(V\\)是一个正交矩阵而且他满秩，
即\\(V^{-1} = V^T \\).所以上式又可以写成：
\\[
\large
A = V \Lambda V^{-1} = V \Lambda V^T
\\]

所以这里，我们就得到了一个线性代数中非常著名的定理.

**当\\(A \\)是一个实对称矩阵时，一定可以找到一个由他特征向量组成的矩阵\\(V\\)，和一个由对应特征值组成的对角矩阵\\(\Lambda\\)，构成如下形式：**
\\[
A = V \Lambda V^{-1} = V \Lambda V^T
\\]

证明上述定理的核心，就是为什么当\\(A\\)是实对称矩阵时，\\(V^{-1} = V^T\\).
为此，需要引入很多其他的证明:

#### 1). A为实对称矩阵时候，一定有n个实数特征值，而且**不同特征值对应的特征向量一定正交.**
首先有实数特征值很容易理解，特征值的计算方法是\\( |A - \lambda I| = 0\\).
该式是一个\\(n \\)阶的多项式,所以一定有\\(n\\)个实数根.也就是说有\\(n\\)个实数的特征值.

当特征值不相等时,即当\\(\lambda_1 \neq \lambda\\),有如下推论:
\\[
\begin{split}
 & A \vec{v}_i = \lambda_i \vec{v}_i \\\\
 & A  \vec{v}_j = \lambda_j \vec{v}_j \\\\ \\\\
\Rightarrow & x_j^T A x_i = x_j^T \lambda_i x_i = \lambda_i x_j^T x_i \\\\
\Rightarrow & \lambda_i x_j^T x_i = x_j^T \lambda_i x_i = x_j^T A x_i = x_j^T A^T x_i \quad :A = A^T \\\\
\Rightarrow & \lambda_i x_j^T x_i =  x_j^T A^T x_i = (A x_j)^T x_i = \lambda_j x_j^T x_i \\\\
\Rightarrow & \lambda_i x_j^T x_i =  \lambda_j x_j^T x_i \\\\
\Rightarrow & (\lambda_i - \lambda_j)x_j^T x_i \\\\ \\\\
\because & \lambda_i \neq \lambda_j  \therefore x_j^Tx_i = 0 \\\\
\Rightarrow & x_j \perp x_i
\end{split}
\\]
这里得到结论：**当特征值不同时，对应的特征向量一定相互正交，也就是相互垂直.**

#### 2). 当特征值相同时，特征向量一定相同,因为：
\\[
\begin{split}
& A \vec{v} = \lambda \vec{v} \\\\
\Rightarrow & A\vec{v} - \lambda \vec{v} = 0 \\\\
\Rightarrow & (A - \lambda I) \vec{v} = 0
\end{split}
\\]
是一个方程组。而且由于\\(A\\)是一个\\(n\\)阶的方阵，所以当\\( \lambda \\)唯一时，方程组的解一定唯一。
也就是说，对于一个方阵，**当特征值确定时，特征向量一定唯一。**

再回到对称矩阵\\(A\\)。这里要分成两步讨论:

1) 当这个矩阵的所有的特征值都不同时，对于的特征向量一定正交。
更甚者，可以将特征向量归一化到模长为1，多余的常数可以存储到特征值中。
所以这个时候\\(V\\)就是一个正交矩阵，而且每一列的向量模长都为1.
所以这个时候，\\(V \times V^T  = I\\),也就是说\\(V^{-1} = V^T \\).

2) 当这个矩阵的特征值出现重根的时候。对应的A矩阵一定不满秩。
因为特征值相同，也就反推出特征向量相同。而对于公式\\(A = V \Lambda V^{-1} \\)对于所有的方阵都实用，
所以重构出来的矩阵A，一定会有4个元素相等，如下:
\\[
\begin{bmatrix}
\ddots & \vdots &  & \vdots &  \\\\
\cdots & \lambda_i \vec{v}_i \vec{v}_i^T & \cdots & \lambda_i \vec{v}_i \vec{v}_j^T & \cdots \\\\ 
 & \vdots &  & \vdots &  \\\\ 
\cdots & \lambda_j \vec{v}_i \vec{v}_j^T & \cdots & \lambda_j \vec{v}_j \vec{v}_j^T & \cdots \\\\
  & \vdots &  & \vdots & \ddots
\end{bmatrix}
\\]
也就是推出有两个行向量是线性相关的。所以他就不满秩。
而对于不满秩的部分，可以用0特征值来补全\\(\Lambda\\)矩阵，对应的\\(V\\)中的就用一个很其他所有特征向量的正交的向量。
由于\\(A\\)是方阵，所以它是一个\\(R^m\\)的空间，肯定存在\\(m\\)个相互正交的向量。
因此一定找得到足够数量的相互正交的向量来填充\\(V\\)矩阵，使得V变成一个相互正交的矩阵，也就是\\(V^{-1} = V^T\\).

综上，**只要\\(A\\)是一个实对称矩阵（不一定需要满秩）,一定找得到合适的\\(V\\)和\\(\Lambda\\)
使得\\(A = V \Lambda V^T \\)满足。而且非0不重复特征值数量一定是\\(A\\)的秩的个数.**

## 奇异值分解与特征值分解
已经证明出来，对于一个任意对角方阵，一定可以找出合适的\\(V\\)和\\(Lambda\\)使得下式成立：
\\[
A = V \Lambda V^T
\\]
那么对已一个任意的矩阵，能不能将其拆分成该形式呢？答案是肯定的，奇异值分解就是为了达到这一目的.

现在假设有任意矩阵\\(A \\)，\\(A^T A \\)一定是一个实对称矩阵。
因此，对于\\(A^T A\\)，我们可以进行特征值分解，得到结果如下：
\\[
A^T A = V \Lambda V^T
\\]
得到上述结果后\\(V\\)的行向量可以拆分成一组正交基\\(\\{ \vec{v}\_1, \vec{v}\_2 \cdots \vec{v}\_n \\}\\)而且这组正交基一定有如下性质：
\\[
(A^T A) \vec{v}\_i = \lambda_i \vec{v}\_i
\\]
然后我们来验证下\\(A \vec{v}\_i \\), 和\\(A \vec{v}\_j \\)的正交性：
\\[
\begin{split}
(A \vec{v}\_i, A \vec{v}\_j) & = (A \vec{v}\_i)^T A \vec{v}\_j \\\\
& = \vec{v}\_i^T A^T A \vec{v}\_j \\\\
& = \vec{v}\_i^T (A^T A \vec{v}\_j) \\\\
& = \vec{v}\_i^T ( \lambda_j \vec{v}\_j ) \\\\
& = \lambda_j \vec{v}\_i^T \vec{v}\_j \\\\
& = 0
\end{split}
\\]
这样，我们又得到了另一组正交基\\(\\{ A\vec{v}\_1, A\vec{v}\_2 \cdots A\vec{v}\_n \\}\\).接着我们将这组正交基标准化：
\\[
\begin{split}
& \vec{u}_i = \frac{A \vec{v}_i}{|A \vec{v}_i|} = \frac{1}{\lambda_i} A \vec{v}_i \\\\
\Rightarrow & A \vec{v}_i = \sqrt{\lambda_i} \vec{u}_i \\\\
& \because |A \vec{v}_i|^2 = \lambda_i \vec{v}_i^T \vec{v}_i = \lambda_i \\\\
& \therefore |A \vec{v}_i| = \sqrt{\lambda_i} = \delta_i \\\\
\Rightarrow & A \vec{v}_i = \delta_i \vec{u}\_i
\end{split}
\\]
接着继续推导：
\\[
\begin{split}
A V &  = A(\vec{v}_1, \vec{v}_2, \cdots, \vec{v}_r) = (A\vec{v}_1, A\vec{v}_2, \cdots, A\vec{v}_r, 0, \cdots, 0) \\\\
& = (\delta_1 \vec{u}_1, \delta_2 \vec{u}_2, \cdots, \delta_r \vec{u}\_r, 0, \cdots, 0 ) = U \Sigma \\\\
\Rightarrow & A = U \Sigma V^T
\end{split}
\\]
如此，我们就得到的奇异值分解的公式：
\\[
A = U \Sigma V^T
\\]
其中，右奇异向量\\(V\\)为\\(A^T A\\)的特征向量。
奇异值\\(\Sigma\\)为\\(A^T A\\)的特征值开根号。
左奇异向量为\\( \frac{1}{\sqrt{\lambda_i}}A \vec{v}\_i \\).

## 奇异值特征值分解的意义
接着我们来讨论，奇异值与特征值分解究竟有什么意义。两者的本质都是矩阵与向量的投影。

### 向量基的内积与投影
首先我们来讨论矩阵运算的本质，首先要来讨论向量的内积的意义。
先给一个普通的向量\\( (4,3)  \\),其中的数字4,3表示的是向量在x轴与y轴上的分量,也就是这个向量在
\\( (1, 0) \\)与\\( (0, 1) \\)方向上的**模长**.所以其实向量可以表达成下面这样：
\\[
(4,3)^T = 4 \times (1, 0)^T + 3 \times (0, 1)^T
\\]

而\\( (1, 0)^T \\)与\\( (0, 1)^T \\)就可以作为\\( (4,3)^T \\)一个基础。更甚者，所有二维向量其实都可以用
这两个向量通过乘上不用的模来组成，所以这两个向量就是二维向量的一组基。
所以我们也就得到的基向量的定义，**向量空间的基是它的一个特殊的子集，基的元素称为基向量。
向量空间中任意一个元素，都可以唯一地表示成基向量的线性组合。**

但是\\( (1, 0)^T \\)与\\( (0, 1)^T \\) 并不是二维向量空间中唯一的基。
其实我们还可以找到另一组基例如\\( (\frac{3}{5}, -\frac{4}{5})^T  \\)和\\( (\frac{4}{5}, \frac{3}{5})^T  \\).
而在这组基下，原来的向量\\( (4,3)^T \\)就变成了\\( (0, 5)^T \\)，因为:
\\[
0 \times (\frac{3}{5}, - \frac{4}{5})^T + 5 \times (\frac{4}{5}, \frac{3}{5})^T = (4, 3)^T = 4 \times (1, 0)^T + 3 \times (0, 1)^T
\\]
同一个向量，在不同的基向量下，向量的形式是不同的。而向量中的数字其本质表示的是在对应基向量上的模长。
即:
\\[
\vec{v} = [\vec{v}_1, \vec{v}_2, \cdots, \vec{v}_n] [\lambda_1, \lambda_2, \cdots, \lambda_n]^T
\tag{1}
\\]
也就说，同一个向量，虽然在不用的基下的向量形式不用，但通过上式计算后，都可以得到同一个结果。
例如上面式(1)所示，向量\\( (4,3) \\)在两个不同的基下的最终结果就是相等的。

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
例如之前的向量\\( (4,3) \\), 在基向量\\( (\frac{3}{5}, -\frac{4}{5})  \\)和
\\( (\frac{4}{5}, \frac{3}{5})  \\)
下的投影也就是表现值就是：
\\[
\begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}^T \begin{bmatrix}
4\\\\ 
3
\end{bmatrix} = \begin{bmatrix}
0\\\\ 
5
\end{bmatrix}
\\]
也就得到了\\((0,5) \\)这个新的向量。
所以可以看到**向量是可以在不同的基下转换的,而且在不同的基下，向量的形式不一样**.
而将向量转换回标准形式只要需要左乘上这组基向量即可。如下:
\\[
\tag{2}
\begin{bmatrix}
\frac{3}{5} & \frac{4}{5} \\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}
\begin{bmatrix}
\frac{3}{5} & \frac{4}{5} \\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}^T \begin{bmatrix}
4\\\\
3
\end{bmatrix} = \begin{bmatrix}
\frac{3}{5} & \frac{4}{5} \\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}\begin{bmatrix}
0 \\\\
5
\end{bmatrix} = \begin{bmatrix} 
4 \\\\
3
\end{bmatrix}
\\]
至此，我知道，向量的内积运算，其本质其实就是**向量的投影。**

### 奇异值分解与矩阵投影
再理解了内积的本质是投影之后，我们回到矩阵来。
矩阵的本质其实是用来描述线性变换的。
举一个实际的例子.
假设现在有一个点\\(p\\) 和一个矩阵 \\( A \\) (暂时不要吐槽这个矩阵为什么这么奇怪，之后就会明白)。如下：
\\[
p = \begin{bmatrix}
4\\\\
3
\end{bmatrix} \quad A = \begin{bmatrix}
3.64 & -0.48 \\\\
-0.48 & 3.64
\end{bmatrix}
\\]
强调一下，这里的\\( p \\)既可以指一个点，同样也可以表示为一个从原点到该点的向量。
接着我把这个点和矩阵运算一下：
\\[
 \begin{bmatrix}
3.64 & -0.48 \\\\
-0.48 & 3.64
\end{bmatrix}\begin{bmatrix}
4\\\\
3
\end{bmatrix} = \begin{bmatrix}
12\\\\
9
\end{bmatrix}
\\]
可以看到，矩阵\\( A \\)就是一个把点\\( (4,3) \\)转换到了\\( (12,9)  \\)的线性变换。
接着，我们来做一个有意思的事情，把矩阵A进行特征值分解，结果如下：
\\[
A = \begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}\begin{bmatrix}
4 & 0\\\\
0 & 3
\end{bmatrix}\begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}^T
\\]
分解之后再进行运算：
\\[
\begin{split}
& \begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}\begin{bmatrix}
4 & 0\\\\
0 & 3
\end{bmatrix}\begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}^T \begin{bmatrix}
4 \\\\
3 \end{bmatrix}
\\\\  = &
\begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix}\begin{bmatrix}
4 & 0\\\\
0 & 3
\end{bmatrix} \begin{bmatrix}
0 \\\\
5 \end{bmatrix}
\\\\ = &
\begin{bmatrix}
\frac{3}{5} & \frac{4}{5}\\\\
-\frac{4}{5} & \frac{3}{5}
\end{bmatrix} \begin{bmatrix}
0 \\\\
15 \end{bmatrix}
\\\\ = &
 \begin{bmatrix}
12 \\\\
9 \end{bmatrix}
\end{split}
\\]
惊喜不惊喜，是不是和向量内积的式(2)过程非常相似！



特征值，奇异值分解的定义：
\\[
A \vec{v} = \lambda \vec{v}
\\]
这个矩阵内积运算后，依然是这个向量的方向。
也就是说矩阵A，在向量\\( \vec{V} \\)只产生拉升变换，而不产生旋转变换。也就是如下图：

![特征向量和特征空间](https://image.ibb.co/ki2JY8/exp3.png)

似乎是有点抽象，我们来

接着，我们把矩阵\\( A \\)进行特征值分解可以得到:


再接着，我们把向量\\( (1,2) \\) 投影到新的基向量上。




# 奇异值分解的应用


## 奇异分解与主成分分析(PCA)


## 奇异值分解与最小二乘

### 最小二乘法与数据拟合


### 最小二乘法与多项式拟合












# 向量的基，内积与向量投影
# 特征值与特征向量
之前我们展示了向量是可以投影到另一个向量上的。
那么扩展一下，矩阵是不是也可以投影到一个向量上呢？
答案是肯定的，特征值和特征向量就可以办到。

首先看一下特征向量的定义：
\\[
A\vec{V} = \lambda\vec{V} \\\\
A = P \Lambda P^{-1} 
\\]
上式的几何意义就是
