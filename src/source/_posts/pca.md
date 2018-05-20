title: PCA降维分类详解
date: 2018-05-20 14:01:56
tags: 图像处理
---
记录详解PCA的过程与用法
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 效果图
这次使用PCA对[MNIST](http://yann.lecun.com/exdb/mnist/)数据集进行降维分类，分别使用Matlab和Python来实验，结果如下:
![将数字图片降低到两个维度，红点为数字0的图像降维结果，蓝点为数字1的降维结果](http://zhaochenqiu.github.io/imgs/pca/exp1.png)




# MathJax示例，在句子中的数学公式。 
![test](http://zhaochenqiu.github.io/img/1p1543.jpg)
首先通过一段话来展示mathjax的魅力，这段话是用来介绍贝叶斯定理（Bayes）的。
贝叶斯（Bayes）定理:
    \\[ P(w\_{i}|X)=\frac{P(X|w\_{i})P(w\_{i})}{\sum\_{j=1}^{n}P(X|w\_{j})P(w\_{j})}  \\]
Bayes定理的意思是，在\\(X\\)特征空间下，\\(w\_{i}\\)类事件出现的概率\\(P(X|w\_{i})\\)乘上\\((w\_{i}\\)类事件出现的概率\\(P(w\_{i})\\)然后再除以待分类事件按的概率\\(\sum\_{j=1}^{n}P(X|w\_{j})P(w\_{j}) \\) 就是出现\\(X\\)特征下,事件被归为\\(w\_{i}\\)的概率.
这段话中的公式都不是图片，**随着字体的放大，公式也会放大**，这就是mathjax，一个html中的公式编辑器。

# MathJax 用法
MathJax的语法和latex是基本一样的，下面是几个使用的例子。更多的例子可以去[官网](http://www.mathjax.org/demos/tex-samples/)
## 例子一:
源码：
    `\[ \left( \sum\_{k=1}^n a\_k b\_k \right)^2 \leq \left( \sum\_{k=1}^n a\_k^2 \right) \left( \sum\_{k=1}^n b\_k^2 \right) \]`

效果：
    \\[ \left( \sum\_{k=1}^n a\_k b\_k \right)^2 \leq \left( \sum\_{k=1}^n a\_k^2 \right) \left( \sum\_{k=1}^n b\_k^2 \right) \\]


## 例子二:
源码：
    `\[P(E)   = {n \choose k} p^k (1-p)^{ n-k} \]`
效果：
    \\[P(E)   = {n \choose k} p^k (1-p)^{ n-k} \\]

## 例子三:
源码：
    `\[ \frac{1}{(\sqrt{\phi \sqrt{5}}-\phi) e^{\frac25 \pi}} = 1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {1+\frac{e^{-6\pi}}{1+\frac{e^{-8\pi}} {1+\ldots} } } } \]`
效果：
    \\[ \frac{1}{(\sqrt{\phi \sqrt{5}}-\phi) e^{\frac25 \pi}} = 1+\frac{e^{-2\pi}} {1+\frac{e^{-4\pi}} {1+\frac{e^{-6\pi}}{1+\frac{e^{-8\pi}} {1+\ldots} } } } \\]

## 例子四:
源码：
`\[\mathbf{V}_1 \times \mathbf{V}_2 =  \begin{vmatrix}\mathbf{i} &#038; \mathbf{j} &#038; \mathbf{k} \\ \frac{\partial X}{\partial u} &#038;  \frac{\partial Y}{\partial u} &#038; 0 \\               \frac{\partial X}{\partial v} &#038;  \frac{\partial Y}{\partial v} &#038; 0    \end{vmatrix}  \]`
效果：
\\[\mathbf{V}\_1 \times \mathbf{V}\_2 =  \begin{vmatrix}\mathbf{i} &#038; \mathbf{j} &#038; \mathbf{k} \\\\ \frac{\partial X}{\partial u} &#038;  \frac{\partial Y}{\partial u} &#038; 0 \\\\               \frac{\partial X}{\partial v} &#038;  \frac{\partial Y}{\partial v} &#038; 0    \end{vmatrix}  \\]
