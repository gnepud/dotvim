" Load pathogen bundles.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

colorscheme molokai 
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set number
set ruler
set nocompatible
syntax on
filetype plugin indent on
set nobackup
set noswapfile
"autocmd BufEnter * lcd %:p:h 	" Auto change the directory to the current file I'm working on
set incsearch
set autoread
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set history=1000
set nowrap
let mapleader = ","
set hidden
set tabstop=4     " a tab is four spaces
set shiftwidth=4

" Delete warn message for Lusty plugin with use vi
let g:LustyExplorerSuppressRubyWarning = 1
let g:LustyJugglerSuppressRubyWarning = 1

" Command-T configuration
let g:CommandTMaxHeight=20
