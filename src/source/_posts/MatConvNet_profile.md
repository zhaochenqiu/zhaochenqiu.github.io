title: MatConvNet 配置笔记
date: 2017-07-07
tags: 图像处理
abstract: 记录MatConvNet的配置过程
---
记录MatConvNet的配置过程
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

记录MatConvNet的整个配置过程。
MatlabConvNet百度可以搜到，
或者用他的提供的代码
    untar('http://www.vlfeat.org/matconvnet/download/matconvnet-1.0-beta24.tar.gz') ;

untar 是解压压缩包的意思，不过他直接可以解压网上的压缩包，也刚好映射了**网络映射为文件操作**。

编译的时候就遇到strjoin不存在，
原因是matlab版本太老，升级到2014

matlab升级之后又提示
fatal error C1083: Cannot open include file: 'stdint.h': No such file or directory

原因是 stdint.h 是c99 的标准头文件，vc2008没有，
所以去google code 里下载msinttypes-r26.zip 就可以了，把这几个文件放到vc的include里的文件夹里。
vc inlcude 的路径是'C:\Program Files\Microsoft Visual Studio 9.0\VC\include'

single 将double的数据变成single节省空间

下面这几个就是基本的数据类型
net.meta.normalization.imageSize
met.meta.normalization.averageImage


这里都是使用的CPU编译，

使用GPU编译

matlab2010 版本不够，必须升级，这里使用matlab2014a

如果出想错误 strjoin函数不存在，就是matlab 版本太低。

装好matlab后，还要升级VS，VS的版本必须要2010以上，而且2010不推荐使用，
所以干脆升级到2015 community
  
  <table cellpadding="4" cellspacing="0" summary="" id="system-requirements__table_hrp_klk_qk" class="table" frame="border" border="1" rules="all">
  <caption><span class="tablecap">Table 1. Windows Operating System Support in CUDA <span class="keyword">8.0</span></span></caption>
  <thead class="thead" align="left">
     <tr class="row">
        <th class="entry" align="left" valign="top" width="NaN%" id="d54e148" rowspan="1" colspan="1">Operating System</th>
        <th class="entry" align="center" valign="top" width="NaN%" id="d54e151" rowspan="1" colspan="1">Native x86_64</th>
        <th class="entry" align="center" valign="top" width="NaN%" id="d54e154" rowspan="1" colspan="1">Cross (x86_32 on x86_64)</th>
     </tr>
  </thead>
  <tbody class="tbody">
     <tr class="row">
        <td class="entry" align="left" valign="top" width="NaN%" headers="d54e148" rowspan="1" colspan="1">Windows 10</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e151" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e154" rowspan="1" colspan="1">YES</td>
     </tr>
     <tr class="row">
        <td class="entry" align="left" valign="top" width="NaN%" headers="d54e148" rowspan="1" colspan="1">Windows 8.1</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e151" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e154" rowspan="1" colspan="1">YES</td>
     </tr>
     <tr class="row">
        <td class="entry" align="left" valign="top" width="NaN%" headers="d54e148" rowspan="1" colspan="1">Windows 7</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e151" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e154" rowspan="1" colspan="1">YES</td>
     </tr>
     <tr class="row">
        <td class="entry" align="left" valign="top" width="NaN%" headers="d54e148" rowspan="1" colspan="1">Windows Server 2016</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e151" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e154" rowspan="1" colspan="1">NO</td>
     </tr>
     <tr class="row">
        <td class="entry" align="left" valign="top" width="NaN%" headers="d54e148" rowspan="1" colspan="1">Windows Server 2012 R2</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e151" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e154" rowspan="1" colspan="1">NO</td>
     </tr>
     <tr class="row">
        <td class="entry" align="left" valign="top" width="NaN%" headers="d54e148" rowspan="1" colspan="1">Windows Server 2008 R2 <strong class="ph b">DEPRECATED</strong></td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e151" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e154" rowspan="1" colspan="1">YES</td>
     </tr>
  </tbody>
</table>

<table cellpadding="4" cellspacing="0" summary="" class="table" frame="border" border="1" rules="all">
  <caption><span class="tablecap">Table 2. Windows Compiler Support in CUDA <span class="keyword">8.0</span></span></caption>
  <thead class="thead" align="left">
     <tr class="row">
        <th class="entry" valign="top" width="NaN%" id="d54e260" rowspan="1" colspan="1">Compiler</th>
        <th class="entry" valign="top" width="NaN%" id="d54e263" rowspan="1" colspan="1">IDE</th>
        <th class="entry" align="center" valign="top" width="NaN%" id="d54e266" rowspan="1" colspan="1">Native x86_64</th>
        <th class="entry" align="center" valign="top" width="NaN%" id="d54e269" rowspan="1" colspan="1">Cross (x86_32 on x86_64)</th>
     </tr>
  </thead>
  <tbody class="tbody">
     <tr class="row">
        <td class="entry" rowspan="2" valign="middle" width="NaN%" headers="d54e260" colspan="1">Visual C++ 14.0</td>
        <td class="entry" valign="top" width="NaN%" headers="d54e263" rowspan="1" colspan="1">Visual Studio 2015</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e266" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e269" rowspan="1" colspan="1">NO</td>
     </tr>
     <tr class="row">
        <td class="entry" valign="top" width="NaN%" headers="d54e263" rowspan="1" colspan="1">Visual Studio Community 2015</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e266" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e269" rowspan="1" colspan="1">NO</td>
     </tr>
     <tr class="row">
        <td class="entry" valign="top" width="NaN%" headers="d54e260" rowspan="1" colspan="1">Visual C++ 12.0</td>
        <td class="entry" valign="top" width="NaN%" headers="d54e263" rowspan="1" colspan="1">Visual Studio 2013</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e266" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e269" rowspan="1" colspan="1">YES</td>
     </tr>
     <tr class="row">
        <td class="entry" valign="top" width="NaN%" headers="d54e260" rowspan="1" colspan="1">Visual C++ 11.0</td>
        <td class="entry" valign="top" width="NaN%" headers="d54e263" rowspan="1" colspan="1">Visual Studio 2012</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e266" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e269" rowspan="1" colspan="1">YES</td>
     </tr>
     <tr class="row">
        <td class="entry" valign="top" width="NaN%" headers="d54e260" rowspan="1" colspan="1">Visual C++ 10.0 <strong class="ph b">DEPRECATED</strong></td>
        <td class="entry" valign="top" width="NaN%" headers="d54e263" rowspan="1" colspan="1">Visual Studio 2010</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e266" rowspan="1" colspan="1">YES</td>
        <td class="entry" align="center" valign="top" width="NaN%" headers="d54e269" rowspan="1" colspan="1">YES</td>
     </tr>
  </tbody>
</table>

装好Matlab之后，就要开始升级显卡驱动，首先在Matlab里面输入 gpuDevice ，如果显示结果正常, 表示这个显卡还可以使用。表示这个显卡还可以使用。
`如果直接就卡死了，那就是驱动有问题，更新就可以了。`

这里装的驱动是`384.76-desktop-win8-win7-64bit-international-whql.exe`。这一步很重要，这一步过了，再装CUDA才可以



装了之后不行，要替换R2014a\bin\win64\mexopts

http://www.cnblogs.com/Yan47/p/6418129.html

CUDA下载地址
https://developer.nvidia.com/cuda-downloads

revising...
