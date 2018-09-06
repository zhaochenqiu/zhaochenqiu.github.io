title: Pandoc记录
date: 2018-04-23 10:17:32
tags: Pandoc
---
Pandoc是一个文本装换的神器，记录pandoc的折腾过程
<!--more-->


<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# pandoc的安装
## windows 下的安装
这个[网址](https://code.google.com/archive/p/pandoc/downloads)是从别人的博客中抄过来的，有windows和marc的版本。pandoc的官网在[这里](http://pandoc.org/index.html).

## ubuntu 下的安装
ubuntu 下的安装命令如下:
    sudo apt-get autoremove pandoc      #删掉之前的pandoc安装
    sudo apt-get install cabal-install  #安装Haskell包管理器
    cabal update                        #获取Haskell包信息
    cabal install pandoc                #通过cabal安装pandoc

building...
