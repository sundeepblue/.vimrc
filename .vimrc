" ultimate vimrc configuration: https://github.com/skwp/dotfiles
" ultimate vimrc configuration 2: https://github.com/amix/vimrc
" http://vimawesome.com/
" http://benmccormick.org/2014/08/04/learning-vim-in-2014-search/


"
" do not change the following, they are required by vundle plugin manager
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ShowMarks'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'matze/vim-move'
Plugin 'klen/python-mode'

" had not figure out how to use yet
Plugin 'christoomey/vim-tmux-navigator'

" useful when in the future want to run make or compile code
" need to run tmux first, then vim
Plugin 'benmills/vimux'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
"Plugin 'Shougo/unite.vim'
Plugin 'rking/ag.vim'
" Plugin 'taglist'
Plugin 'yegappan/mru'
" Plugin 'mileszs/ack.vim'
Plugin 'junegunn/goyo.vim'
"Plugin 'SirVer/ultisnips'
call vundle#end()            " required
filetype plugin indent on    " required


"""""""""""""""""""""""""""""""""""""""""""""""
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
let g:EasyMotion_leader_key="r"
" Disable 'r' when it is used as leader key
map r <Nop>
" hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade Comment
nmap <leader>n :NERDTree<cr>
let NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" undotree
" taglist
" cctree

" let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nmap <leader>c :CtrlP<cr>

let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pdf    " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:aghighlight=1
let g:agprg="ag --column --smart-case"

if executable('ag')
	" Use ag over grep
	set grepprg=ag 
	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor, for now, does not work very good! 
" nnoremap K :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>

map <leader>s :Ag!<space>
map <space><space> :Ag!<space>
nmap <leader>tt :TagbarToggle<cr>

let g:pymode_options_colorcolumn = 0
"let g:showmarks_enable=1
"let g:showmarks_include="abcdefzx1234"


" turn on goyo, distraction-free mode
noremap <leader>gy :Goyo<cr>
noremap <leader>nogy :Goyo!<cr>

" show undo history tree by Gundo plugin
nnoremap <leader>ut :GundoToggle<cr>


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
nnoremap <leader>d :cd %:p:h<CR>:pwd<CR>
nmap <leader>h :h<space>
nmap <leader>w :w<cr>	" fast saving
nmap <leader>x :q<cr>	" fast quit
nmap <leader>e :e<space>
nmap <leader>wq :wq<cr> " save and quit
nmap <leader>qf :q!<cr> " force quit


"nnoremap <silent> n nzz
"nnoremap <silent> N Nzz
"nnoremap <silent> * *zz
"nnoremap <silent> # #zz
"nnoremap <silent> g* g*zz


" count the total number of matches in the latest search
" :%s/./&/gn		count characters
" :%s/\i\+/&/gn		count words
nmap <leader>ct :%s///gn<cr>
" no need to input ':' manually, but lose the "go to next char" ability
map ; :
map ;; :norm<space>

" in cmd mode, enter %, !, ^, @ becomes easier
"cmap 55 %
"cmap 66 ^
"cmap 11 !
"cmap 22 @

" select all contents
map <leader>al ggVG
" easily select all contents using left-hand
map fa ggVG
" left-hand fast quit
map fq :q<cr>
" left-hand fast saving
nmap fw :w<cr>
" map fww :w!<cr>
" map fwq :w!<cr>:q<cr>
" left-hand list all matches, 'fs' means 'Fast Search list'
map fs :g//<cr>
" fast move to last and next edit positions
map ga g;
map gs g,

" super convenient and super quick :)
" first press 'fa', then press 'fd', you can quickly enter command mode to process all lines at once, 
" without leave left-hand off keyboard
vmap fd :norm<space>
" quickly launch a bash inside vim
map gc :ConqueTermVSplit<space>bash<cr> 

" since 't' is barely used, why not map it to the frequently used 'top'?
" map t gg
" map 't' to 'page up'
map t <PageUp>
" scroll half page up
noremap U <c-u>
" scroll half page down
noremap M <c-d>

" since 'q' is rarely used, so i match it to a frequent operation
" map 'q' to 'page down'
" sometimes q is used to quit a window. so better use another one.
" map q <PageDown>
" map g <PageDown>
" next buffer
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>

" Easier linewise reselection of what you just pasted. not useful right now
" nnoremap <leader>V V`]

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

"""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Move around
"""""""""""""""""""""""""""""""""""""""""""""""""

"Reselect visual block after in/outdenting
vnoremap < <gv
vnoremap > >gv

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
" Easier to type, and I never use the default behavior.
" noremap H ^
" oremap L $
" noremap L g_

" map 00 I  " i want to make 00 as I, but it does not work. why?
" disable highlight
map <silent> <leader><cr> :noh<cr> 
map <space> /
" i manually map <Caps> to <Ctrl> in MAC Preference setting
map <caps> <ctrl>
map <c-space> ?

" disable below 4 lines due to conflict with vim-tmux-navigator
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l

" map <left> <nop>
" map <right> <nop>
" map <up> <nop>
" map <down> <nop>

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

map te :tabnew<cr>
map tn :tabn<cr>
map tp :tabp<cr>
map to :tabonly<cr>
map tq :tabclose<cr>

map H :tabp<cr>
map L :tabn<cr>

" map <leader>te :tabnew<cr>
" map <leader>tn :tabn<cr>
" map <leader>tp :tabp<cr>
" map <leader>to :tabonly<cr>
" map <leader>tq :tabclose<cr>

imap ii <esc>
imap kj <esc>`^

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y
" " Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" map esc to tab for all modes
nnoremap <Tab> <Esc>
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>`^
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
" set listchars=tab:>~,nbsp:_,trail:.
" set list
set showmode
set laststatus=2 		" always show the status line
" Format the status line
set smarttab			" be smart when using tabs
set shiftwidth=4
set tabstop=4		
set expandtab
set wildmenu
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
"colorscheme solarized
colorscheme torte

"Resize splits when the window is resized
" au VimResized * exe "normal! \<c-w>="


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
" set cursorline			" highlight current line
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
" nmap <leader>b :w<cr>:call Compile()<cr>:call Run()<cr>
" nmap <leader>c :w<cr>:call Compile()<cr>
" nmap <leader>r :call Run()<cr>
" nmap <leader>d :call Debug()<cr>

" jump to next compile error
" map <leader>cn :cn<cr>
" jump to previous compile error
" map <leader>cp :cp<cr>
" jump to 1st compile error
" map <leader>cf :cr<cr>
" jump to the last compile error
" map <leader>cl :cla<cr>


