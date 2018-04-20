title: Python Programming
date: 2018-04-9
tags: python
---
The records of learning python.
<!--more-->

# Record
十六进制 0xAF = 175
八进制   010 = 8   **0开头不是二进制二十八进制**

cmath  是指 complex math

'#!/usr/bin/env python' 这行代码放在文件头然后chmod就可以直接执行 或者 '#!/usr/bin/pytho2'

python的格式化输出用print,使用%隔开例如

printf("%s",str) = print "%s" % str 当然python的单引号可以换成双引号

# dict 字典，其实就是hash映射
    #!/usr/bin/python2

    names = ['Alice', 'Beth', 'Cecil', 'Dee-Dee', 'Earl']
    numbers = ['2341', '9102', '3158', '0142', '5551']

    x= numbers[names.index('Cecil')]
    print x

python里是允许出现汉字的，为了强行增加汉字注，可以添加代码'# -*- coding: utf-8 -*-'，但不是一种好办法，最好是**不要在代码文件中引入ascii之外的字符**


