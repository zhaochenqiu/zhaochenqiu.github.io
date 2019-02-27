title: RPCA矩阵分析与主成分追赶
date: 2019-02-26 22:00:00
tags: 图像处理
---
一个数据矩阵分解为低秩矩阵与稀疏矩阵，分别代表了前景与背景
<!--more-->

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

# 矩阵分解
假设有一个很大的数据矩阵\\(M\\)，他可以被分解为一个低秩矩阵\\(L_0\\) 和一个稀疏矩阵\\(S_0\\).
数学表达如下：
\\[
M = L_0 + N_0
\\]
分解方法如下：
\\[
minimize \quad ||M - L|| \\\\
subject \ to \quad rank(L) \leq k
\\]
\\(||M|| \\)就是矩阵的奇异值，因为矩阵可以被投影到不同的矩阵。
而解法就是减去M的主成分，也就是最大奇异值所重构的矩阵。
这样剩下的就一定会稀疏了。为什么会低秩？因为其基是一样的。
所以时间序列上的主成分就是背景。具体的用矩阵分解来做background subtraction如下：
{% codeblock lang:matlab %}
clear all
close all
clc

addpath('D:\projects\matrix\common');
addpath('D:\projects\matrix\common_c');

im_pa = 'D:\dataset\dataset2014\dataset\baseline\highway\input';
im_ft = 'jpg';

[files data] = loadData_plus(im_pa, im_ft);

[row_im column_im byte_im frames_im] = size(data);

data_gray = zeros(row_im, column_im, 1, frames_im);

for i = 1:frames_im
    im = data(:, :, :, i);
    data_gray(:, :, :, i) = grayImage(im);
end


data_gray = squeeze(data_gray);
data_bk = abs(data_gray - data_gray);
data_bkim = abs(data_gray - data_gray);


num = 1;

for i = 1:row_im
    matrix = data_gray(i, :, :);

    matrix = squeeze(matrix);

    matrix = matrix';
    [U S V] = svd(matrix);


    matrix_ = U * S(:, 1:num) * V(:, 1:num)';

    bkim = abs(matrix - matrix_);
    bkim = bkim';

    data_bk(i, :, :) = bkim;
    data_bkim(i, :, :) = matrix_';

    i
end


for i = 1:frames_im
    im = data_bk(:, :, i);
    bkim = data_bkim(:, :, i);
    grayim = data_gray(:, :, i);

    displayMatrixImage(i, 1, 3, grayim, im, bkim);
end
{% endcodeblock %}



