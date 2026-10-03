let mapleader = ','
set termguicolors
set fileencoding=utf-8
set number
set ruler
set showcmd
filetype plugin indent on
syntax enable
set nobackup
set nowritebackup
set noswapfile
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set autoread
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set complete-=i
set smarttab
set history=1000
set nowrap
set hidden
set mouse=a
set ttimeout
set ttimeoutlen=100
set title

" a tab is two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab   " use spaces, not tabs

" use the system clipboard as the default register
set clipboard=unnamed,unnamedplus

set backspace=indent,eol,start    " backspace through everything in insert mode

set list                          " Show invisible characters
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:>⋅              " a tab should display as ">⋅", trailing whitespace as "⋅"
set listchars+=trail:⋅            " show trailing spaces as middle-dots

" autoflesh changed files
