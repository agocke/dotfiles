set runtimepath=~/.vim,~/.vim/after,$VIMRUNTIME
helptags ~/.vim/doc
""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""
silent function! OSX()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win16') || has('win32') || has('win64'))
endfunction

" Enable filetype
filetype plugin indent on

" Turn off vi compatibility 
set nocompatible

" Set a new personal leader key
let mapleader = ","
let g:mapleader = ","

" Fast save
nmap <leader>w :w<CR>
" Fast save and quit
nmap <leader>x :x<CR>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Set zsh as default shell
"if CurOs() == "mac" || CurOs() == "linux"
"    set shell=/bin/zsh
"endif

" autobackup
set nobackup
if WINDOWS()
  set directory=$TEMP
else
  set directory=$HOME/.vimswap/
endif

set viewdir=$HOME/.vimviews/

silent execute '!mkdir -p $HOME/.vimswap'
silent execute '!mkdir -p $HOME/.vimviews'

" For when you forget to sudo -- really write the file
cmap w!! w !sudo tee % > /dev/null

" Abbrev. of messages
set shortmess+=aO

" Insert a lambda: mostly for scheme and haskell
imap <C-Bslash> λ

" Allow vim installs using the pathogen format
call pathogen#infect('~/.vim/bundle')

" F5 calls make (builds the project)
map <F6> :make<CR>

""""""""""""""""""""""""""
" Vim UI
""""""""""""""""""""""""""
set mouse=a
set ruler " Show ruler
set showcmd " Show partial commands and line numbers in visual mode

set wildmenu
set wildmode=list:longest

set title

set backspace=eol,start,indent

set hidden

set ignorecase
set smartcase

set hlsearch
set incsearch
"Allow Enter to clear highlighting
nnoremap <CR> :noh<CR><CR>

" Use magic in regex
set magic

set number

" Highlight current line
set cursorline

" Scroll with the cursor while moving
set scrolloff=4

""""""""""""""""""""""""""""""""""
" Text, tabs, and indent
""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

" Set up text wrap
set wrap
set linebreak
set showbreak=>>>

set autoindent
set smartindent

set tags=./tags;

""""""""""""""""""""""""""""""""""
" Navigation, tabs, and buffers
""""""""""""""""""""""""""""""""""
" Set buffer nav shortcut
map <leader>1 :1b<CR>
map <leader>2 :2b<CR>
map <leader>3 :3b<CR>
map <leader>4 :4b<CR>
map <leader>5 :5b<CR>
map <leader>6 :6b<CR>
map <leader>7 :7b<CR>
map <leader>8 :8b<CR>
map <leader>9 :9b<CR>
map <leader>0 :10b<CR>

" Set buffer return shortcut
map <leader>, <C-^> 

" Remap window nav
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Better buffer switching
try
    set switchbuf=usetab
catch
endtry

" Automatically change current directory to directory of buffer
if exists('+autochdir')
    set autochdir
else
    autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

autocmd BufWritePost, BufLeave, WinLeave ?* mkview
autocmd BufReadPre ?* silent loadview

""""""""""""""""""""""
" Colors and Fonts
""""""""""""""""""""""
syntax enable

set guifont=Consolas:h11
"if CurOs() == "Darwin"
"  set guifont=Menlo:h12
"elseif CurOs() == "Windows"
"  set guifont=Consolas:h10
"elseif CurOs() == "Linux"
"  set guifont=Consolas\ 10
"endif

set bg=dark

" GUI options
if has("gui_running")
  set guioptions-=T
  " Set the initial gvim size
  set lines=50 columns=110
endif

colorscheme solarized

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac

"""""""""""""""""""""""""""""
" VIM Folding
"""""""""""""""""""""""""""""
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'1')<CR>
vnoremap <Space> zf

set foldmethod=marker

set foldnestmax=10

set foldlevel=0

set foldminlines=1

"""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""
let python_highlight_all = 1

"""""""""""""""""""""""""""""
" Filetypes and overrides
"""""""""""""""""""""""""""""
" Use better syntax highlighting for ASM
let g:asmsyntax="asmx86"

" Hsc apparently also means hamster... wtf is hamster??
au BufNewFile,BufRead *.hsc set filetype=haskell

"""""""""""""""""""""""""""""
" Fuzzy Finder plugin
"""""""""""""""""""""""""""""
noremap <leader><Space> :CtrlPBuffer<CR>
let g:ctrlp_map = '<leader>e'

"""""""""""""""""""""""""""""
" Taglist plugin
"""""""""""""""""""""""""""""
nnoremap <silent> <F8> :TlistToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline Config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
