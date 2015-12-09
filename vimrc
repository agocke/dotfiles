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

let g:syntastic_cs_checkers = ['code_checker']

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
set shiftwidth=4
set tabstop=4
set softtabstop=4
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

if WINDOWS()
    set guifont=Consolas:h10
elseif OSX()
    set guifont=Menlo:h12
elseif LINUX()
    set guifont=Inconsolata\ 12
endif

set bg=dark

" GUI options
if has("gui_running") && WINDOWS()
  set guioptions-=T
  " Set the initial gvim size
  set lines=50 columns=110
endif

if !has('gui_running')
    set term=xterm
    set t_Co=256
    let g:solarized_termcolors=256
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
" C#
"""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 0
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_enable_auto_close_preview = 0
" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Enable heavy omni completion, which require computational power and may stall the vim. 
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.cs = '.*'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'

" inoremap <silent><CR> neocomplcache#cancel_popup() . "\<CR>"
" 
" " <TAB>: completion.
" inoremap <expr> <TAB> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplcache#smart_close_popup()
" endfunction

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

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
