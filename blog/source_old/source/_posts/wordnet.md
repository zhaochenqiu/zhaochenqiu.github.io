title: cygwin下源代码安装WordNet
date: 2015-02-07 19:19:11
tags: linux
---

cygwin是一个linux模拟器，和linux十分相似，包括系统文件结构，常用的命令，以及软件的**安装方式**。但是通常cygwin软件是通过cygwin的安装程序以添加组件的方式安装的，和linux的**源代码安装**差别很大。经过测试发现cyginw下同样可以使用源码编译方式安装，这里就**记录使用源代码编译的方式安装wordnet的过程**。

# WordNet介绍以及下载
## WordNet介绍
[WordNet](http://wordnet.princeton.edu/)是一个英语的词汇数据库。或者说是一个英语的字典，功能就是可以查询各种单词的意思，同义词，近义词，反义词等等。他的使用很简单，可以直接使用命令行，例如下图，查询Apple单词的意思：
![wordnet](http://i2.tietuku.com/5a83e05cb688219c.png)
除了命令行的操作，更多的是直接使用WordNet开发的编程接口[进行编程](http://wordnet.princeton.edu/wordnet/man/wnintro.3WN.html)。

## WordNet下载
WordNet现在有两个比较通用的版本，一个是直接的release文件 [2.1版本](http://wordnetcode.princeton.edu/2.1)。另一个就是**源代码包，也就是我们使用的，[下载地址](http://wordnetcode.princeton.edu/3.0/WordNet-3.0.tar.gz)**

# WordNet的源码编译安装
## 步骤一configure
WordNet源代码下载以后解压就得到下面的一些源码，在include文件中就可以找到wordnet中的各种头文件。
![WordNet源码](http://i2.tietuku.com/6948d5012493d82a.png)
然后执行configure命令。
![configure命令执行](http://i2.tietuku.com/7de7c617fc2bd150.png)
![condigure命令执行](http://i2.tietuku.com/ca48f8aca630b311.png)

## 步骤二make
执行完configure后，在该目录下就就已经生成好了**Makefile**,然后使用gcc的make命令就可以编译生成wordnet了
![编译生成wordnet](http://i2.tietuku.com/631230d4761cc1fc.png)
第一次编译通常会失败，因为一般都会缺少几个库文件，如上图就缺少几个xlib的库文件，然后使用cygwin的安装程序把库文件补全就可以了。
![补全库文件](http://i2.tietuku.com/df997f4be1258261.png)
![补全库文件](http://i2.tietuku.com/e279944f6a0236c7.png)
![补全库文件](http://i2.tietuku.com/102efda6ecfa98b0.png)

补全完库文件以后就可以编译生成，以下就是编译好的wordnet。
![wordnet源程序](http://i2.tietuku.com/2141b4722b31339f.png)
执行wn命令就可以看到wordnet的返回结果。
![wordnet执行结果](http://i2.tietuku.com/6df908bbf24c9413.png)

# WordNet安装测试
WordNet的的代码调用，关于wordnet的调用可以参考[官网](http://wordnet.princeton.edu/wordnet/man/wnintro.3WN.html)。

cygwin下源代码安装WordNet和linux基本一致，第一步configure，然后使用make编译生成。需要注意就是一些缺少的软件包。同时cygwin是安装在window下的，因此window同样可以使用WordNet只需要把对应的动态库拷进来即可（一般是mintty.dll）。
