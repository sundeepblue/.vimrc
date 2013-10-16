" First edited at 5/1/2013 by sundeepblue
" Version 1.9 (Based on the commits) 9/10/2013

""""""""""""""""""""""""""""""""""""""""""""""""
" Pre-definitions
""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let g:mapleader=","

"auto reload vimrc when editing
autocmd! bufwritepost .vimrc source % 

""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin related settings
""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

" vim-easymotion
" Use '[' as leader key instead of the default <leader><leader>
" Using '/' may easily cause conflicts with search
let g:EasyMotion_leader_key="r"
" Disable 'r' when it is used as leader key
map r <Nop>
let g:EasyMotion_keys='asdfgqwertzxcvb'
let g:EasyMotion_grouping=1
let g:EasyMotion_do_shade=0
hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade Comment

" netrw
" undotree
" nerdtree
autocmd vimenter * NERDTree
nmap <leader>nt :NERDTree<cr>

" taglist
" cctree


""""""""""""""""" auto highlight words under cursor """""""""

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=2000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=200
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""
" My shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""
" set working directory to the current file. Each time when run
" a program, run this command to change working directory. Otherwise
" the program won't run
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nmap <leader>h :h<space>
nmap <leader>w :w<cr>	" fast saving
nmap <leader>x :q<cr>	" fast quit
nmap <leader>e :e<space>
nmap <leader>wq :wq<cr> " save and quit
nmap <leader>qf :q!<cr> " force quit

" count the total number of matches in the latest search
" :%s/./&/gn		count characters
" :%s/\i\+/&/gn		count words
nmap <leader>ct :%s///gn<cr>

" no need to input ':' manually, but lose the "go to next char" ability
map ; :
map ;; :norm<space>

" in cmd mode, enter %, !, ^, @ becomes easier
cmap 55 %
cmap 66 ^
cmap 11 !
cmap 22 @

" select all contents
map <leader>al ggVG
" easily select all contents using left-hand
map fa ggVG
" left-hand fast quit
map fq :q<cr>
" left-hand fast saving
map fw :w<cr>
" map fww :w!<cr>
" map fwq :w!<cr>:q<cr>
" left-hand list all matches, 'fs' means 'Fast Search list'
map fs :g//<cr>

" since 't' is barely used, why not map it to the frequently used 'top'?
" map t gg
" map 't' to 'page up'
map t <PageUp>
" since 'q' is rarely used, so i match it to a frequent operation
" map 'q' to 'page down'
map q <PageDown>

" next buffer
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Move around
"""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" map 00 I  " i want to make 00 as I, but it does not work. why?
" disable highlight
map <silent> <leader><cr> :noh<cr> 
map <space> /
" i manually map <Caps> to <Ctrl> in MAC Preference setting
" map <caps> <ctrl>
map <c-space> ?
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

map <left> <nop>
map <right> <nop>
map <up> <nop>
map <down> <nop>
" move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap<M-j> mz:m+<cr>`z
nmap<M-k> mz:m-2<cr>`z
vmap<M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap<M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

map <leader>te :tabnew<cr>
map <leader>tn :tabn<cr>
map <leader>tp :tabp<cr>
map <leader>to :tabonly<cr>
map <leader>tq :tabclose<cr>

imap ii <esc>
" map esc to tab for all modes
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>
" inoremap <Tab><Tab> <Tab>

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM User interface
"""""""""""""""""""""""""""""""""""""""""""""""""
syntax on               " turn syntax highlighting on by default
filetype on             " detect type of file
filetype indent on      " load indent file for specific file type
filetype plugin on 

set autoread 			" auto read when file is changed from outside
set history=100 		" keep 100 lines of command list history 
set nocompatible        " use vim defaults
set scrolloff=2         " keep 3 lines when scrolling
set ai                  " set auto-indenting on for programming
set si					" smart indent
set showcmd             " display incomplete commands
set showmode
set laststatus=2 		" always show the status line
" Format the status line
set smarttab			" be smart when using tabs
set shiftwidth=4
set tabstop=4		
set number              " show line numbers
set backspace=eol,start,indent " config backspace so it acts as it should act
set whichwrap+=<,>,h,l
" set relativenumber		" show relative line number
set ruler               " show the current row and column
set lazyredraw			" don't redraw while executing macros
set wrap				" line wrap
set linebreak			" do not break a word at end 
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set magic 				" for regular expression turn magic on
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present
set shortmess=atI		" do not show help uganda child message

set noerrorbells
set novisualbell

""""""""""""""""""""""""""""""""""""""""""""""""
" GUI related settings
""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

highlight StatusLine guifg=SlateBlue guibg=Red
highlight StatusLineNC guifg=Gray guibg=Blue

" When use NERDTree, remove the left-most vertical scrollbar
set guioptions-=L

if has("gui_running")
	set guifont=Courier:h14
	set t_Co=256		" 256 color mode
	set cursorline		" highlight current line
endif

set cursorline			" highlight current line

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""""""""""""""""""""""""""""""""""""""""""""""""
" Lightweight Latex editing
""""""""""""""""""""""""""""""""""""""""""""""""

" my paper related mappings
nmap <leader>l :w<cr>:!pdflatex<space>%<cr>:!open<space>dt.pdf<cr><cr>
nmap <leader>o :!open<space>dt.pdf<cr><cr>
nmap <leader>ll :w<cr>:!pdflatex<space>%<cr>:!bibtex<space>dt.aux<cr>:!pdflatex<space>%<cr>:!pdflatex<space>%<cr>:!open<space>dt.pdf<cr><cr>
" nmap <leader>cviu :e<space>~/Dropbox/research/IDEAS/IDEA_cvpr_iccv_tex/latex/CVIUfinal/CVIU.tex<cr>
" comment a latex line 
" vmap <leader>c :norm 0i%<cr>
" uncomment a latex line
" vmap <leader>uc :norm<space>0x<cr>


""""""""""""""""""""""""""""""""""""""""""""""""
" C/C++ file compiling
""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30 

" % means filename plus extension, %< means filename without extension
" compile/build c++ 
"nmap <leader>b :w<cr>:!g++<space>%<space>-o<space>%<<cr>
"nmap <leader>b :w<cr>:!g++ % -g -o %<<cr>

func! Debug()
	if &filetype=='c'
		exec "!gcc % -g -o %<"
		exec "!gdb %<"
	elseif &filetype=='cpp'
		exec "!g++ % -g -o %<"
		exec "!gdb %<"
	endif
endfunc

func! Compile()
	if &filetype=='c'
		exec "!gcc -Wall -enable-auto-import % -g -o %<"
	elseif &filetype=='cpp'
		exec "!g++ -Wall % -g -o %<"
	endif
endfunc

func! Run()
	exec "!./%<"
endfunc

set makeprg=g++\ \"%\"\ -g\ -o\ \"%<\"
" nmap <leader>b :w<CR>:!clear<CR>:make<CR>
nmap <leader>b :w<cr>:call Compile()<cr>:call Run()<cr>
nmap <leader>c :w<cr>:call Compile()<cr>
nmap <leader>r :call Run()<cr>
nmap <leader>d :call Debug()<cr>

" jump to next compile error
map <leader>cn :cn<cr>
" jump to previous compile error
map <leader>cp :cp<cr>
" jump to 1st compile error
map <leader>cf :cr<cr>
" jump to the last compile error
map <leader>cl :cla<cr>

