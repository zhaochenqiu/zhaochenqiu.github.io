title: RouterOS 的安装和VPN配置
date: 2014-12-12 00:43:22
tags: 计算机网络
---

RouterOs 是一个linux路由操作系统，或者叫做软路由，简单的说就是可以把一个普通的PC机变成一个功能强大的路由器。通过这个系统可以搭建VPN服务器然后分网，而且支持各种网络操作，是一个非常强大的linux系统。

# RouterOS 的安装
开始这一步要有足够的耐心，因为根据人品的不同，这一步可能变的特别简单或者特别难。网上也有很多关于安装的教程，这里只记录我们当时是怎么安装成功的，避免以后的人走弯路。


## 需要的工具：
* routeros系统：这里使用的是routeros5.24 完美破解版，[下载地址](http://download.csdn.net/download/ljr929201012/7852219)
* 光盘刻录工具：这里使用ultraiso，[下载地址](http://rj.baidu.com/soft/detail/11522.html?ald)
* 光盘一张：虽然routeros5.24是支持U盘安装的，但这里没实验成功，因此使用光盘比较保险。
* 电脑一台：用来安装routeros，最好使用双网卡。


## 操作步骤
+ 把routeros5.24 刻录进光盘中。
+ 使用U盘启动工具进入电脑中，格盘，重新分区，就分一个盘，然后再格一次盘（为了保险）。
+ 将刻好的光盘放入电脑中，然后按F12，选择由光盘启动。

如果看到如下截图，表示成功：
![routeros 安装界面](http://i3.tietuku.com/1dc4710efffe480a.jpg)
新手建立全部安装，就是把上图中的功能全部勾选，然后下一步。在系统提示的 Do you want to keep old configuration？ [y/n]： 中选择n，不保留以前设置。接着在Continue? [y/n]: 中选择y。然后一直回车。**注意，最后问你是否重启的时候，一定要把光盘取出再重启。**重启后出现下图，那么系统安装成功：
![routeros 安装成功](http://i3.tietuku.com/64a23fe1cbf33704.jpg)

# RouterOs的配置
RouterOS搭建VPN有两种方法，一种是[routeros命令行](http://wenku.baidu.com/link?url=5VW6Y1CarvQ9NGsPdZgjvB63YycgJNdae9l3QhV6RZ9dUNjAuOAusK4u-LHzwLHSNzXnLsdjTTYsVuK9VeFDALdqqRfFJopUb8A3aRGtxpO)，一种是使用 [winbox](http://www.baidu.com/s?wd=routeros%20winbox&rsv_spt=1&issp=1&f=8&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&oq=ultrA&inputT=3961&rsv_pq=e9c65ed30000b5c4&rsv_t=8a5be7nVJdk3OrBHGCieL%2BIp%2F9uIjSS%2Bjie1o9ebQCvaRPed8KVDSKYfG0a1u1lCh%2B7r&rsv_sug3=25&rsv_sug4=1465&rsv_sug1=15&rsv_sug2=0&rsv_sug=1&bs=routeros%20%E5%91%BD%E4%BB%A4)。这里着重介绍如何使用命令行进行配置。

## 需要的工具：
* linux 操作系统并已经安装ssh

## 操作步骤
+ ### 分配网卡ip地址
这一步必须在routeros系统的机器上进行。routeros的开机界面如下（以下是通过ssh远程上去的，机器实际界面和这个一样）。
![routeros开机界面](http://i3.tietuku.com/90d986a4d80f2d12.png)
输入`ip address print` 就可以查看到当前的连接状态：
![routeros网卡状态](http://i3.tietuku.com/566840956bcdd283.png)
如果是一台空机器的话，NETWORK 和 ADRESS 项应该就是空的，只有网卡而没有ip地址。输入命令：
`ip address add ip-address=10.250.95.40 interface=ether1`
这样网卡1的ip地址就被设置为10.250.95.40。设置好了以后使用winbox就可以连接，或者直接在浏览器中输入地址也可以访问。否则就无法连接。

+ ### 建立ip pool 用于给连接进来的用户分配ip
建立命令为：
`ip pool add name=test ranges=192.168.1.1-192.168.1.253` 之后使用`ip pool print` 命令就可以查看当前当前建立的账户。
![建立ip pool](http://i3.tietuku.com/0e34e0c76e0e6eb9.png)

+ ### 为用户建立配置文件
建立命令为：
`ppp profile add name="test" local-address=222.198.XXX.XXX remote-address=test` 这里要注意了**local-adrdress必须是可以上网的网卡的地址**。使用命令 `ppp profile print` 就可以查看建立的配置文件。
![建立配置文件](http://i3.tietuku.com/a3f838fcac5f63c5.png)
![查看配置文件](http://i3.tietuku.com/1a106b99a70cb782.png)

+ ### 建立账户，用户连接vpn服务器
建立命令为：
`ppp secret add name=test password=123456 service=pptp profile=test` 然后使用 `ppp secret print` 就可以查看建立起来的账户。
![建立VPN连接](http://i3.tietuku.com/22307875799597b2.png)

**完成以后就可以使用vpn拨号了。**

+ ### 共享网络
vpn建立以后，只能是连进这个路由，还不能通过routeros上网，要在再加一条命令，将网络共享出来。
`ip firewall nat add chain=srcnat sction=masquerae`

关于这些命令具体是什么意思，这里不多介绍了，可以参考一下[这个资料](http://www.baidu.com/s?wd=routeros%20%E5%91%BD%E4%BB%A4&rsv_spt=1&issp=1&f=8&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=1&oq=ultrA&inputT=5414&rsv_pq=8551265500009fdc&rsv_t=f0ef%2BcwRfD%2FpsgN4xjvp8P6RQjXf0aadlqwDWNUQgsp6BA93paLVQI9mnFMlLoQg%2FNM2&rsv_sug3=16&rsv_sug4=986&rsv_sug1=13&rsv_sug2=0&rsv_sug=2&bs=ultraiso)

最后感谢实验室各位师兄,在你们的帮助下才搭建起来了这个VPN服务器.
