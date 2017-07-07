title: 查看三维图片
date: 2015-11-26 23:20:55
tags: 图像处理
abstract: 找一种方法，可以让不会看三维图片的人，也可以看到内容，**但只是看到内容，没有那种立体感了**
---
-- 比较喜欢看三维图片，觉的那种立体感特别好。但有时候跟不会看的人就没法交流。这里弄一了一个可以看到三维图片内容的小程序，但这个程序只能看内容，想体会那种立体感还是要去学[怎么看](http://www.liuhs.com/3d.htm)。先来一张三维图片：
![](https://thumbnail0.baidupcs.com/thumbnail/510d823590de2ea9f1d6b8ea88ad9a23?fid=1124629257-250528-44395575683695&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-1wNPXPYogb8LdPyIWRecq3y4t40%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351763674840998094&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
**你能看出这是一个“3D”字吗**？

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>


## 三维图片原理
人有两只眼，两只眼有一定距离，这就造成物体的影象在两眼中有一些差异，见右图，由图可见，由于物体与眼的距离不同，两眼的视角会有所不同，由于视角的不同所看到是影象也会有一些差异，大脑会根据这种差异感觉到立体的景象。利用这种原理，三维图片会在水平方向生成一系列重复的图案，当这些图案在两只眼中重合时，就看到了立体的影象。具体可以[看这里](http://www.liuhs.com/3d.htm)。

## 算法原理
三维图片会在水平方向生成一系列**重复的图案**，当这些图案在两只眼中重合时，就看到了立体的影象。所以说，图像中那些重复的重复图案，就是立体影像的内容。那么只需要找到立体图像中那些重图案，然后把这些重复图案高亮出来，就可以看到三维图片中的内容了。

## 算法过程
目的就是找出图像中的重复图案，因为三维图像上的重复图案是水平的，因此将图像水平平移\\(offset\\),个单位，之后和原图像相减，这样，重复的部分就会变黑。假设图像为\\(f(x,y)\\),运算之后的图像为\\(f'(x,y)\\)。运算如下：
\\[f'(x,y) = f(x,y) - f(x+offset,y)\\]
此时图像\\(f'(x,y)\\)会随着\\(offset\\)变化而变化，而且当\\(offset\\)变化到一个特定的值的时候，\\(f'(x,y)\\)中重复的部分就会变黑，接着就可以看到三维图片中的内容了。
首先，**手动的调节\\(offset\\)的值**，查看是否可以看到内容。程序源码:
    
    clear all
    close all
    clc
    
    addpath('../../common');
    
    srcimg = double(imread('image2.jpg'));
    
    global g_displayMatrixImage
    g_displayMatrixImage = 1;
    
    img = srcimg;
    
    [row_img column_img byte_img] = size(img);
    
    img1 = img;
    img2 = img;
    
    store_value = [];
    
    for i = 3:column_img - 3
    	showimg1 = img1(:,i:column_img,:);
    	showimg2 = img2(:,1:column_img - i + 1,:);
    
    	subimg = abs(showimg1 - showimg2);
    	sumimg = sum(subimg,3);
    
    	sumvalue = sum(sum(sumimg));
    
    	count = row_img * (column_img - i + 1);
    	count = max([count 1]);
    
    	value = sumvalue/count;
    	store_value = [store_value ; value];
    
    	displayMatrixImage(1,1,3,showimg1,showimg2,subimg);
    
    	input('pause')
    end
这样得到的一些中间图像结果为:
![](http://i5.tietuku.com/a6cedf15ca0e34ce.png)
![](http://i5.tietuku.com/60e0408f3118d57d.png)
![](http://i5.tietuku.com/9aa72b54fcd046e8.png)
可以看到，当\\(offset\\)在某一个特定值的时候，三维图片中的图像就会显示出来，接下来的问题就是如何找出这个值。这个值的特点是会让图像部分变黑，也就是说\\(sum(f'(x,y))\\)的值会产生一个跳跃。下图是\\(offset-sum(f'(x,y))\\)曲线。
![](http://i13.tietuku.com/e61efa50752e7584.png).
明显有一个值的跳跃，在进一步加工，将\\(sum(f'(x,y))\\)取一个均值。得到如下图：
![](http://i13.tietuku.com/ff0cc5f29486dff9.png)
之后的算法的就很简单了，找出极值就行了。代码：

    function [re_pos re_img] = find3DImg(img) 
    
    [row_img column_img byte_img] = size(img);
    
    minvalue	= 800;
    store_pos	= -1;
    
    img1 = img;
    img2 = img;
    
    for i = 10:column_img - 10
    	showimg1 = img1(:,i:column_img,:);
    	showimg2 = img2(:,1:column_img - i + 1,:);
    
    	subimg = abs(showimg1 - showimg2);
    	sumimg = sum(subimg,3);
    
    	sumvalue = sum(sum(sumimg));
    
    	count = row_img * (column_img - i + 1);
    	count = max([count 1]);
    
    	value = sumvalue/count;
    
    	if value < minvalue
    		minvalue = value;
    		store_pos = i;
    	end
    end
    
    
    showimg1 = img1(:,store_pos:column_img,:);
    showimg2 = img2(:,1:column_img - store_pos + 1,:);
    
    subimg = abs(showimg1 - showimg2);
    
    re_pos = store_pos;
    re_img = subimg;
    
下面是展示的一些结果：
![](https://thumbnail0.baidupcs.com/thumbnail/8bc8e41b88f3645b9cc95c5800976387?fid=1124629257-250528-216667013962545&time=1499407200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-LPrpn28EtWATLPIEpeVJ0Cdqeys%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351540266995038768&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/94a0d6ae80a253fb3668b614aa68a5ad?fid=1124629257-250528-820294603898830&time=1499407200&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-IdycSfwDtS3HZfhPw9t0RToxMDs%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351548941826973239&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/c80a350f51b2a31a7a218f64a1bec3af?fid=1124629257-250528-544544821161225&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-ZvcfRBZz3Q6ipn1PtaijuFQ%2BoMc%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351558103576538383&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/c206b9375ce4ee6a7543d3ddf7b6d5eb?fid=1124629257-250528-233438908982727&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Qwi7X69vd%2BfDJmw2ufWnIdldgWc%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351565525431269248&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/53247d264cff2efba81b62c37b6733ae?fid=1124629257-250528-566282431397342&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-6CN6eE9KFibACEa0Cl%2FwmYe1z88%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351573049457970250&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/00e28524befb4b9fb84a5694f8f24b6d?fid=1124629257-250528-500529312475684&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-naKrJerK2lvcCxuyd3Fu0fhcKaI%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351592734435880155&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/92d1bb0658245c1e834a7d71e45740c5?fid=1124629257-250528-455419085213683&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-Weymbb2rfSvKMcCr6shrafC4D4I%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351597692101680534&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/7ffa7c854361aed4eabf3f6d368d280d?fid=1124629257-250528-719876588382043&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-8DpnF1iECLvzLWn%2FjneZDFqwXno%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351600817758343097&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
![](https://thumbnail0.baidupcs.com/thumbnail/4d88c9f11346bbf81b64759726c13da9?fid=1124629257-250528-144105465724966&time=1499410800&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-cOCr5Jif%2B3Eo4%2F%2F25ksDXUtYLPI%3D&expires=8h&chkv=0&chkbd=0&chkpc=&dp-logid=4351603626359501357&dp-callid=0&size=c710_u400&quality=100&vuk=-&ft=video)
