title: VPS 上网与自建网盘
date: 2018-06-15 14:52:56
tags: Linux
---
VPS 踩坑记录
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 前言
最近，尤其是6月份开始网络封锁更加严重了，而且网盘最后的阵地也倒下了。
但是问题就有解决问题的方法，这里记录vps踩坑。

# VPS 代理上网
先来介绍下怎么上网，这里用centos系统示例。首先买一个vps服务器，各种支持centos的国外服务器都可以。
购买之后会得到一个ip地址，ssh端口，然后访问密码，如下(为个人隐私隐藏了一些数字和字符):

    IP address: 95.***.**.102
    SSH Port:   2***7
    Password:   I******q

然后ssh远程上去命令如下(这里需要下载一个终端，我用[cygwin](https://www.cygwin.com/)，推荐新手用[MobaXterm](https://mobaxterm.mobatek.net/))：

    $ ssh -p 2***7 root@95.***.**.102

接着输入用户密码登录，整个过程如下图：

![vps登录](https://image.ibb.co/cu9Yjd/image.png)

之后全部通过命令行，所以不截图了，直接附上终端打印的结果。
登录进入之后，先装一些之后可能会用到的软件：

    [root@host ~]# clear
    [root@host ~]# yum -y install git vim wget
    Loaded plugins: fastestmirror
    Determining fastest mirrors
     * base: repos-lax.psychz.net
    ...

yum是centos中的默认安装工具，类似于ubuntu中的apt-get。命令参数-y表示在安装过程中全选y(yes)。

然后安装ss服务器，网上有很多类似的教程，这里直接搬运[这里](http://morning.work/page/2015-12/install-shadowsocks-on-centos-7.html)的一键安装方法。
直接在终端键入如下命令:

    bash <(curl -s http://morning.work/examples/2015-12/install-shadowsocks.sh)

上述的命令就是下载脚本`install-shadowsocks.sh`,然后执行。脚本的内容如下：

{% codeblock lang:bash %}
    #!/bin/bash
    # Install Shadowsocks on CentOS 7

    echo "Installing Shadowsocks..."

    random-string()
    {
        cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
    }

    CONFIG_FILE=/etc/shadowsocks.json
    SERVICE_FILE=/etc/systemd/system/shadowsocks.service
    SS_PASSWORD=$(random-string 32)
    SS_PORT=8388
    SS_METHOD=aes-256-cfb
    SS_IP=`ip route get 1 | awk '{print $NF;exit}'`
    GET_PIP_FILE=/tmp/get-pip.py

    # install pip
    curl "https://bootstrap.pypa.io/get-pip.py" -o "${GET_PIP_FILE}"
    python ${GET_PIP_FILE}

    # install shadowsocks
    pip install --upgrade pip
    pip install shadowsocks

    # create shadowsocls config
    cat <<EOF | sudo tee ${CONFIG_FILE}
    {
      "server": "0.0.0.0",
      "server_port": ${SS_PORT},
      "password": "${SS_PASSWORD}",
      "method": "${SS_METHOD}"
    }
    EOF

    # create service
    cat <<EOF | sudo tee ${SERVICE_FILE}
    [Unit]
    Description=Shadowsocks

    [Service]
    TimeoutStartSec=0
    ExecStart=/usr/bin/ssserver -c ${CONFIG_FILE}

    [Install]
    WantedBy=multi-user.target
    EOF

    # start service
    systemctl enable shadowsocks
    systemctl start shadowsocks

    # view service status
    sleep 5
    systemctl status shadowsocks -l

    echo "================================"
    echo ""
    echo "Congratulations! Shadowsocks has been installed on your system."
    echo "You shadowsocks connection info:"
    echo "--------------------------------"
    echo "server:      ${SS_IP}"
    echo "server_port: ${SS_PORT}"
    echo "password:    ${SS_PASSWORD}"
    echo "method:      ${SS_METHOD}"
    echo "--------------------------------"
{% endcodeblock %}

如果想了解脚本中具体是什么意思，可以去参考原帖，如果希望本地有一份脚本副本，可以使用如下命令：

    [root@host ~]# curl -s http://morning.work/examples/2015-12/install-shadowsocks.sh >> install-shadowsocks.sh
    [root@host ~]# ls
    install-shadowsocks.sh
    [root@host ~]# chmod +x install-shadowsocks.sh
    [root@host ~]# ./install-shadowsocks.sh

执行完这个脚本之后，就会打印出用户和密码，如下（照例隐藏几位)：

    Congratulations! Shadowsocks has been installed on your system.
    You shadowsocks connection info:
    --------------------------------
    server:      95.***.**.102
    server_port: 8388
    password:    KenSTg**************fz7Gh
    method:      aes-256-cfb
    --------------------------------
    [root@host ~]#

然后下载ss客户端，如果找不到的话，可以从[这里](https://codeload.github.com/zhaochenqiu/download/zip/master)下到。
把上面生成的信息填进去，可以参考下图:

![ss软件](https://image.ibb.co/bzw5Ed/image.png)

接着把ss的模式更改成全局模式，启动代理。平常使用pca模式即可，因为我们要测试所以改成全局，如下图：

![ss配置](https://image.ibb.co/iKUQEd/image.png)

然后打开你的浏览器，如果是win10的话，不能用chrome，因为升级的原因，chrome代理比较麻烦，这里用firefox(用IE也行)。
打开后输入网址**ip.cn**你应该会发现你的ip归属地变了，不妨把ss关掉再输入网址对比下结果。如下图：

![ss打开与关闭后对比.左图未挂代理，右图挂了代理](https://image.ibb.co/jHPW4d/image.png)

挂上ss后，就可以**不受限制的浏览网页了，例如google或者youtube**,最后提供一个免费的ss供大家使用(有效期只有一个月，可能更短，希望长期使用的还是去自己买一个vps，例如在[这里](https://bandwagonhost.com/)买一个):

    IP:             23.83.235.136
    Port:           7654
    Password:       ZGZhNzJkY2
    Encryption:     aes-256-cfb

放心，这不是什么可疑的主机，是作者之前的旧服务器。现在升级到新服务器去后，旧的就不打算续费，等他过期（如果有人愿意资助，作者可以让这个服务器继续运行）。但过期之前依然会维护的。

# 搭建私人网盘
目前，据我所知，国内所有的网盘都“挂了”。各种审查内容，连最后的圣地115都开始审查了（**我的网盘放什么东西论不到你来审查！一怒之下就把网盘里的东西全报废了！**)。
无奈，只得再找解决方法--“利用vps搭建自己的私人云盘”。

## aria2
多费几句话来简单介绍随便推荐下aria2。aria2是一个**全平台**的命令行下载工具。有他之后，完全就可以抛弃某国产黑心下载软件（例如某雷或某风）。
aria2的官网在[这里](https://aria2.github.io/)。或者要是太懒不愿意看洋文可以点击[这里](https://github-production-release-asset-2e65be.s3.amazonaws.com/1116542/eca09fe6-588b-11e8-9418-40129dc31c98?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20180615%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20180615T141920Z&X-Amz-Expires=300&X-Amz-Signature=21eea2db0b143a94474a40bade0946f350111e09a467dd749ae2e4314c19d770&X-Amz-SignedHeaders=host&actor_id=10084681&response-content-disposition=attachment%3B%20filename%3Daria2-1.34.0-win-32bit-build1.zip&response-content-type=application%2Foctet-stream)下载一个windows的32位置版本。
下载后解压，然后cmd进入aria2目录中，使用命令就可以直接下载，如下图:

![aria2下载实例](https://image.ibb.co/gqP97y/image.png)

上图中的链接是`magnet:?xt=urn:btih:B5886C57C4FB4821DDACA9046320CAF1AE39C068`,是电影V字仇杀队的资源，强烈推荐！
aria2功能还远远不止这些，他还可以用来突破百度云的会员限制！这里不过多介绍了，想知道更多可以看[这里](https://github.com/hokein/Wiki/wiki/%E4%BD%BF%E7%94%A8aria2%E7%AA%81%E7%A0%B4%E7%99%BE%E5%BA%A6%E4%BA%91%E7%9B%98%E9%99%90%E9%80%9F)。

再回到vps，在centos上安装aria2，然后再配和web交互就可以将vps打造成一个拥有离线下载的网盘。
这里大部分参考[这里](http://www.138vps.com/vpsjc/945.html)。但是实际中遇到很多bug(查阅很多其他的资料，把坑全踩了一遍)，所以重新写一遍。
那位大佬是个vps的专家，分享了很多其他关于vps的技术，有兴趣的可以访问下他的网站。

# 网盘在线播放



