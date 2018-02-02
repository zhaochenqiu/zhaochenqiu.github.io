title: vim配置笔记
date: 2015-9-11 21:27:01
tags: Linux
abstract: 传说中的编辑器之神，我也终于算是入门了。记录下vim的配置，将其打造成炫酷的开发环境
---
-- 为了熟悉vim，来来回回折腾了也快一年了。作为传说中的编辑器之神，vim的扩展功能确实让人着迷。**这里记录下我自己的
vim配置，希望对喜欢vim的人有所帮助** --

## 为什么要使用vim ？
这个问题真的是太难回答了,不可否认，在实际项目的开发中，很少会用到vim。但vim就没用了么？答案肯定是否定的，毕竟那么多的高手最后都选择用vim而抛弃了IDE（当然也有用emacs）。stackoverflow上有一个回答vim的可以看[这里](http://stackoverflow.com/questions/597077/what-are-the-benefits-of-learning-vim)。此外，以前一个老师跟我说一句话，他说**一切都是为了效率**。我觉这句话回答了为什么要使用vim。vim确实很难上手，但是一旦上手，确实比IDE的效率要高。首先，你的双手可以一直不离开键盘。再者，vim的扩展性足以让他成为任何一个IDE。最后，IDE都是针对某一类特定的软件开发，他的效率高只是针对某一类软件，而对于其他类的软件效率就会降低，而vim因为他命令行的特性，其软件开发的类型，完全取决于开发者的配置。理论上vim可以开发任何类型的软件。

## 看完这篇博文你能得到什么？
这篇博文记录我的vim配置过程。其中包括我希望达到的效果和所使用的方法。对想学vim但又不知道怎么入手的人有很大的帮助。当然，如果是高手就请不要笑话我了

## 我的vim配置
我的vim是在cygwin下安装的,但是和普通的vim是几乎一样的。先截一张我的vim的效果图：
![效果截图](http://i3.tietuku.com/903bf9b97b34ff5d.png)

### vim 基本配置
这一段介绍vim的一些基本配置，包括一些简单的vim语法。
首先是一些外观上的设置，显示行号

	set number

打开语法高亮

	syntax on
设置tab键位的空格为4格，启动自动缩进，只能缩进

	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set autoindent	"always set autoindenting on"
	set smartindent	"set smart indent"
	set smarttab	"use tabs at the start of a line, spaces elsewhere"

不生成临时文件

	set foldmethod=marker
	set noswapfile
	set nowritebackup
	set nobackup

设置行折叠,当然也有不折叠的

	set wrap
	set nowrap

之后加一个自动换行,其中，`tw`的意思是textwidth

	set tw=72

接着是一个比较蛋疼的，vim的编码环境。

	" =====================
	" 多语言环境
	" 默认为 UTF-8 编码
	" =====================
	if has("multi_byte")
	    set encoding=utf-8
	    " English messages only
	    "language messages zh_CN.utf-8
  
		if has('win32')
			language english
	        let &termencoding=&encoding
		endif
  
	    set fencs=ucs-bom,utf-8,gbk,cp936,latin1
	    set formatoptions+=mM
		set nobomb " 不使用 Unicode 签名
  
	    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		    set ambiwidth=double
	    endif
	else
		echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
	endif

最后加上一个刻有可无的功能，高亮当前行和列

	set cursorline
	hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

	set cursorcolumn
	hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

至此，vim的基本配置已经完成了。

### 代码自动补全
vim补全的快捷键是`ctrl+p`.虽然我不是很喜欢插件，但补全确认是装插件比较好。我用的插件是neocomplete.这里直接介绍下载，安装方法。关于他的介绍可以看[这里](https://github.com/Shougo/neocomplete.vim)首先下载neocomplete，[下载地址](https://github.com/Shougo/neocomplete.vim)下载好了之后，只需要把`autoload`和`plugin`两个文件夹方法vim的安装目录去就可以了。直接拷贝。安装之后，还需要进行vim的配置。最简单的配置方法是

	let g:neocomplcache_enable_quick_match = 1

当然，neocomplete的作者也给出他的配置，如果没有特殊的需求是可以直接用的，需要的人可以看[这里](http://foocoder.com/blog/mei-ri-vimcha-jian-qiang-da-de-zi-dong-bu-quan-neocomplete-dot-vim.html/)或者[这里](https://github.com/Shougo/neocomplete.vim)这样代码的自动补全功能已经完成。但是如果自己配过的人一定已经发现，这个补全功能的配置巨丑无比。所以要再增加两行补全窗口的配置方案。

	highlight Pmenu  ctermbg=darkgrey ctermfg=black    guibg=darkgrey  guifg=black
	highlight PmenuSel guibg=lightgrey guifg=black

其中`Pmenu`就是补全弹出的窗口，而`PmenuSel`就是选择的窗口。`ctermbg`和
`ctermfg`就是前景和背景颜色。

### 一键编译运行
一键编译运行有很多中实现方式，我是利用两个bat实现编译和运行。`build.bat`和`run.bat`.当然linux下利用shell就行了。我的环境是win8，所以利用bat。而一键编译运行就变成了在vim中一键执行`build.bat`和`run.bat`.首先是两个执行函数。

	func! Run() 
	    exec 'w'
	    exec '!./run.bat'	
	endfunc

	func! Complie()
	    exec 'w'
	    exec '!./build.bat'
	endfunc

接着就是两个键位映射操作

	map <f5> :call Run()<CR>
	map <f7> :call Complie()<CR>

我的编译和运行分别是`F7`和`F5`

### 黑客帝国
首先声明，这不是我写的，是抄的网上的。介于可能很多同学用不了谷歌，所以我把结果直接贴上，原文在[这里](https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=matrix.vim)需翻墙.下面这段直接贴进去，然后按F11就可以执行了。附上一张效果图
![黑客帝国](http://i3.tietuku.com/65e1e7a6841adf0f.jpg)



	function! s:Rand()
	   let b:seed = b:seed * 22695477 + 1
	   if b:seed < 0
		  return -b:seed
	   endif
	   return b:seed
	endfunction

	function! s:CreateObject(i)
	   while 1
		  let b:x{a:i} = s:Rand() % b:columns
		  if b:reserve{b:x{a:i}} > 4
			 break
		  endif
	   endwhile
	   let b:y{a:i} = 1
	   let b:t{a:i} = s:Rand() % b:s{b:x{a:i}}
	   let b:head{a:i} = s:Rand() % 4
	   let b:len{a:i} = s:Rand() % b:h + 3
	   let b:reserve{b:x{a:i}} = 1 - b:len{a:i}
	endfunction

	function! s:DrawObject(i)
	   let x = b:x{a:i} * 2 + 1
	   let y = b:y{a:i}

	   " Draw head
	   if y <= b:h
		  if b:head{a:i}
			 silent! exec 'norm! :' . y . nr2char(13) . x . '|R' . b:d[s:Rand()%b:dl] . '_' . nr2char(27)
			 if y > 1
				silent! exec 'norm! kR' . ((s:Rand() % 2) ? '`' : ' ') . nr2char(27)
			 endif
		  else
			 let a = ((s:Rand() % 2) ? '`' : ' ') . nr2char(27)
			 silent! exec 'norm! :'. y . nr2char(13) . x . '|R' . b:d[s:Rand() % b:dl] . a
		  endif
	   else
		  if b:head{a:i} && y == b:h + 1
			 silent! exec 'norm! :' . b:h . nr2char(13) . (x + 1) . '|R' . ((s:Rand() % 2) ? '`' : ' ') . nr2char(27)
		  endif
	   endif

	   " Draw tail
	   let y = y - b:len{a:i}
	   if 1 <= y && y <= b:h
		  silent! exec 'norm! :'. y . nr2char(13) . x . '|R  ' . nr2char(27)
	   endif
	   let b:reserve{b:x{a:i}} = y
	endfunction

	function! s:Animate()
	   let i = 0

	   while i < b:objcount
		  " Animate object
		  if b:t{i} <= 0
			 if b:y{i} - b:len{i} <= b:h
				" Draw
				call s:DrawObject(i)
				let b:t{i} = b:s{b:x{i}}
				let b:y{i} = b:y{i} + 1
			 else
				" Regenerate
				call s:CreateObject(i)
			 endif
		  endif

		  let b:t{i} = b:t{i} - 1
		  let i = i + 1
	   endwhile
	   redraw
	   if getchar(1)
		  let b:run = 0
	   endif
	   sleep 20m
	endfunction

	function! s:Reset()
	   " Clear screen
	   let b:w = winwidth(0)
	   let b:h = winheight(0)
	   exec 'norm! gg"_dG' . b:h . 'O' . nr2char(27) . 'gg'
	   redraw
	   if b:w < 10 || b:h < 8
		  let b:run = 0
		  return
	   endif

	   " Set number of columns.  This is rounded down due to line wrapping
	   " at the last column if the screen width is even.  So you end up
	   " seeing the cursor blinking a lot at the right side of the screen.
	   " Alternatively, ':set rl' before running the script to have it
	   " blink on the left side.
	   let b:columns = (b:w - 1) / 2

	   " Initialize columns.
	   let i = 0
	   while i < b:columns
		  " Set delay time.  Each column gets the same delay time.
		  let b:s{i} = s:Rand() % (s:maxdelay - s:mindelay) + s:mindelay

		  " Unreserve column
		  let b:reserve{i} = b:h
		  let i = i + 1
	   endwhile

	   " Initialize objects
	   let b:objcount = b:columns - 2
	   let i = 0
	   while i < b:objcount
		  call s:CreateObject(i)
		  let i = i + 1
	   endwhile
	endfunction

	function! s:Init()
	   " Create new buffer and hide the existing buffers.  Hiding the
	   " existing buffers without switching to a new buffer preserves
	   " undo history.
	   exec 'mksession! ' . s:session_file
	   let s:num_orig_win = winnr("$")

	   " move to top window, so created window will become window 1,
	   " then attempt to create new window
	   1 wincmd w
	   silent! new

	   " check that there really is an additional window
	   if winnr("$") != s:num_orig_win + 1
		  return 1
	   endif
	   let s:newbuf = bufnr('%')

	   " close all but window 1, which is the new window
	   only

	   setl bh=delete bt=nofile ma nolist nonu noro noswf tw=0 nowrap

	   " Set GUI options
	   if has('gui')
		  let s:o_gcr = &gcr
		  let s:o_go = &go
		  set gcr=a:ver1-blinkon0 go=
	   endif
	   if has('cmdline_info')
		  let s:o_ru = &ru
		  let s:o_sc = &sc
		  set noru nosc
	   endif
	   if has('title')
		  let s:o_ts = &titlestring
		  exec 'set titlestring=\ '
	   endif
	   if v:version >= 700
		  let s:o_spell = &spell
		  let s:o_cul = &cul
		  let s:o_cuc = &cuc
		  set nospell nocul nocuc
	   endif
	   let s:o_ch = &ch
	   let s:o_ls = &ls
	   let s:o_lz = &lz
	   let s:o_siso = &siso
	   let s:o_sm = &sm
	   let s:o_smd = &smd
	   let s:o_so = &so
	   let s:o_ve = &ve
	   set ch=1 ls=0 lz nosm nosmd siso=0 so=0 ve=all

	   " Initialize PRNG
	   let b:seed = localtime()
	   let b:run = 1

	   " Clear screen and initialize objects
	   call s:Reset()

	   " Set colors.  Output looks better if your color scheme has black
	   " background.  I would rather not have the script change the
	   " current color scheme since there is no good way to restore them
	   " afterwards.
	   hi MatrixHidden ctermfg=Black ctermbg=Black guifg=#000000 guibg=#000000
	   hi MatrixNormal ctermfg=DarkGreen ctermbg=Black guifg=#008000 guibg=#000000
	   hi MatrixBold ctermfg=LightGreen ctermbg=Black guifg=#00ff00 guibg=#000000
	   hi MatrixHead ctermfg=White ctermbg=Black guifg=#ffffff guibg=#000000
	   sy match MatrixNormal /^.*/ contains=MatrixHidden
	   sy match MatrixHidden contained /.`/ contains=MatrixBold
	   sy match MatrixHidden contained /._/ contains=MatrixHead
	   sy match MatrixBold contained /.\(`\)\@=/
	   sy match MatrixHead contained /.\(_\)\@=/

	   " Create random char dictionary
	   let b:d = ''
	   let i = 33
	   while i < 127
		  if i != 95 && i != 96
			 let b:d = b:d . nr2char(i)
		  endif
		  let i = i + 1
	   endwhile
	   let b:dl = strlen(b:d)
	   return 0
	endfunction

	function! s:Cleanup()
	   " Restore options
	   if has('gui')
		  let &gcr = s:o_gcr
		  let &go = s:o_go
		  unlet s:o_gcr s:o_go
	   endif
	   if has('cmdline_info')
		  let &ru = s:o_ru
		  let &sc = s:o_sc
		  unlet s:o_ru s:o_sc
	   endif
	   if has('title')
		  let &titlestring = s:o_ts
		  unlet s:o_ts
	   endif
	   if v:version >= 700
		  let &spell = s:o_spell
		  let &cul = s:o_cul
		  let &cuc = s:o_cuc
		  unlet s:o_cul s:o_cuc
	   endif
	   let &ch = s:o_ch
	   let &ls = s:o_ls
	   let &lz = s:o_lz
	   let &siso = s:o_siso
	   let &sm = s:o_sm
	   let &smd = s:o_smd
	   let &so = s:o_so
	   let &ve = s:o_ve
	   unlet s:o_ch s:o_ls s:o_lz s:o_siso s:o_sm s:o_smd s:o_so s:o_ve

	   " Restore old buffers
	   exec 'source ' . s:session_file
	   exec 'bwipe ' . s:newbuf
	   unlet s:newbuf

	   " Clear keystroke
	   let c = getchar(0)
	endfunction

	function! Matrix()
	   if s:Init()
		  echohl ErrorMsg
		  echon 'Can not create window'
		  echohl None
		  return
	   endif

	   while b:run
		  if b:w != winwidth(0) || b:h != winheight(0)
			 call s:Reset()
		  else
			 call s:Animate()
		  endif
	   endwhile

	   call s:Cleanup()
	endfunction


	if !has('virtualedit') || !has('windows') || !has('syntax')
	   echohl ErrorMsg
	   echon 'Not enough features, need at least +virtualedit, +windows and +syntax'
	   echohl None
	else
	   command! Matrix call Matrix()
	endif

	map <f11> :call Matrix()<CR>


