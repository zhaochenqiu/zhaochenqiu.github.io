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

# 生成多个公钥
公钥的生成命令是'ssh-keygen',但是如果本身已经存在一个公钥，会要求你输入一个新的名字，效果如下
```
cqzhao@imi-cqzhao:~/.ssh$ ssh-keygen
        Generating public/private rsa key pair.
        Enter file in which to save the key (/home/cqzhao/.ssh/id_rsa): id_rsa_rxy
        Enter passphrase (empty for no passphrase): 
        Enter same passphrase again: 
        Your identification has been saved in test.
        Your public key has been saved in test.pub.
        The key fingerprint is:
        SHA256:pn1jf3OjCNI2Z0vntsYfm5lZ4FkY+7nZPsc3Y9WTNSY cqzhao@imi-cqzhao
        The key's randomart image is:
        +---[RSA 2048]----+
        |                 |
        |                 |
        |              .  |
        |             E *.|
        |        S     * *|
        |       +.    . B+|
        |      ...=++..o+=|
        |        oo*o=+o*^|
        |           o+==&X|
        +----[SHA256]-----+
cqzhao@imi-cqzhao:~/.ssh$ 
```
接着就会发现当先目录下多两个文件**id_rsa_rxy**和**id_rsa_rxy.pub**。接着就是把id_rsa_rxy.pub里的公钥丢到github里去。注意该文件里所有的字符，包括空格都是公钥的一部分。

# 配置公钥文件
现在电脑里有了两对公钥私钥，效果如下:
```
qzhao@imi-cqzhao:~/.ssh$ ls -l
total 28
drwxrwxr-x 2 cqzhao cqzhao 4096 Feb  2 11:00 backup
-rw-rw-r-- 1 cqzhao cqzhao  155 Feb  2 14:53 config
-rw------- 1 cqzhao cqzhao 1766 Feb  2 11:20 id_rsa
-rw-r--r-- 1 cqzhao cqzhao  399 Feb  2 11:27 id_rsa.pub
-rw------- 1 cqzhao cqzhao 1766 Feb  2 14:13 id_rsa_rxy
-rw-r--r-- 1 cqzhao cqzhao  399 Feb  2 14:13 id_rsa_rxy.pub
-rw-r--r-- 1 cqzhao cqzhao 1770 Dec  1 15:26 known_hosts
cqzhao@imi-cqzhao:~/.ssh$ i
```
配置的目的就是根据主机的不用自动选择公钥私钥。github使用ssh连接时需要配置主机，也就是需要**git remote**一波。
那么使用两个github账号也就是说要两个github的仓库并且是由不同的人创建。而且在配置remote的时候，主机的名字要特别设置的不一样如下
```
cqzhao@imi-cqzhao:/data/projects/blog_github$ git remote -v
remote_github	git@github.com:zhaochenqiu/zhaochenqiu.github.io.git (fetch)
remote_github	git@github.com:zhaochenqiu/zhaochenqiu.github.io.git (push)
remote_imi	/home/cqzhao/repository/blog/ (fetch)
remote_imi	/home/cqzhao/repository/blog/ (push)
cqzhao@imi-cqzhao:/data/projects/blog_github$ 

cqzhao@imi-cqzhao:/data/projects/latex/draft_DFTL$ git remote -v
origin	git@github.com:HsinyuJen/draft_DFTL.git (fetch)
origin	git@github.com:HsinyuJen/draft_DFTL.git (push)
remote_github	git@rxy.github.com:HsinyuJen/draft_DFTL.git (fetch)
remote_github	git@rxy.github.com:HsinyuJen/draft_DFTL.git (push)
cqzhao@imi-cqzhao:/data/projects/latex/draft_DFTL$ 
```
注意上面的两个github主机，一个是`git@github.com:XXX`，一个是`git@rxy.github.com:`。而**rxy.github**其实是我们自己定义的一个主机。
根据这两个不同的主机名，就可以使用不用的key,所以在**.ssh**目录下要新建一个**config**文件。然后内容如下
```
Host rxy.github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa_rxy

Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa
```
这样提交的时候，ssh就会自动根据配置文件来选择合适的key。
