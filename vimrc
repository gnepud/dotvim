" Load pathogen bundles.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

colorscheme molokai 
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set number
set ruler
let mapleader = ","
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
set hidden

" a tab is four spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4

" .rb is generally Ruby
au BufEnter *.rb set syntax=ruby ai ts=2 sw=2 sts=2 tw=0

" Status bar
set laststatus=2

" Delete warn message for Lusty plugin with use vi
let g:LustyExplorerSuppressRubyWarning = 1
let g:LustyJugglerSuppressRubyWarning = 1

" Command-T configuration
let g:CommandTMaxHeight=20

" NERDTree configuration
"let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" AutoClose
nmap <Leader>x <Plug>ToggleAutoCloseMappings
