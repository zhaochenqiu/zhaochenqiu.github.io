#!/bin/bash

# 如果没有-s 的话，汉字会有乱码
# pandoc -s in.md -o out.html

# 模板变量
title="resume"
author="chenqiu"
date="2018-04-24"
lang="zh-CN"

# pandoc -s resume.md -o resume.html -t html5 --self-contained --section-divs --template=resume-template.html -T $title -c css/main.css  \
#    --variable lang=$lang --variable author-meta=$author --variable date-meta=$date


# title="title content"
# pandoc -s resume.md -o resume.html -t html5 --self-contained --section-divs --template=resume-template.html -c -T $title  css/main.css

# pandoc -s resume.md -o resume.html -t html5 --self-contained --section-divs --template=resume-template.html -T $title -c css/main.css 
pandoc -s resume.md -o index.html -t html5 --self-contained --section-divs --template=resume-template.html -c css/main.css 



