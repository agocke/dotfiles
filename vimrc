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

  set viewdir=$HOME/.vimviews/

  silent execute '!mkdir -p $HOME/.vimswap'
  silent execute '!mkdir -p $HOME/.vimviews'
endif

" For when you forget to sudo -- really write the file
cmap w!! w !sudo tee % > /dev/null

" Abbrev. of messages
set shortmess+=aO

" Insert a lambda: mostly for scheme and haskell
imap <C-Bslash> λ

" Allow vim installs using the pathogen format
call pathogen#infect('~/.vim/bundle')

" Show whitespace
set list listchars=tab:»·,trail:·

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
autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /

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
let g:OmniSharp_server_type = 'roslyn'
let g:syntastic_cs_checkers = ['code_checker']
let g:OmniSharp_selector_ui = 'ctrlp'

augroup omnisharp_commands
    autocmd!

    " Run async build on
    autocmd FileType cs nnoremap <F6> :OmniSharpBuildAsync<CR>

    " Update syntax check
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Add usings
    autocmd FileType cs nnoremap <C-p> :OmniSharpFixUsings<CR>

augroup END


"""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

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
