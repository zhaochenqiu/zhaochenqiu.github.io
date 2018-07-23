title: VPS 上网:持续更新
date: 2018-07-23 10:00:00
tags: Linux
---
授人以鱼，不如授人以渔
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 前言
These walls are funny. First you hate them. Then you get used to them. Enough time passes, you get so you depend on them. That is institutionalized.

这些(监狱的)围墙很有趣。起初你痛恨它; 然后你逐渐习惯它; 足够长时间后, 你开始依赖它 -- 这就是体制化!
<p align="right">  —— [The Shawshank Redemption](https://movie.douban.com/subject/1292052/?source=new_aladdin) [肖申克的救赎](thunder://QUFmdHA6Ly9keTpkeUB4bGEueHVuYm8uY2M6NDAwNTYvW9G4wNfPwtTYd3d3Llh1bkJvLkNjXdCkyeq/y7XEvsjK6kJEMTAyNLjfx+XW0NOiy6vX1i5ybXZiWlo=)  </p>

# 新手VPS图文教程
## VPS简介
VPS 全名为**Virtual Private Server**虚拟专用服务器，可以理解为一个虚拟出来的主机（电脑），要想了解更多可以看[百科](https://baike.baidu.com/item/VPS/11053576?fr=aladdin)或者[维基(推荐)](https://en.wikipedia.org/wiki/Virtual_private_server)。
有了一个VPS之后，就相当于有了一台新的电脑，但是只能通过远程控制来操作。

VPS本身就是一台主机，所以电脑可以做的事情VPS都可以做，例如下电影，玩游戏，跑代码，当然还有当上网的服务器。因为VPS的稳定性很好，可以很长时间稳定运行，不需要重启或关机。所以大部分的服务器vps都被用来做服务器。

## VPS上网须知
相信很多人都有自己购买VPN，ss或者ssr账号的，还有直接找免费的软件来上网的。既然有这么多简单的方法，为什么还要自己折腾VPS呢？

首先针对免费的软件。**`免费的一定的最贵的`**。免费的软件一般会要求用户提供各种信息，或者植入广告。总体上用户所花的时间成本远远大于“免费”所带来的收益。此外，安全性是另一个需要考虑的**重要的因素**。
使用免费软件来上网，几乎无异于把你自己完全的暴露在网上，你访问了什么网页，下载上传了什么文件，甚至于你输入的密码，都有可能被记录。虽然有高手可以用开源软件来上网并可以保证安全性，但是新手***最好不要***使用免费软件来上网。

接着针对购买账号。直接购买账号的确是一个简单的办法。但是据笔者所知，现在出售“快速，稳定还没有限制”商家已经全灭了。为什么呢？请看下面的法律条文:

    《反恐法草案》中第十五条提到：电信业务经营者、互联网服务提供者应当在电信和互联网的设计、建设和运行中预设技术接口，将密码方案报密码主管部门审查。未预设技术接口，或者未报审密码方案的，相关产品或者技术不得投入使用。已经投入使用的，主管部门应当责令其立即停止使用。在中华人民共和国境内提供电信业务、互联网服务的，应当将相关设备、境内用户数据留存在中华人民共和国境内。拒不留存的，不得在中华人民共和国境内提供服务。

这是什么意思？就是TM的现在不存在“合法”的保护隐私的安全运营商。所有运营商，或者留技术后门，也就是把你干的事情公开给朝廷，然后要干了啥...等着被喝茶吧。或者就是“非法”的。恩非法的....

那么VPS就安全么？对，VPS理论上**很**安全。但还是先来看看法律条文：

    中华人民共和国计算机信息网络国际联网惯例暂行规定》（国务院令第195号):
    第六条   计算机信息网络直接进行国际联网，必须使用邮电部国家公用电信网提供的国际出入口信道。任何单位和个人不得自行建立或者使用其他信道进行国际联网。
    第十四条 违反本规定第六条、第八条和第十条的规定的，由公安机关责令停止联网，给予警告，可以并处15000元以下的罚款；有违法所得的，没收违法所得。
    第十五条 违反本规定，同时触犯其他有关法律、行政法规的，依照有关法律、行政法规的规定予以处罚；构成犯罪的，依法追究刑事责任。

是不是很吓人。任何人不得**建立**或者**使用**其他信道进行国际联网。恩，所以用谷歌的小心了，抓到就是一万五。出国留学的也小心了，去学校网站交申请材料也是犯法的（据悉，很多学校的官网就被误杀了），情节严重就是**刑事**责任，要坐牢哦！
这里的重点是，如何证明你“建立”或者“使用”了呢？如果你是从别人手里购买的，那么卖家就可以证明！然后你就完蛋了(当然这只是假设)。
或者像上面法律条文中提及的“技术接口”，可以直接看你在网上干了什么，那这就是更直接的证据（虽然现在只有很少的人被抓，那只是懒得抓你）。
那又有人说，“我用合法的国际联网啊”。吾...我也想用啊，但是那里有卖的啊？

自己的VPS就没有这些问题吗？吾...还真没有。先说服务器端，都说了是virtual的server，是虚拟的！也就是说，一键删除，什么都没了。或者如果来不及删除，也不要紧。现在大多数的vps只要用法的当，基本可以做到**匿名**购买。
即便不能全匿名，也只有VPS运营商，知道部分你的信息，而这些信息不足以找到你本人。总结起来就是“没有谁知道你买了机器，也没有谁知道，这个VPS是你的”，哪怕是你所有的账号被攻陷，也没有办法可以证明，这些账号属于你！
当然基本也不会花这么大的精力来抓一个P民(技术上想要攻陷所有账号，很难很难，除非动用国家级别的势力)。所以自建VPS比购买账号安全很多，而且因为是自己在用，也稳定和快很多，基本看youtube 1080没有问题（什么笔者怎么知道的？那肯定是别人告诉我的啊，我是守法公民）。此外还有一个更实际的原因，现在的VPS都是白菜价了，便宜的有3美元一个月的，比大多数账号还便宜。**为什么不自己动手省点钱，而且还安全，稳定更可以学习到一些新技术呢？**

## VPS上网，以Vultr为例(国内可直连)
好了，废话说的有点多了，现在开始干货了！这里的目的就是搭建一个“最大限度匿名的VPS上网服务器”(当然这不并是最好的匿名方法，由于考虑到技术门槛，不过多介绍其他方法，有兴趣的可以自行搜索)。
考虑到本文目的为推广，所以尽量不介绍过多原理。技术细节在[另一个帖子中介绍](http://zhaochenqiu.github.io/2018/06/15/vps/)，不定期更新。

### 步骤一，购买VPS，Vultr为例
首先去Vultr注册一个帐号，官网在[这里](https://www.vultr.com/)。

![Vultr帐号注册，推荐使用一个新邮箱注册，与你的身份保持隔离](https://image.ibb.co/eqCiby/image.png)

注册好之后，先冲钱。Vultr是按小时计费的，一个月的时间大概是10美元的样子。使用的话，最少充值一个月。充值界面如下:

![Vultr充值界面，支持支付宝付账！点击支付，扫码付账!](https://image.ibb.co/dW61wy/1.png)

继续之前谈谈安全问题。可能有人说，使用支付宝了，不就暴露了？不用担心，使用支付宝是说明你在Vultr中充值了，而且Vultr本身没有被墙，也就是说在Vultr买东西是没问题的。之后你干了什么，就只有Vultr知道了，而且他最多也就是知道你虚拟了一个服务器，并不关心你干了啥。
除非Vultr和朝廷高层联手抓你，那也只能追到支付宝这一步。而实际上Vultr是不可能和朝廷合作的。如果还是担心，可以尝试其他的支付方式，例如国外的Credit Card，这就很稳了。国外的银行是不可能公开用户信息的。或者最狠的，用Bitcoin(比特币),那就是真的稳如狗了！

冲完值之后就可以虚拟一个主机来用了。如下图。

![选择节点位置，此处选择Singapore，据说网速比较稳定](https://image.ibb.co/jDQx3d/2.png)
![输入服务器名，点击Deploy Now](https://image.ibb.co/cOvrUJ/3.png)

接着，返回点击Server菜单，就可以看到你刚刚虚拟出来的主机了,点击主机，就可以进入主机的操作台，里面包含了操作这台主机所需要的所有信息，如下图：

![查看虚拟服务器](https://image.ibb.co/cNwgUJ/4.png)
![虚拟服务器操作台](https://image.ibb.co/jLqEid/5.png)

知道上图中的IP Address， Username 和 Password 后就是对这台机器进行操作了。这一步除了节点位置，其他的都选择默认。注意下系统选择Centos（默认也是这个），
此处的信息为：

    IP Address: 149.***.***.***
    Username:   root
    Password:   Y*********5

为了隐私，隐藏了几位数字。记得将这些信息换成你自己的VPS。



### 步骤二，下载SSH客户端
SSH跟windows远程桌面相似，不过是专门为Linux设计的。网上有很多SSH的客户端，这里强烈推荐[MobaXterm](https://mobaxterm.mobatek.net/), 这里是官网的[下载链接](https://download.mobatek.net/1082018070240950/MobaXterm_Portable_v10.8.zip)。
下载完之后，解压打开，然后点击中间的"start local terminal"，如下图：

![MobaXterm运行](https://image.ibb.co/dL6Dtd/6.png)

运行之后，就会出现命令界面，在其中输入命令.`ssh root@149.***.***.206`.就会出项要求你输入密码的界面，然后输入你的密码（密码可以直接复制进去，不一定要手输），就可以登录你的VPS进行操作。如下图：

![ssh登录!](https://image.ibb.co/gRSKYd/7.png)

### 步骤三，安装ShadowsocksR服务器
登录进入服务器后，就开始安装ShadowsocksR。再次为了降低门槛，这里直接使用一键安装脚本。请直接把下面的命令输进去，或者直接复制进去也行。

    (curl -s https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh) >> shadowsocksR.sh
    ls
    chmod +x shadowsocksR.sh
    ./shadowsocksR.sh

一共四行命令。意思是，
+ 1）下载SSR安装脚本本保存在本地
+ 2）查看脚本是否被保存在本地
+ 3）给脚本增加执行权限
+ 4）运行脚本
输入之后在最后一行命令缓一下，如果全部正确的话效果应该如下图：

![运行截图](https://image.ibb.co/kOnkPJ/8.png)

接着输入回车，SSR就会自动开始安装。安装过程中需要设置一些参数，可以参考下图：

![SSR登录密码设置](https://image.ibb.co/dncryd/9.png)

![SSR登录端口](https://image.ibb.co/fWaGWy/10.png)

![选择加密方法](https://image.ibb.co/i5NKjJ/11.png)

![选择协议](https://image.ibb.co/c9Dvry/12.png)

![选择混淆算法](https://image.ibb.co/fX5fPJ/13.png)

![开始安装](https://image.ibb.co/iemWWy/14.png)

![安装成功](https://image.ibb.co/kB5Qry/15.png)

SSR安装成功之后，会自动打印出登录的信息例如，这里的信息就是：

    Congratulations, ShadowsocksR server install completed!
    Your Server IP        :  149.***.***.***
    Your Server Port      :  34672
    Your Password         :  123456
    Your Protocol         :  auth_aes128_md5
    Your obfs             :  tls1.2_ticket_auth
    Your Encryption Method:  aes-256-cfb8

    Welcome to visit:https://shadowsocks.be/9.html
    Enjoy it!

### 步骤四，下载SSR客户端
最后一步，就是下载客户端然后享受无限制的上网了。下载地址在[这里](https://github-production-release-asset-2e65be.s3.amazonaws.com/98540438/20efe346-d084-11e7-838a-923986449fed?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20180723%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20180723T053658Z&X-Amz-Expires=300&X-Amz-Signature=f4b29ea894ded5b0ea5b1c04fa227998e9717bbd901c427099ae8b926f015ade&X-Amz-SignedHeaders=host&actor_id=10084681&response-content-disposition=attachment%3B%20filename%3DShadowsocksR-win-4.9.0.zip&response-content-type=application%2Foctet-stream)，下完后把对应信息填好，就可以了。

![SSR客户端](https://image.ibb.co/emmejJ/16.png)

当然，SSR不只有windows客户端，[android客户端](https://github.com/shadowsocksr-backup/shadowsocksr-android/releases)，苹果客户端，mac，pad(所有的苹果设备推荐[shadowrocket](https://www.hinwen.com/3662.html)).国内的app store是把这个软件下架了。但是进入apple id，切换地区即可下载！


## 其他科学上网方式
building...


## 结束语
我知道很人会说，“翻墙干吗，没有谷歌有百度啊，没有youtube有优酷啊，没有这个需求”。笔者深知自己人微言轻，给出的答案不足以服人，仅以以下格言与君共勉。

自由有许多困难, 民主亦非完美。然而, 我们从未建造一堵墙, 把我们的人民关在里面, 不准他们离开。
<p align="right">  ——《在柏林墙下的演说》肯尼迪 (美国前总统) </p>

一旦你习惯了戴面具的生活, 你的脸将变得跟面具一样。
<p align="right">  ——《V怪客／V字仇杀队》</p>

每当有事情发生, 懦夫会问: '这么做安全吗?' 患得患失者会问: '这么做明智吗?' 虚荣者会问: '这么做受欢迎吗?' 但是良知只会问: '这么做正确吗?'
<p align="right">  ——马丁.路德.金 (美国人权领袖)</p>

起初他们追杀共产党人，我没有说话，因为我不是共产党人；接着他们追杀犹太人，我没有说话，因为我不是犹太人；后来他们追杀工会会员，我没有说话，因为我不是工会会员；此后他们追杀天主教徒，我没有说话，因为我是新教教徒；最后他们奔我而来，却再也没有人站出来为我说话了。
<p align="right">   ——马 尼莫拉牧师 </p>

翻墙和OX的相似之处: 一旦会做就老想做; 做第一次之后觉得天地豁然开朗; 每次做都有快感; 觉得不会做的都是SB!

GFW把中国人挡在了无数优秀网站之外, 仿佛在这些网站入口处设置了一道铁门, 上书八个大字:'**华人与狗 不得入内**'
