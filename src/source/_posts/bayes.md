title: Bayes's Theorem
date: 2018-11-05 16:36:56
tags: 图像处理
---
贝叶斯定理详解，实例以及应用
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

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
注意，一个矩阵可能会有多个特征向量，而且通常情况下**特征向量相互独立**也就是线性无关(为什么无关可以用[反证法](https://zhuanlan.zhihu.com/p/30454490))，就是不同特征向量的乘积为0。
如果把矩阵理解为多维空间的运动，特征向量就是坐标轴了，
那么2维矩阵会有两个，3维矩阵会有三个，特征向量所在直线
就被称为**特征空间**。例如二维矩阵就会有两个，关键在于\\(\vec{v}\\)是把矩阵向左转了
还是向右转了,如下图

![特征向量和特征空间](https://image.ibb.co/ki2JY8/exp3.png)

# 特征向量定义与特征分解公式
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

{% codeblock lang:matlab %}
clear all
close all
clc


num = 3;

mat = rand(num, num);

[row column] = size(mat);

% 将随机矩阵变成对角阵
for i = 1:row
    for j = i:column
        mat(i, j) = mat(j, i);
    end
end

[V D] = eig(mat);


% 验证正交矩阵逆矩阵等于其转置
V*V'
V*V^(-1)

% 验证特征向量两两正交
for i = 1:row
    for j = 1:column
        if i ~= j
            vec1 = V(:, 1);
            vec2 = V(:, 2);

            [i j vec1'*vec2]
        end
    end
end
% 验证对角阵特征值的分解公式 mat = V*D*V'
mat
V*D*V'
V*D*V^(-1)

{% endcodeblock %}

# 奇异值分解
矩阵的特征值分解只能针对方阵，但是现实中，大部分矩阵都不是方阵，而奇异值SVD分解就是为了解决这个问题。

通过之间的特征值分解公式，我们可以将一个对称阵进行特征值分解。那么对于一个非对称阵的矩阵\\(A\\),我们只要将它乘上他的转置就可以将其和矩阵的特征值对应起来：
\\[
(AA^T)V = \lambda V
\\]
这里的\\(V\\)就是右奇异向量，然后再有：

\\[
\sigma_i = \sqrt{\lambda_i} \\\\
\mu_i = \frac{1}{\sigma_i}A v_i
\\]

接着就可以得到奇异值分解的定义:

\\[
A\_{m \times n} = U\_{m \times m} \Sigma\_{m \times n} V\_{n \times n}^T
\\]

# 奇异值分解与矩阵的主成分PCA
一个矩阵可以看作一个运动，一个变换，例如平移矩阵，旋转矩阵之类的。
对于运动，其实是可以分解的，就例如将一个矩阵分解为另外几个矩阵的乘积一样。
而矩阵的奇异值分解，其实是将矩阵分解成了几个特殊的矩阵。第一个是\\(U\\),基向量。
他很重要但是在PCA中应用没有另外两个广泛。所以不不过解释了。
第二个是保存了奇异值的矩阵\\(\Sigma\\),这个矩阵只有对角线上有值，其他的都是0.
这些值就是奇异值，也可以理解为特征值。而对应的第三个\\(V^T\\)就是上一个特征值矩阵中的值
所以分别对应的特征向量。

最后一个矩阵中的特征向量是两两正交的，也就是说矩阵的运动被分解到了一些特定的相互独立的方向上。
而对应的特征值就是在这些方向上的移动距离。所以现在就很容易理解了，当然只有那些移动了特别远的
距离的矩阵，才是矩阵的主要元素。例如运动\\((100, 100, 1)\\)当然是前两个元素才是主要元素。
因此在实际操作时，往往只要取出特征值中的前几个比较大的元素，其实就可以还原出整个矩阵。
因此公式从原来的标准定义：

\\[
A\_{m \times n} = U\_{m \times m} \Sigma\_{m \times n} V\_{n \times n}^T
\\]

就变成了:

\\[
A\_{m \times n} \approx  U\_{m \times r} \Sigma\_{r \times n} V\_{r \times n}^T
\\]

然后利用这种约等于的性质就可以对一副图像进行主成分的提取。例如，这里，我们只使用图像的前10个特征值对图像重构，也就是说\\(r = 10\\)代码如下：

{% codeblock lang:matlab %}
clear all
close all
clc


im = double(imread('./image.jpg'));

gryim = grayImage(im);

[s v d] = svd(gryim);

num = 10;

gryim2 = s(:, :)*v(:, 1:num)*d(:, 1:num)';

figure
displayMatrixImage(1, 1, 2, gryim, gryim2)
{% endcodeblock %}
那么就可以得到下面的效果图：

![图像的主成分分析](https://image.ibb.co/eZsuqy/image.png)

其实到已经可以直接拿奇异值分解来降维了，方法就是只保留前几个特征值大的维度。
但还是介绍下PCA又是怎么和奇异值扯上关系的。
假设当前有很多很多样本，PCA就是希望找到另一个空间（这个空间的维度比原样本的维度低）用于投影，
让数据的之间的方差最大，**也就是让数据的损失最小**。具体可以看下图（盗个图）：

![PCA实例](https://i.stack.imgur.com/Q7HIP.gif)

如果将所有的数据都包含在一个矩阵中，现在想进行PCA降维，那么奇异值就是很好找出这个让数据损失最小的特征空间的方法。
因为将这个矩阵看作运动，那么奇异值可以保证找出运动距离最大的几个方向，而每一个方向因为其相互正交又可以看出各个相互独立的维度，最后一起组成PCA的降维空间。


# PCA降维实例，MNIST数据集。
介绍了足够了原理来，现在开始来实战，怎么得到开始的效果图。这里使用MNIST数据，然后使用Matlab和Python两种语言。

## MNIST数据集
第一步先[下载](http://yann.lecun.com/exdb/mnist/)并准备好MNIST数据集。
下载好了之后，要想办法读取，Matlab和Python版本的读取代码有很多，可自行去网上找，或者自己写（难道不大）。
读取之后，可以显示看看，是否读取正确了，如下图：

![MNIST数据集](https://image.ibb.co/bKfQDJ/image.png)

## 对MNIST数据进行PCA降维
接着对MNIST数据集进行PCA降维。MNIST数据集中包含了数字0-9的手写体。
为了让降维的效果更明显，这里只取数字0和数字1两种图片。代码如下:

{% codeblock lang:matlab %}
imgfiles = '/data/dataset/MNIST/train-images.idx3-ubyte';
labfiles = '/data/dataset/MNIST/train-labels.idx1-ubyte';

% 60000
[imgs labels] = readMNIST(imgfiles, labfiles, 60000, 0);

[row_img column_img frames_img] = size(imgs);

lab1 = 1;
lab0 = 0;

idx1 = labels == lab1;
idx0 = labels == lab0;

imgs1 = imgs(:, :, idx1);
imgs0 = imgs(:, :, idx0);

imgs1 = imgs1(:, :, 1:1000);
imgs0 = imgs0(:, :, 1:1000);
{% endcodeblock %}

然后将顺序打乱，进行svd分解:
{% codeblock lang:matlab %}

imgs = zeros(row_img, column_img, 2000);
imgs(:, :, 1001:2000) = imgs0;
imgs(:, :, 1:1000)   = imgs1;

idx = randperm(2000);
imgs = imgs(:, :, idx);

% data = reshape(imgs, row_img*column_img, frames_img);
data = reshape(imgs, row_img*column_img, 2000);
data = data';

[U S V] = svd(data);

{% endcodeblock %}

然后这个地方，很容易忽视的地方。
按道理说，应该会数据乘上特征值最大的几个特征向量.
也就是应该是 \\(A \times V \\).
但是，我们有奇异值分解的公式:
\\[
A\_{m \times n} = U\_{m \times m} \Sigma\_{m \times n} V\_{n \times n}^T
\\]
因为\\(V\\)是一个正交矩阵，所以有\\(V^{-1} = V^{T}\\)。也就是说：
\\[
\begin{aligned}
A\_{m \times n} &= U\_{m \times m} \Sigma\_{m \times n} V\_{n \times n}^T \Rightarrow \\\\ 
A\_{m \times n} &= U\_{m \times m} \Sigma\_{m \times n} V\_{n \times n}^{-1}  \Rightarrow \\\\ 
A\_{m \times n}  V\_{n \times n}  &= U\_{m \times m} \Sigma\_{m \times n} V\_{n \times n}^{-1}  V\_{n \times n}  \Rightarrow \\\\ 
A\_{m \times n}  V\_{n \times n}  &= U\_{m \times m} \Sigma\_{m \times n} I\_{n \times n}  \Rightarrow \\\\ 
A\_{m \times n}  V\_{n \times n}  &= U\_{m \times m} \Sigma\_{m \times n}   
\end{aligned}
\\]
所以其实\\( U \times S \\)和\\( A \times V\\)是相等。用程序也可以验证出来

{% codeblock lang:matlab %}

num = 2;
newdata = U*S(:, 1:num);
% or newdata = data*V(:,1:num);
{% endcodeblock %}

最后根据不用的标签标上不同的颜色，显示即可
{% codeblock lang:matlab %}
x = newdata(:, 1);
y = newdata(:, 2);


labs1 = zeros(1000, 1);
labs2 = zeros(1000, 1) + 1;

labs = [labs1 ; labs2];

labs = labs(idx);

idx_data = labs == 0;
x0 = x(idx_data);
y0 = y(idx_data);

idx_data = ~idx_data;
x1 = x(idx_data);
y1 = y(idx_data);

figure
plot(x0, y0, 'b.')
hold on
plot(x1, y1, 'r.')
drawnow
{% endcodeblock %}

最后附上python的代码:
{% codeblock lang:python %}

#!/usr/bin/env python


import loadMNIST as lm
import numpy as np
import matplotlib.pyplot as plt
import random


path_labs = '/data/dataset/MNIST/train-labels.idx1-ubyte'
path_imgs = '/data/dataset/MNIST/train-images.idx3-ubyte'

imgs, labs = lm.loadMNIST(path_imgs, path_labs)


imgs0 = [imgs[i, :, :] for i in range(60000) if labs[i] == 0]
imgs0 = np.array(imgs0)

imgs0 = imgs0[0:1000, :, :]


imgs1 = [imgs[i, :, :] for i in range(60000) if labs[i] == 1]
imgs1 = np.array(imgs1)

imgs1 = imgs1[0:1000, :, :]

combimgs = np.zeros(shape=(2000, 28, 28))

combimgs[0:1000, :, :] = imgs0
combimgs[1000:2000, :, :] = imgs1

idx = range(2000)
random.shuffle(idx)

# imgs = np.zeros(shape=(2000, 28, 28))
imgs = [combimgs[i, :, :] for i in idx]
imgs = np.array(imgs)


comblabs = np.zeros(2000)
comblabs[0:1000] = 1;

labs = [comblabs[i] for i in idx]
labs = np.array(labs)


data = np.array([np.array(imgs[i, :, :]).flatten() for i in range(2000)])

U, S, V = np.linalg.svd(data)

row_data, column_data = data.shape

sigma = np.zeros([row_data, column_data])

for i in range(column_data):
    sigma[i][i] = S[i]

tmpdata = np.dot(U, sigma[:, 0:2])
subdata = np.dot(tmpdata, V[0:2, :])


data0 = [tmpdata[i, :] for i in range(2000) if labs[i] == 0]
data0 = np.array(data0)

data1 = [tmpdata[i, :] for i in range(2000) if labs[i] == 1]
data1 = np.array(data1)

plt.figure()
plt.plot(data0[:, 0], data0[:, 1], 'b.')
plt.plot(data1[:, 0], data1[:, 1], 'r.')
plt.show()
{% endcodeblock %}


