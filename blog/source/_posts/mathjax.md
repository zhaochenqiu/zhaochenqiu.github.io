title: MathJax示例
date: 2014-12-30 14:01:56
tags: 数学公式
---

MathJax 用于在网页编写数学公式，该博文用于测试mathjax在github上搭建的博客是否可用，以及mathjax的一些基本用法。

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# MathJax示例，在句子中的数学公式。
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
