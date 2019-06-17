title: 重要操作记录
date: 2019-06-16 14:01:56
tags: Linux
---
记录一些犀利的骚操作
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# Vim异常字符 16进制处理方法
使用Vim编辑器时有时候会出现一些奇怪的字符，如下:

![](https://i.ibb.co/rb7WJfm/image.png).

这个时候使用16进制查看文件，命令为：

    :%!xxd

这样可以看到一个不是ascii码的字符如下：

![](https://i.ibb.co/mNBPSNV/image.png)

先附上一个ascii码表

![](https://i.ibb.co/f1Fqych/image.png)

从上表可以看到ascii最大的值应该是7F，而上面确实c293,两个都不是ascii码，所以全局替换就好

    :%s /c293/756c/g

如下：

![](https://i.ibb.co/w0zt5vW/image.png)
![](https://i.ibb.co/dJjTHPL/image.png)

最后命令转回普通模式：

    :%!xxd -r

就可以看到刚刚的字符没了:

![](https://i.ibb.co/2Z3N89B/image.png)

但是可以看到，还有一些，
所以把替换命令

但是可以看到，还有一些，
所以把替换命令改改

    :%s /c2\ 93/75\ 6c/g

![](https://i.ibb.co/cDT85qV/image.png)

完美解决


# Vim命令模式中复制粘贴操作

另一个方法是`q:`命令命令。使用命令`ESC+q:`如下

![](https://i.ibb.co/BrT14KS/image.png)

打开的页面本身是一个vim编辑，可以直接用p粘贴.
