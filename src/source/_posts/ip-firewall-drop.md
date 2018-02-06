title: routeros 封锁特定网站
date: 2016-10-11 01:21:14
tags: RouterOs
---
routeros 下通过ip firewall 中的rule 封锁特定的网站，这里用百度实验
<!--more-->


先设置一个在adress list，包括一些特定的网站。然后再ip firewall 的rule里面，对这个list中的链接全部drop。
这里拿百度做实验，测试封锁百度。为了直观，全程用winbox，但转化成routeros命令效率更高。

首先找到百度的地址，去网上百度就可以知道：202.108.22.5

先设置一个ip address，testdroplist，并把百度加进去
![](http://i1.piimg.com/8927/819e3218921d382b.png)

然后就设置ip firewall 的规则。Forward的意思是 进出都检查，如果是input就是只检查进入。
![](http://i1.piimg.com/8927/4c0eb76e798f5662.png)

然后再advanced中的目的地址把testdroplist 包含进去
![](http://i1.piimg.com/8927/e5b19257977f83d0.png)

这步选择行为，drop是直接下线的意思，reject拒绝也可以封网
![](http://i1.piimg.com/8927/4b52fcc0bf66c741.png)

别忘了加注释，不然你都不知道这个写着干嘛
![](http://i1.piimg.com/8927/249e442650fdb8b1.png)

加了之后就是这样
![](http://i1.piimg.com/8927/17d7e033c9b38c72.png)

然后百度就上不去了
![](http://i1.piimg.com/8927/f1b85911ce7f3eff.png)

之后别忘记enable 这个规则，不然影响使用百度了
![](http://i1.piimg.com/8927/fc0afe2539b2f405.png)

enable之后就可以正常用了.
![](http://i1.piimg.com/8927/c0fd157bb6aa0868.png)
