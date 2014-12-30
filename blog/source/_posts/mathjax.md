title: MathJax示例
date: 2014-12-30 14:01:56
tags: 数学公式
---

MathJax 用于在网页编写数学公式，该博文用于测试mathjax在github上搭建的博客是否可用，以及mathjax的一些基本用法。

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# MathJax示例一，在句子中的数学公式。
首先通过一段话来展示mathjax的魅力，这段话是用来介绍贝叶斯定理（Bayes）的。
贝叶斯（Bayes）定理:
\\[ \begin{matrix}
P(w_{i}|X)=\frac{P(X|w_{i})P(w_{i})}{\sum_{j=1}^{n}P(X|w_{j})P(w_{j})}
\end{matrix} \\]
Bayes定理的意思是，在\\(X\\)特征空间下，\\(w_{i}\\)类事件出现的概率\\(P(X|w_{i})\\)乘上\\((w_{i}\\)类事件出现的概率\\(P(w_{i})\\)然后再除以待分类事件按的概率\\(\sum_{j=1}^{n}P(X|w_{j})P(w_{j}) \\) 就是出现\\(X\\)特征下,事件被归为\\(w_{i}\\)的概率.


