title: 利用索引树去统计单词出现频率
date: 2013-10-13 13:26:04
tags: C++/数据结构
abstract: 一个统计词频的程序，利用多路树实现
---
-- 一个统计词频的程序，利用多路树实现 --

<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

一种最撇的统计单词的方法就是挨个对比

当然这种方法显然是不可行的，因为假设有n不同的单词，那么单词的对比次数就是
\\[ f(n) = 0 \times (n) + 1 \times (n - 1) + 2 \times (n - 2) \dots (n-1) \times 1 + n \times 0 = \sum_{n}^{0}i(n - i) \\]

而且这个只是基本的单词的对比
两个单词的比较又不一样，假设\\(k\_{i}\\)表示第\\(i\\)个单词包含的字母数
所以总的对比次数就是
\\[h(n) = \sum\_{n}^{0}i(n - 1)k\_{i}k\_{n - i}\\]
复杂度过大
利用树就可以极大的减小复杂度。
算法的思想就是，输入一个单词，然后将这个单词的每一个字母作为树的一个子项，之后不断的去生成这个树。
然后如果发现这个单词已经存在，那么就是将这个单词的数量加1，如果这个单词不存在，那么在树中就会查找失败，然后创建就可以了。

因为树是动态创建的，所以可以起到剪枝作用，而且存储也只是占最小的空间。

先看效果，先是一篇普通的英文文章: 
出处:http://www.duwenzhang.com/wenzhang/yingyuwenzhang/20130519/255870.html
My father was a self-taught mandolin player. He was one of the best string instrument players in our town. He could not read music, but if he heard a tune a few times, he could play it. When he was younger, he was a member of a small country music band. They would play at local dances and on a few occasions would play for the local radio station. He often told us how he had auditioned and earned a position in a band that featured Patsy Cline as their lead singer. He told the family that after ........(文章太长，不全部粘贴了，占空间)
最后的统计结果就是:
![](http://imageshack.com/a/img923/7448/eOH7gh.png)

注意红圈中的，就是出现次数很多的，像was就出现了25次，he出现了50次。
这篇文章大概是一千词左右，在我自己的电脑上几乎就是瞬时刷出来的，说明效率还是不错的。
下面就是具体的实现细节：
树的设计很重要，用一个动态生成的索引树去存储。
所谓的索引树，就是单词前面的字母就是树的根节点，例如is 那么i就是根节点，s就是子节点，
那么一个存了is，would，was的索引树 ，就会是下面的样子
![](http://imageshack.com/a/img922/5500/8Gkwhn.png)
查找is时就是先对比i,然后对比s就将is查出来了。
如果来了一个新单词，例如he,那么树在第一层对比的时候就会发现h这个字母没有，那么他就是自己再创建一个h的节点
![](http://imageshack.com/a/img921/4103/S0q033.png)
接着在h节点的子节点中没有找到e这个子项，那么他又会自己创建一个e子项
![](http://imageshack.com/a/img922/6328/nGUupe.png)
这样树的自己学习功能就实现了，接下来的事情只要给树不停的喂数据就可以了。
一下是具体的实现细节:
因为树节点有多少个子节点是不确定，所以这个树的子节点，要可以动态的增加和减少。
因此树的节点，应该就是*一个节点的数据，和保存子节点指针的链表*组成。

	#ifndef _STUDYTREENODE_H_
	#define _STUDYTREENODE_H_

	#include "seqlist.h"

	// Author:Q
	// Date:2013/10/11
	// Describe:学习树的节点，其实就是一个多路树的节点

	template <class Data>
	class StudyTreeNode
	{
	public:
		StudyTreeNode();
		StudyTreeNode(Data data);
		StudyTreeNode(Data data,StudyTreeNode<Data* > next);
		~StudyTreeNode();
		
		int        m_iCount;
		Data    m_dData;
		SeqList<StudyTreeNode<Data>* >    m_listNext;
	};

	#endif

	template <class Data>
	StudyTreeNode<Data>::StudyTreeNode()
	{
		m_iCount = 0;
	}

	template <class Data>
	StudyTreeNode<Data>::StudyTreeNode(Data data)
	{
		m_iCount = 0;
		m_dData = data;
	}

	template <class Data>
	StudyTreeNode<Data>::StudyTreeNode(Data data,StudyTreeNode<Data* > next)
	{
		m_iCount     = 0;
		m_dData     = data;
		m_listNext     = next;
	}

	template <class Data>
	StudyTreeNode<Data>::~StudyTreeNode()
	{
		m_listNext.clearList();
	}
这个树中多了一个参数int        m_iCount;这个参数的目的就是为了统计单词出现了多少次。
然后就是最重要的部分，树的设计，一下就是树的声明。

#ifndef _STUDYTREE_H_
#define _STUDYTREE_H_

// Author:Q
// Date:2013/10/11
// Describe:一个自我学习的树，可以自己扩展节点
// 只需要给他输入数据即可，他会自己生成树

	#include "studytreenode.h"

	template <class Data>
	class StudyTree
	{
	public:
		StudyTree();
		~StudyTree();
		
		void checkData(Data* list,int num);
		
		void preOrder();
		void postOrder();
		
		void levelOrder();
		
		void release();
		
		void printfTreeCnt();
		void printfResult();
		
		int getDepth();
		
	protected:
		void checkData(Data* list,int num,int pos,StudyTreeNode<Data>* &node);
		
		void preOrder(    StudyTreeNode<Data>* node);
		void postOrder(    StudyTreeNode<Data>* node);
		
		void levelOrder(StudyTreeNode<Data>* node);
		
		void release(StudyTreeNode<Data>* &node);
		
		void printfTreeCnt(StudyTreeNode<Data>* node);
		void printfResult(StudyTreeNode<Data>*     node,char* outlist,int num);
		
		int getDepth(StudyTreeNode<Data>* node,int pos,int &depth);
	protected:
		StudyTreeNode<Data>* m_ndHead;
	};

	#endif
其中最重要的函数就是
	void checkData(Data* list,int num);
	void checkData(Data* list,int num,int pos,StudyTreeNode<Data>* &node);
这两个函数就是生产树的核心代码
上面的函数声明为public，是让用户调用的，下面的函数声明为protected,实际的递归生成函数

这里着重讲void checkData(Data* list,int num,int pos,StudyTreeNode<Data>* &node);函数

第一个参数就是实际的单词数据，一个char* 类型(不明白为什么Data* 变成char*? 这种无聊的问题不要问，自己看代码)

	template <class Data>
	void StudyTree<Data>::checkData(Data* list,int num)
	{
		int pos = 0;
		checkData(list,num,pos,m_ndHead);
	}

	template <class Data>
	void StudyTree<Data>::checkData(Data* list,int num,int pos,StudyTreeNode<Data>* &node)
	{
		if (node == NULL)
		{
			node = new StudyTreeNode<Data>(list[pos]);
			// std::cout << "\nCreate Data = " << list[pos];
		}

		
		if (num != pos)
		{
			int mark = -1;
		
			int i;
			for (i = 0;i != node ->m_listNext.getNum();i ++)
			{
				if (node ->m_listNext[i] ->m_dData == list[pos])
				{
					mark = i;
					break;
				}
			}
			
			if (mark == -1)        // 未发现这个元素，重新创建
			{
				mark = node ->m_listNext.getNum();
				StudyTreeNode<Data>* newnode = new StudyTreeNode<Data>(list[pos]);
				// std::cout << "\nCreate Data = " << list[pos];
				node ->m_listNext.insert(newnode);
			}
			
			checkData(list,num,pos + 1,node ->m_listNext[mark]);
		}
		else
		{
			node ->m_iCount ++;
		}
	}
	
我觉的这段代码还是没什么好说的，意思很明显。
喂了数据之后，树就生成了。而且因为树是运行过程中生成的，所以本身就带有剪枝的效果。

然后说说如何打印出结果；
之前不是在树的节点中加了一个计数的m_iCount 么，通过判断，只有这个值为0的时候（那么就表示这个是一个单词的结尾了）就将结果输出。然后输出这个值，这样只要将树按照类似于中序遍历的方式，就可以将所有的结果输出了。

	template <class Data>
	void StudyTree<Data>::printfResult()
	{
		int length         = getDepth();
		char* templist     = new char [length];
		int num            = 0;
		
		int i;
		for (i = 0;i != m_ndHead ->m_listNext.getNum();i ++)
		{
			printfResult(m_ndHead ->m_listNext[i],templist,num);
		}
		
		delete [] templist;
	}

	template <class Data>
	void StudyTree<Data>::printfResult(StudyTreeNode<Data>* node,char* outlist,int num)
	{
		outlist[num] = node ->m_dData;
		num ++;
		
		int i;
		if (node ->m_iCount == 0)
		{
			for (i = 0;i != node ->m_listNext.getNum();i ++)
			{
				printfResult(node ->m_listNext[i],outlist,num);
			}
		}
		else
		{
			for (i = 0;i != num;i ++)
			{
				std::cout << outlist[i];
			}
			
			std::cout << ":" << node ->m_iCount << " ";
			
			for (i = 0;i != node ->m_listNext.getNum();i ++)
			{
				printfResult(node ->m_listNext[i],outlist,num);
			}
		}
	}
这里用一个char* 的缓冲，去保存过程，只有当计数器不为0的时候才输出。

下面就是一个测试的demo了

	#include "studytree.h"
	#include <fstream>
	#include <string>

	using namespace std;


	int main()
	{
		StudyTree<char> stytree;
		
		fstream infile("data.txt");
		string str;
		
		while (infile >> str)
		{
			int length = str.length();
			char* tmplist = new char [length];
			
			int j;
			for (j = 0;j != length;j ++)
			{
				tmplist[j] = str[j];
			}
			
			stytree.checkData(tmplist,length);
		}
		
		infile.close();
		
		stytree.printfResult();

		return 0;
	}
data.txt保存的就是文章中所有的单词。
![](http://imageshack.com/a/img921/8573/s86Kni.png)

这个就是数据的前期处理。

下面就介绍下怎么把刚刚那篇文章处理成这个样子。
先是一篇普普通通的文章，直接从网上copy下来的。
![](http://imageshack.com/a/img924/5975/WVn8ZE.png)
第一步是去除标点。方法很多，我为了复习下lex的使用，写了个简单的正则表达式。
[,\.'":;?-] {printf(" ");}

然后数据就会变得没有标点了。
![](http://imageshack.com/a/img924/54/WegTwe.jpg)
下面就是要把单词大小写统一，然后一行一个单词。
	#include <iostream>
	#include <string>
	#include <fstream>
	#include "dos.h"

	using namespace std;

	int main(int argc,char* argv[])
	{
		ifstream infile(argv[1]);        // 读取字符串
		ofstream outfile(argv[2]);        // 写入字符串
		
		string str;
		
		int sub = 'a' - 'A';
		
		while (infile >> str)
		{
			string pstr = "";
			
			int i;
			for (i = 0;i != str.length();i ++)
			{
				if (str[i] <= 'z' && str[i] >= 'a')
				{
					pstr += str[i];
				}
				else if (str[i] <= 'Z' && str[i] >= 'A')
				{
					pstr += char(str[i] + sub);
				}
				else
				{
				}
			}
			
			outfile << pstr << "\n";
		}
		
		infile.close();
		outfile.close();
		return 0;
	}
这样一来，数据就会变得符合标准了。
![](http://imageshack.com/a/img922/3792/xLQk2U.png)