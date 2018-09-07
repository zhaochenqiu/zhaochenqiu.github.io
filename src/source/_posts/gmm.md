title: 高斯混合模型(GMM)与EM算法
date: 2018-09-05 14:01:56
tags: 图像处理
---
详解并实现高斯混合模型与EM算法
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 高斯混合模型(Gaussian Mixture Model)
高斯混合模型，就是用多个高斯函数去模拟数据的分布，经常用于无监督的分类的问题。具体效果如下图，左边就是普通的数据，而右边右边就是使用GMM聚类之后的效果。而EM算法就是用来计算GMM的各项参数

![GMM效果图](https://image.ibb.co/bJP3Pe/image.png)


