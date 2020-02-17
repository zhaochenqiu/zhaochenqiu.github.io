title: mexopencv 安装笔记
date: 2019-03-08 14:01:56
tags: 图像处理
---
记录mexopencv 安装过程
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 下载安装Opencv
先下载[opencv 3.4.1](https://github.com/opencv/opencv/releases/tag/3.4.1),
和[opencv-3.4.1-contrib](https://github.com/opencv/opencv_contrib/releases/tag/3.4.1).
下载后解压i

要装一下cmake,
可以直接在opencv 3.4.1的目录里sudo apt-get install cmake.
之后这个目录会多一个cmake文件夹如下：

    cqzhao@hotchkiss-XPS-8700:~/libs/opencv/opencv-3.4.1$ ls
    3rdparty  build  CMakeLists.txt   data  include  modules    README.md
    apps      cmake  CONTRIBUTING.md  doc   LICENSE  platforms  samples
    cqzhao@hotchkiss-XPS-8700:~/libs/opencv/opencv-3.4.1$ 

上面的那个cmake就是 apt-get install cmake后生成的.

然后 mkdir build, cd build, cmake ../即可
然后进入到build里make和sudo make install

opencv_contrib 有点不同，文档在[这里](https://github.com/opencv/opencv_contrib).
他是个opencv的扩展，所以只是加在参数中命令

    $ cd <opencv_build_directory>
    $ cmake -DOPENCV_EXTRA_MODULES_PATH=<opencv_contrib>/modules <opencv_source_directory>
    $ make -j5

上的j5 是指最多同时允许5个任务，不加就是同时运行无限个任务.盗一个参数表：

    用法：make [选项] [目标] ... 选项： -b, -m                      忽略兼容性。
    -B, --always-make           无条件 make 所有目标。
    -C DIRECTORY, --directory=DIRECTORY
    在执行前先切换到 DIRECTORY 目录。 -d                          打印大量调试信息。
    --debug[=FLAGS]             打印各种调试信息。
    -e, --environment-overrides
    环境变量覆盖 makefile 中的变量。 -f FILE, --file=FILE, --makefile=FILE
    从 FILE 中读入 makefile。 -h, --help                  打印该消息并退出。
    -i, --ignore-errors         Ignore errors from commands. //和-k参数结合使用能够得到所有的编译错误信息
    -I DIRECTORY, --include-dir=DIRECTORY
    在 DIRECTORY 中搜索被包含的 makefile。 -j [N], --jobs[=N]          同时允许 N 个任务；无参数表明允许无限个任务。
    -k, --keep-going            当某些目标无法创建时仍然继续。
    -l [N], --load-average[=N], --max-load[=N]
    在系统负载高于 N 时不启动多任务。 -L, --check-symlink-times   使用软链接及软链接目标中修改时间较晚的一个。
    -n, --just-print, --dry-run, --recon
    不要实际运行任何命令;仅仅输出他们 -o FILE, --old-file=FILE, --assume-old=FILE
    将 FILE 当做很旧，不必重新生成。 -p, --print-data-base       打印 make 的内部数据库。
    -q, --question               不运行任何命令；退出状态说明是否已全部更新。
    -r, --no-builtin-rules      禁用内置隐含规则。
    -R, --no-builtin-variables   禁用内置变量设置。
    -s, --silent, --quiet       不显示命令。
    -S, --no-keep-going, --stop
    关闭 -k。 -t, --touch                 touch 目标而不是重新创建它们。
    -v, --version               打印 make 的版本号并退出。
    -w, --print-directory       打印当前目录。
    --no-print-directory        关闭 -w，即使 -w 默认开启。
    -W FILE, --what-if=FILE, --new-file=FILE, --assume-new=FILE
    将 FILE 当做最新。 --warn-undefined-variables  当引用未定义变量的时候发出警告。
    该程序为 x86_64-pc-linux-gnu 编译 报告错误到 <bug-make@gnu.org> #### make completed successfully ####
    --------------------- 
    作者：007与狼共舞 
    来源：CSDN 
    原文：https://blog.csdn.net/manjianchao/article/details/54344855 
    版权声明：本文为博主原创文章，转载请附上博文链接！

记住这里有一个巨坑的bug，cuda opencv编译只能用gcc 5，否则就
cuda_compile_generated_mog.cu.o 有错.

解决的办法是[这里](http://answers.opencv.org/question/189712/unable-to-compile-opencv-with-cuda9-and-gcc6/).
实际上是cmake那一步加上 
    -D CUDA_HOST_COMPILER:FILEPATH=/usr/bin/gcc-5 ..

**实际的命令就是 cmake -D CUDA_HOST_COMPILER:FILEPATH=/usr/bin/gcc-5 ../不是上面的**

如果如下什么
libopencv_imgcodecs.so.3.4: cannot open shared
object file: No such file or directory.
check 下面这个链接
http://answers.opencv.org/question/6732/missing-shared-library/

如果出现下面这个bug

/lib/x86_64-linux-gnu/libz.so.1: version `ZLIB_1.2.9' not found (required by
/home/cqzhao/anaconda3/lib/libpng16.so.16).

解决方法：
https://stackoverflow.com/questions/48306849/lib-x86-64-linux-gnu-libz-so-1-version-zlib-1-2-9-not-found
