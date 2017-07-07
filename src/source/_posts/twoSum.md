title: leetcode Two Sum
date: 2015-9-16 01:15:07
tags: 算法
abstract: 一直在刷leetcode，写几个觉的有意思的，同时效果也比较好的算法，写写思想和实现过程，希望对看到的人有帮助。算法全部原创，没有抄袭。这次是leetcode的Two Sum问题,使用哈希的思想，最后结果超过了99%的人。
---
-- 一直在玩leetcode，找几个有意思而且效果好的算法写写。这是次是利用哈希的思想解决Two Sum。**最后结果显示超越了99%的使用`c++`的人。记录下我整个解决的思路和实现过程，希望对喜欢算法的人有帮助** --

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>


## 看完这篇博文你能得到什么？
Two Sum问题网上找得到很多答案。这里从一种不一样的角度去解决这个问题，**不使用对比查找，而是直接使用哈希去映射**。这样可以极大的提高查找的速度。

## Two Sum问题简介
> Given an array of integers, find two numbers such that they add up to a specific target number.
> The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.
> You may assume that each input would have exactly one solution.

> Input: numbers={2, 7, 11, 15}, target=9
> Output: index1=1, index2=2

大致翻译一下啊，就是说有一个排好序的数组`numbers`,一个数字`target=9`,现在求这个数据中那两个数相加等于`target`,输出这两个数字所在的位置。leetcode的借口定义如下：

	class Solution 
	{
	public:

	    vector<int> twoSum(vector<int> &numbers, int target) 
	    {
	    }
	};

这个意思就是，他输入的是一个`vector<int>`，然后要求输出一个保存了结果的`vector<int>`。

## 问题分析思路
最直观最简单的解法就是做一个嵌套的循环,遍历所有可能的组合，这样查找的次数就是\\(n + (n - 1) + (n - 2) ... + 2\\).这样的复杂度是是\\(O(n_2)\\),显然是不行的。再反观题意**两个数字相加等于`target`,意味着，一旦知道第一个数字那么肯定就能知道第二个数字，所以这个问题就变成了一个查找问题**。及知道了一个数字为`num1`,那么第二个数字的值就是`target - num1`,然后在数组中找出这个数字即可，二分查找就够了。这样一来，复杂度就变成了\\(O(nlogn)\\).好像效率还不错，但是还有更快的方法吗？首先第一轮的主循环\\(n\\)次是不可能跑的掉的。因为每一个数字都有可能成为`target`的解。所以**重点应是放在第二个数组的查找上**。这个时候当然是祭出最快的查找方法-**哈希**因此重点就变成了如何设计这个哈希，让他可以在这个问题中发挥作用。

## 问题解法
设计一个哈希表\\(poslist\\)，首先表中所有的数字变成-1。接着输入一个\\(num1\\)，然后把\\(poslist\\)中\\(num1\\)位置的数字变成另一个非-1的数字（为了方便直接变成\\(num1\\)所在的位置），及改变他的标识位。然后计算出另一个数字\\(num2=target-num1\\)。接着查询\\(poslist\\)中\\(num2\\)的位置标识位是否为-1，如果不是，那么就已经找到了这两个数字。这个时候终止循环，输出\\(poslist\\)中存储的\\(num1\\)和\\(num2\\)的位置即可。如果以题目中的例子，就是如下图(为了方便，我的哈希直接使用数组下标，虽然会比较耗内存，但是方便，而且实际中已经有很多很好的哈希函数了，内存肯定不是问题，**这里这么做只是为了方便，并不推荐这么做**):

首先输入的\\(num1=2\\),然后将对应哈希表中的数据改成\\(num1\\)中的位置1，同时查询\\(num2=tart-num1=7\\),发现表中的内容的是-1，因此继续下一个数字。

![第一次数据输入](http://i3.tietuku.com/ff2d4b48e76cae4d.png)

这次输入的数字\\(num1=7\\),计算得到的\\(num2=2\\);发现找到了最终结果，此时输出哈希表的结果，然后终止循环.

![第二次数据输入](http://i3.tietuku.com/045c292ec61aed1d.png)

这样一来，相当于数组中的每一个数字只被查找了一次，那么算法复杂度为\\(O(n)\\),几乎已经达到了极限。下面图是运行结果，**超过了99%的**的c++提交结果。说明这种方法确实也达到了极限。





![运行结果](http://i3.tietuku.com/fc3add1ae975ccb5.png)
![运行结果](http://i3.tietuku.com/cbb2a3bcf168f446.png)

## 示例代码
	class Solution 
	{
	public:

	    vector<int> twoSum(vector<int> &numbers, int target) 
	    {
	        vector<int> result;
	        
	        int offset = numbers[0];
	        int i;
	        int oldpos = -1;
	        int search = -1;
	        int* poslist = NULL;
	        
	        for (i = 0;i != numbers.size();i ++)
	        {
	            if (offset > numbers[i])
	            {
	                offset = numbers[i];
	            }
	        }
	        
	        target  = target - 2*offset;
	        poslist = new int [target + 1];
	        
	        for (i = 0;i != numbers.size();i ++)
	        {
	            numbers[i] = numbers[i] - offset;
	        }
	        
	        for (i = 0;i != target + 1;i ++)
	        {
	            poslist[i] = -1;
	        }
	        
	        for (i = 0;i != numbers.size();i ++)
	        {
	            if (numbers[i] <= target)
	            {
	                oldpos = poslist[numbers[i]];
	                poslist[numbers[i]] = i;
	                
	                search = target - numbers[i];
	                
	                if (poslist[search] >= 0)
	                {
	                    if (search == numbers[i])
	                    {
	                        if (oldpos != -1)
	                        {
	                            search = i;
	                            break;
	                        }
	                    }
	                    else
	                    {
	                        oldpos = i;
	                        search = poslist[search];
	                        break;
	                    }
	                }
	            }
	        }
	        
	        oldpos ++;
	        search ++;
	        
	        if (oldpos > search)
	        {
	            result.push_back(search);
	            result.push_back(oldpos);
	        }
	        else
	        {
	            result.push_back(oldpos);
	            result.push_back(search);
	        }
	        
	        delete [] poslist;
	        
	        return result;
	    }
	};
