title: 卷积神经网络笔记一：反向传播
date: 2019-12-28 06:06:08
tags: deep learning
---
反向传播详解，从理论到实践
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>


# 链式法则(Chain Rule)
微积分的链式法则(Chain Rule)是神经网络反向修正的核心。神经网络的每一层可以单独看成一个函数，
每一个函数的输出是下一个函数的输入。而链式法则就是用来求出这些嵌套在一起的函数的导数，
继而得到对应的梯度(gradient)来修正网络。
假设现有函数：\\( z = f(g(x)) \\),x是输入，z是输出。
那么z对于x的梯度，也就是z对x求导过程如下：
\\[
\begin{split}
\frac{dz}{dx} & = \frac{df(g(x))}{dx} = \frac{df(g(x))}{dg(x)}\cdot \frac{dg(x)}{dx} = f'(g(x))\cdot g'(x) \\\\
\Rightarrow  & (f(g(x)))' = f'(g(x))\cdot g'(x)
\end{split}
\\]
通过上式就可以得到x的梯度并用来修正，使得z最终趋近于0.
此外，如果把\\( z = f(g(x)) \\) 看成一个只有两层的网络（g和f），
上式中，首先是求出了f的导数，也就是最后一层的导数，接着乘上了g的导数，也就是上一层的导数，得到了用于修正的梯度（gradient）。
也就是说**每一层用于修正网络的梯度，都依赖下一层的梯度。为了修正整个网络要从后向前，先求最后一层的梯度，然后是倒数第二层，接着导数第三层。**
这样做的好处是为了避免重复计算。因为如果从前向后修正，根据链式法则(chain rule)计算第一层的梯度的时候，实际上是得到了之后所有层梯度的,所以计算复杂度实际成了\\(N!\\).
但是如果是反向修正的话，就使得复杂度变成了\\(N\\).正是链式法则如此完美的应用，使得神经网络的修正变成简洁高效.更多这方面的细节可以参考[深度学习之美](https://book.douban.com/subject/30255692//).


## Chain Rule and Jacobian-vector product
链式法则是一个一般性规则。具体实施还需要介绍Jacobian矩阵，因为神经网络都是用向量交互的。
简单的说，Jacobian矩阵就是一个包含了两个向量元素之间所有可能的偏导的矩阵,他被认为两个向量之间的梯度。
例如，假设有向量\\(X = [x_1, x_2, \cdots, x_n ] \\)用来计算另一个向量 \\( f(X)=[f_1, f_2, \cdots, f_n] \\)，通过一个函数f。
Jacobian矩阵\\( (J) \\)就长下面这个样子:
\\[
J = [ \frac{\partial f}{\partial x_1} \ \cdots \ \frac{\partial f}{\partial x_n}] = \begin{bmatrix}
\frac{\partial f_1}{\partial x_1} & \cdots & \frac{\partial f_1}{\partial x_n} \\\\
\vdots & \ddots  &\vdots \\\\
\frac{\partial f_m}{\partial x_1} &\cdots  & \frac{\partial f_m}{\partial x_n}
\end{bmatrix}
\\]

当然Jaobian矩阵也适用于链式法则。假设有一个X用于计算Y，然后Y又用来计算一个标量l。
假设Y对l的梯度是：
\\[
v = \left ( \frac{\partial l}{\partial y_1} \ \cdots \frac{\partial l}{\partial y_m} \right )^T
\\]

X对已l的梯度就可以通过如下计算：
\\[
J\cdot v = \begin{pmatrix}
\frac{\partial y_1}{\partial x_1} & \cdots & \frac{\partial y_m}{\partial x_1}\\\\
\vdots & \ddots & \vdots \\\\
\frac{\partial y_1}{\partial x_n} & \cdots & \frac{\partial y_m}{\partial x_n}
\end{pmatrix} \begin{pmatrix}
\frac{\partial l}{\partial y_1}\\\\
\vdots \\\\
\frac{\partial l}{\partial y_m}
\end{pmatrix} = \begin{pmatrix}
\frac{\partial l}{\partial x_1}\\\\
\vdots \\\\
\frac{\partial l}{\partial x_n}
\end{pmatrix}
\\]


# 矩阵乘法的反向修正
首先来简化问题，神经网络的大部分操作都可以简化矩阵运算，所以先讨论矩阵运算，
也就是线性变换的反向修正（The backpropagation for Matrix multiplication)

先来一个最简单的例子，假设\\( X = [x_1, x_2] \\), 和\\( W = [w_1, w_2]^T \\)
两个运算得到\\( Z = XW = x_1 w_1 + x_2 w_2\\)。之后Z在进行之后的操作得到loss。
假设从loss到Z之的梯度（gradient）是\\( \frac{\partial (Loss)}{\partial Z} \\).
根据链式法则（Chain Rule），X的更新梯度和W的更新梯度可以通过下面的方式计算得到：

\\[
\left.
\begin{matrix}
\frac{\partial (Loss)}{\partial x_1} = \frac{\partial Z}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial Z} = w_1 \cdot \frac{\partial (Loss)}{\partial Z} \\\\
\frac{\partial (Loss)}{\partial x_2} = \frac{\partial Z}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial Z} = w_2  \cdot \frac{\partial (Loss)}{\partial Z} 
\end{matrix} \right \\} \Rightarrow \triangledown_X(loss) = W^T \frac{\partial (Loss)}{\partial Z} = [w_1 \ w_2] \frac{\partial (Loss)}{\partial Z} \\\\
\left. \begin{matrix}
\frac{\partial (Loss)}{\partial w_1} = \frac{\partial Z}{\partial w_1} \cdot \frac{\partial (Loss)}{\partial Z} = x_1 \cdot \frac{\partial (Loss)}{\partial Z} \\\\
\frac{\partial (Loss)}{\partial w_2} = \frac{\partial Z}{\partial w_2} \cdot \frac{\partial (Loss)}{\partial Z} = x_2  \cdot \frac{\partial (Loss)}{\partial Z} \end{matrix} \right \\} 
\Rightarrow \triangledown_W(loss) = X^T \frac{\partial (Loss)}{\partial Z} = \left [ \begin{matrix} x_1 \\\\ x_2 \end{matrix} \right ] \frac{\partial (Loss)}{\partial Z}
\\]
注意一下，X是一个一行两列的，而W是一个两行一列的向量。根据上面给出的gradient可以慢慢的把loss修正到最小值

接下来是一个复杂一点的例子,X,W,Z的表达式如下:

\\[
X= [x_1 \ x_2], \quad W = \left[ \begin{matrix} w_{1,1} & w_{1,2} & w_{1,3} \\\\
w_{2,1} & w_{2,2} & w_{2,3}
\end{matrix} \right ], \quad Z = [z_1 \ z_2 \ z_3] \\\\
\Rightarrow Z = XW \equiv [x_1 \ x_2] \cdot \left[ \begin{matrix}
w_{1,1} & w_{1,2} & w_{1,3} \\\\
w_{2,1} & w_{2,2} & w_{2,3}
\end{matrix}
\right ] = [z_1 \ z_2 \ z_3] \equiv
\left \\{ \begin{matrix}
z_1 = x_1 w\_{1,1} + x_2 w\_{2,1} \\\\
z_2 = x_1 w\_{1,2} + x_2 w\_{2,2} \\\\
z_3 = x_1 w\_{1,3} + x_2 w\_{2,3}
\end{matrix} \right.
\\]
因为这里的Z变成了有三个元素的向量，所以X的中每一个个元素的梯度，都会被这三个影响。
对于\\(x_1 \\)和\\( x_2 \\)的梯度就是:

\\[
\frac{\partial (Loss)}{\partial x_1} = \frac{\partial z_1}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial z_1} + \frac{\partial z_2}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial z_2} + \frac{\partial z_3}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial z_3} \\\\
\frac{\partial (Loss)}{\partial x_2} = \frac{\partial z_1}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_1} + \frac{\partial z_2}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_2} + \frac{\partial z_3}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_3}
\\]
这里讨论一个事情，为什么Z的三个元素对\\( x_1 \\)作用的综合要使用加法呢？
意思是，为什么上面式子中的三个梯度\\( \frac{\partial z_1}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_1} \\) \\( \frac{\partial z_2}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_2}\\) \\( \frac{\partial z_3}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_3} \\)
要**加**在一起呢? 为什么不乘在一起呢？就算加的话，可以在每一个分量前加个权重吗？

之所以加在一起，本质原因是因为这是一个矩阵运算，而且矩阵本质是一个线性变化，所以使用加法这种线性的变换的方法。这是最直观的解释。
又因为向量中每一个元素的重要性都是一样的，所以由他们提供的梯度的权重也应该是一样的，这就是为什么他们是简单的相加。其实就是权重相等且为1的加权求和。
当然，在一些特殊的情况下(样本不平衡)，人为的去调整其权重也是可以的，这也就是为什么python里的特定标签更新loss的时候是可以带权重的。
再者，就算不同z的权重不一样，w也可以调整来适应，所以直接相加是没有问题的。
还有就是loss是被x通过\\(z_1, z_2, z_3 \\)来影响的，所以反向影响回去也是可以理解的。

然后把上面式子的对应变量带入：
\\[
\begin{split}
\frac{\partial (Loss)}{\partial x_1} = & \frac{\partial z_1}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial z_1} + \frac{\partial z_2}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial z_2} + \frac{\partial z_3}{\partial x_1} \cdot \frac{\partial (Loss)}{\partial z_3} \\\\
= & w_{1,1} \cdot \frac{\partial (Loss)}{\partial z_1} + w_{1,2} \cdot \frac{\partial (Loss)}{\partial z_2} + w_{1,3} \cdot \frac{\partial (Loss)}{\partial z_3}
\\\\
\frac{\partial (Loss)}{\partial x_2} = & \frac{\partial z_1}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_1} + \frac{\partial z_2}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_2} + \frac{\partial z_3}{\partial x_2} \cdot \frac{\partial (Loss)}{\partial z_3}
\ \\\\
= & w_{2,1} \cdot \frac{\partial (Loss)}{\partial z_1} + w_{2,2} \cdot \frac{\partial (Loss)}{\partial z_2} + w_{2,3} \cdot \frac{\partial (Loss)}{\partial z_3}
\end{split} \\\\
\Rightarrow 
[\frac{\partial (Loss)}{\partial x_1} \ \frac{\partial (Loss)}{\partial x_2}] = [\frac{\partial (Loss)}{\partial z_1} \ \frac{\partial (Loss)}{\partial z_2} \ \frac{\partial (Loss)}{\partial z_3}]  \left[ \begin{matrix} w_{1,1} & w_{2,1} \\\\
w_{1,2} & w_{2,2} \\\\
w_{1,3} & w_{2,3}
\end{matrix} \right ]
\\]

同理W对应的梯度(gradient)就是:
\\[
\begin{split}
\frac{\partial (Loss)}{\partial w\_{1,1}}& = \frac{\partial z_1}{\partial w\_{1,1}} \cdot \frac{\partial (Loss)}{\partial z_1} + \frac{\partial z_2}{\partial w\_{1,1}} \cdot \frac{\partial (Loss)}{\partial z_2} + \frac{\partial z_3}{\partial w\_{1,1}} \cdot \frac{\partial (Loss)}{\partial z_3} \\\\
& = x_1 \cdot \frac{\partial (Loss)}{\partial z_1} \quad \because \frac{\partial z_2}{\partial w\_{1,1}}, \frac{\partial z_3}{\partial w\_{1,1}}  = 0 \\\\
\frac{\partial (Loss)}{\partial w_{1,2}} & = x_1 \cdot \frac{\partial (Loss)}{\partial z_2}\\\\
\frac{\partial (Loss)}{\partial w_{1,3}} & = x_1 \cdot \frac{\partial (Loss)}{\partial z_3}\\\\
\frac{\partial (Loss)}{\partial w_{2,1}} & = x_2 \cdot \frac{\partial (Loss)}{\partial z_1}\\\\
\frac{\partial (Loss)}{\partial w_{2,2}} & = x_2 \cdot \frac{\partial (Loss)}{\partial z_2}\\\\
\frac{\partial (Loss)}{\partial w_{2,3}} & = x_2 \cdot \frac{\partial (Loss)}{\partial z_3} \\\\
\end{split} \\\\
\begin{split}
\Rightarrow & \left [ \begin{matrix} \frac{\partial (Loss)}{\partial w\_{1,1}} & \frac{\partial (Loss)}{\partial w\_{1,2}} & \frac{\partial (Loss)}{\partial w\_{1,3}} \\\\
\frac{\partial (Loss)}{\partial w\_{2,1}} & \frac{\partial (Loss)}{\partial w\_{2,2}} & \frac{\partial (Loss)}{\partial w\_{2,3}}
\end{matrix} \right ] = \left [  \begin{matrix} x_1 \\ x_2  \end{matrix} \right ] \cdot [\frac{\partial (Loss)}{\partial z_1} \  \frac{\partial (Loss)}{\partial z_2} \ \frac{\partial (Loss)}{\partial z_3}]  \\\\
 = & \left [ \begin{matrix} x_1 \cdot \frac{\partial (Loss)}{\partial z_1} & x_1 \cdot \frac{\partial (Loss)}{\partial z_2} & x_1 \cdot \frac{\partial (Loss)}{\partial z_3} \\\\
 x_2 \cdot \frac{\partial (Loss)}{\partial z_1} & x_2 \cdot \frac{\partial (Loss)}{\partial z_2} & x_2 \cdot \frac{\partial (Loss)}{\partial z_3}
 \end{matrix} \right ]
 \end{split}
\\]

接着把上面的X和W的式子整理一下，变成矩阵乘法的形式,得到的结果如下：
\\[
\left \\{
\begin{matrix}
\triangledown_X(Loss) = \triangledown_Z(Loss)W^T \\\\
\triangledown_W(Loss) =X^T \triangledown_Z(Loss) 
\end{matrix} \right. 
\Rightarrow \left \\{ \begin{matrix}
\delta X = \delta ZW^T \\\\
\delta W = X^T \delta Z
\end{matrix} \right. \\\\
\ \\\\
\because \text{Using short notation:} \quad \delta S \equiv \triangledown_S(Loss)
\\]



要怎么去理解这个式子呢？
首先他是一个线性运算，而要得到这个线性运算的反向修正的过程，这个过程和他的逆过程，也就是逆矩阵很相似。
线性运算的顺着过去和他逆过来其实是一个 正反的关系。
你要的是后面对前面的贡献，所以使用左逆和右逆的过程，但是配合的是转置。这样可以让矩阵的整个运算反过来。
加上运算的输入本身是一个偏导，所以上式，其实就是一个反过来的计算。
而要反过来计算，自然和矩阵的逆运算是相似的。
这也就是为什么它是在矩阵运算左逆和右逆的位置，换成了转置。

接着附上式子的数学理解，如下：

\\[
\begin{split}
\delta x_i  & = \sum\limits_k \frac{\partial z_k}{\partial x_i} \cdot \frac{\partial (Loss)}{\partial z_k} =  \sum\limits_k \underbrace{ \frac{\partial (\sum\limits_j x_j \cdot w_{j,k})}{\partial x_i} }_{\because z_k= \sum\limits_j x_j \cdot w_{j,k}} \cdot \frac{\partial (Loss)}{\partial z_k} \\\\
& = \sum\limits_k \underbrace{ w_{i,k}}_{\because \frac{\partial (\sum\limits_j x_j \cdot w_{j,k})}{\partial x_i} =w_{}i,k} \cdot \frac{\partial (Loss)}{\partial z_k} = \sum\limits_k w_{i,k} \delta z_k \\\\
\Rightarrow & \delta X = \delta Z W^T \\\\
\delta w_{i,j} & = \sum\limits_k \frac{\partial z_k}{\partial w_{i,j}}\cdot \frac{\partial (Loss)}{\partial z_k} = \sum\limits \frac{\partial \sum\limits_m x_m \cdot w_{m,k} }{\partial w_{i,j} } \delta z_k = x_i \delta z_j \\\\
\Rightarrow & \delta W = X^T \delta Z
\end{split}
\\]

矩阵乘法之外，还有一个增加的量b。跟上面一样的方法。
这次假设X为\\( 2 \times 8 \\)的矩阵，b为\\( 1 \times 8 \\)的矩阵，Z = X + b为\\( 2 \times 8 \\)的矩阵。
b的gradient推导过程:
\\[
\begin{split}
\delta b_i & = \sum\limits_k \sum\limits_l \frac{\partial z_{k,l}}{\partial b_i} \cdot \frac{\partial (Loss)}{\partial z_{k,l}} = \sum\limits_k \sum\limits_l \frac{[x_{k,l} + b_l]}{\partial b_i} \cdot \frac{\partial (Loss)}{\partial z_{k,l}} \\\\
& = \sum\limits_k \sum\limits_l 1 \cdot \frac{\partial (Loss)}{\partial z_{k,l}} = \delta z_{k,i} \\\\
\Rightarrow & \quad \delta b = \sum\limits_k \delta z_k,:
\end{split}
\\]

同理，X的梯度，之所以要X的梯度，是为了上一步的修正，因为针对上一步，X就变成了Z.

\\[
\begin{split}
\delta x\_{i,j} & = \sum\limits_k \sum\limits_l \frac{\partial z\_{k,l}}{\partial x\_{i,j}} \cdot \delta z\_{k,l} = \sum\limits_k \sum\limits_l \frac{\partial [x\_{k,l} + b_k]}{\partial x\_{i,j}} \cdot \delta z\_{k,l} = \delta z\_{i,j} \\\\
\Rightarrow  \delta X & = \delta Z  \quad \because \frac{\partial [x\_{k,l} + b_k]}{\partial x\_{i,j}} = 
\left \\{ \begin{matrix} 1, \quad if k =i, l = j \\ 0, \quad \quad \ otherwise  \end{matrix} \right .
\end{split}
\\]

Sigmoid 函数 \\( \sigma(x) = (\frac{1}{1 + e^{-x}}) \\) 的梯度:
\\[
\begin{aligned}
\delta x_{i,j} & = \frac{dz_{i,j}}{dx_{i,j}}\delta z_{i,j} = \frac{d\sigma(x_{i,j})}{d x_{i,j}} \delta z_{i,j} = \sigma(x_{i,j})(1 - \sigma(x_{i,j})) \delta z_{i,j} \\\\
\because \sigma'(x) & = (\frac{1}{1 + e^{-x}})' \\\\
& = \frac{e^{-x}}{(1 + e^{-x})^2} \\\\
& = \frac{1 + e^{-x} - 1}{(1 + e^{-x})^2} \\\\
& = \frac{1 + e^{-x}}{(1 + e^{-x})^2} - \frac{1}{ (1 + e^{-x})^2  } \\\\
& = \frac{1}{1 + e^{-x}} - \frac{1}{1 + e^{-x}} \times \frac{1}{1 + e^{-x}} \\\\
& = \frac{1}{1 + e^{-x}} (1 - \frac{1}{1 + e^{-x}}) \\\\
& = \sigma(z)(1 - \sigma(z))
\end{aligned}
\\]

Euclidean loss function的梯度：

\\[
\begin{split}
Loss(Y^p, Y) & = \frac{1}{2} || Y^p - Y|| = \frac{1}{2} \sum\limits_i(Y_i^p - Y_i)^2  \\\\
\delta y_i^p & = \frac{\partial (\frac{1}{2} \sum\limits_i(y_i^p - y_i)^2)}{\partial y_i^p} = y_i^p - y_i \\\\
\Rightarrow \delta Y^p & = Y^p - Y
\end{split}
\\]

接着来实用一下，来修正一个XOR的神经网络，网络的运算与修正如下:

\\[
\begin{array}{l}
X  \in H_{4 \times 2}  & W_1 \in H_{2 \times 8} \\\\
Z_1  = X \cdot W_1 \in H_{4 \times 8} & b_1 \in H_{1 \times 8}\\\\
Z_2  = Z_1 + b_1 \in H_{4 \times 8} & \\\\
Z_3 = \sigma(Z_2) \in H_{4 \times 8} & W_2 \in H_{8 \times 1} \\\\
Z_4 = Z_3 \cdot W_2 \in H_{4 \times 1}
 & b_2 \in 1 \times 1 \\\\
 Z_5 = Z_4 + b_2 \in H_{4 \times 1} & \\\\
 Y^p = \sigma(Z_5) \in H_{4 \times 1} & \\\\
 Loss = \frac{1}{2} \cdot (Y^p - Y)^2
 \\\\
 \\\\
 \\\\
 \\\\
 \delta Y^p = Y^p - Y   & \\\\
 \delta Z_5 = \sigma(Z_5)(1 - \sigma(Z_5)) \delta Y^p & \\\\
 \delta Z_4 = \delta Z_5 & \delta b_2 = \sum\limits_k(\delta Z_5)_k \\\\
 \delta Z_3 = \delta Z_4 W_2^T & \delta W_2 = Z_3^T \delta Z_4 \\\\
 \delta Z_2 = \sigma(Z_2)(1  - \sigma(Z_2)) \delta Z_3 & \delta b_1 = \sum\limits_k(\delta Z_2)_{k,:}  \\\\
 \delta Z_1 = \delta Z_2 & \delta W_1 = X^T \delta Z_1 \\\\
 \end{array}
\\]


最后附上matlab, python的代码实现：
{% codeblock lang:python %}
clear all
close all
clc

X = [1 0;0 1; 1 1; 0 0];
Y = [1; 1; 0; 0];

W1 = randn(2, 8);
b1 = randn(1, 8);

W2 = randn(8, 1);
b2 = randn(1, 1);

lr = 0.5;

for i = 1:10000
    Z1 = X * W1;
    Z2 = Z1 + b1;
    Z3 = funcSig(Z2);
    Z4 = Z3 * W2;
    Z5 = Z4 + b2;
    Yp = funcSig(Z5);

    dYp = Yp - Y;
    dZ5 = (funcSig(Z5) .* (1 - funcSig(Z5))) .* dYp;
    dZ4 = dZ5;
    dZ3 = dZ4 * W2';
    dZ2 = (funcSig(Z2) .* (1 - funcSig(Z2))) .* dZ3;
    dZ1 = dZ2;

    db2 = sum(dZ5);
    dW2 = Z3' * dZ4;
    db1 = sum(dZ2, 1);
    dW1 = X' * dZ1;

    W2 = W2 - dW2 * lr;
    b2 = b2 - db2 * lr;

    W1 = W1 - dW1 * lr;
    b1 = b1 - db1 * lr;

    if mod(i, 1000) == 0
        loss = sum(0.5*(Yp - Y) .* (Yp - Y));
        str = sprintf('loss: %d', loss);
        disp(str)
    end

end


function re_value = funcSig(X)
    re_value = X;

    [row column] = size(X);

    for i = 1:row
        for j = 1:column
            re_value(i,j) = 1/(1 + exp(-X(i,j) ));
        end
    end
end
{% endcodeblock %}

{% codeblock lang:python %}
from __future__ import print_function
import torch
from torch.autograd import Variable


X = torch.tensor([[1.0,0.0,0.0,1.0],[0.0,0.0,1.0,1.0]],dtype=torch.float32)
X = torch.transpose(X,0,1)
Y = torch.tensor([[1.0,0.0,1.0,0.0]],dtype=torch.float32)
Y = torch.transpose(Y,0,1)
print("input: ", X)
print("output: ", Y)


W1 = Variable(torch.torch.FloatTensor(2, 8).uniform_(-1, 1), requires_grad=True)
b1 = Variable(torch.zeros((1,8)), requires_grad=True)
W2 = Variable(torch.torch.FloatTensor(8, 1).uniform_(-1, 1), requires_grad=True)
b2 = Variable(torch.zeros([1]), requires_grad=True)

learning_rate = 0.5

for step in range(10000):


  Z1 = torch.mm(X,W1)
  Z2 = Z1 + b1
  Z3 = torch.sigmoid(Z2)
  Z4 = torch.mm(Z3,W2)
  Z5 = Z4 + b2
  Yp = torch.sigmoid(Z5)


  dYp = Yp-Y
  dZ5 = torch.sigmoid(Z5)*(1.0-torch.sigmoid(Z5))*dYp
  dZ4 = dZ5
  dZ3 = torch.mm(dZ4,torch.transpose(W2,0,1))
  dZ2 = torch.sigmoid(Z2)*(1.0-torch.sigmoid(Z2))*dZ3
  dZ1 = dZ2

  dW1 = torch.mm(torch.transpose(X,0,1),dZ1)
  db1 = torch.sum(dZ2,0,True)
  dW2 = torch.mm(torch.transpose(Z3,0,1),dZ4)
  db2 = torch.sum(dZ5)

  W1 = W1 - learning_rate*dW1
  b1 = b1 - learning_rate*db1
  W2 = W2 - learning_rate*dW2
  b2 = b2 - learning_rate*db2

  if step%1000 == 0:
    loss = torch.sum((Yp-Y)**2)
    print("loss:",loss)

print(Yp)
print(Y)
{% endcodeblock %}


