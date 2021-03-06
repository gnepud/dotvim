call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'sjl/gundo.vim'
Plug 'majutsushi/tagbar'

" Lang Syntax highlight
Plug 'tpope/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'
Plug 'leafgarland/typescript-vim'

" Theme color
Plug 'tomasiser/vim-code-dark'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"Plug 'wokalski/autocomplete-flow'
" For func argument completion
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'

" Add plugins to &runtimepath
call plug#end()

" ===========================
" Basic settings
" ===========================
colorscheme codedark
set nocompatible
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif
set fileencoding=utf-8
set number
set ruler
set showcmd
let mapleader = ','
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
set nobackup
set noswapfile
"autocmd BufEnter * lcd %:p:h   " Auto change the directory to the current file I'm working on
set showmatch
set incsearch
set hlsearch
" redraws the screen and removes any search highlighting.
nnoremap <silent><expr> <Leader>l (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
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
if has('mouse')
  set mouse=a
endif
set ttimeout
set ttimeoutlen=100
set title

" Fix displaying balloon tip with invalid 'ri' options
"set noballooneval

" a tab is two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab   " use spaces, not tabs

" .rb is generally Ruby
au BufEnter *.rb set syntax=ruby ai ts=2 sw=2 sts=2 tw=0

" use the system clipboard as the default register
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

set backspace=indent,eol,start    " backspace through everything in insert mode

set list                          " Show invisible characters
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:>⋅              " a tab should display as ">⋅", trailing whitespace as "⋅"
set listchars+=trail:⋅            " show trailing spaces as middle-dots

" autoflesh changed files
autocmd BufEnter,FocusGained * checktime

" ===========================
" keymap settings
" ===========================
" Remove unwanted spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\t/  /ge<Bar>:let @/=_s<Bar>:nohl<CR>

" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand("%:p:h")."/"<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resizing vim window splits
nnoremap + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap - :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap = <c-w>=
nnoremap < :vertical resize -5<CR>
nnoremap > :vertical resize +5<CR>

" http://tilvim.com/2014/03/18/a-better-paste.html
"map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<CR>


" ===========================
" Utilities
" ===========================
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
map <Leader><Leader> :ZoomToggle<CR>

" Markdown to HTML
" For use it, should download this script(http://daringfireball.net/projects/downloads/Markdown_1.0.1.zip)
" and copy it in /usr/local/bin
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

set path+=.,src/**,client/**,api/**
set suffixesadd=.js,.jsx
"function! LoadMainNodeModule(fname)
    "let nodeModules = "./node_modules/"
    "let packageJsonPath = nodeModules . a:fname . "/package.json"

    "if filereadable(packageJsonPath)
        "return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    "else
        "return nodeModules . a:fname
    "endif
"endfunction
"set includeexpr=LoadMainNodeModule(v:fname)


" ===========================
" statusline setup
" ===========================
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
"set statusline+=%{ale#statusline#Status()}
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        "show status bar

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction


" ===========================
" Plugins settings
" ===========================

" NERDTree configuration
" hide Prees ? for help
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
map <Leader>n :NERDTreeToggle<CR>
" NERDTree automatically when vim starts up, and cursor start in the other window
"autocmd vimenter * NERDTree
"autocmd vimenter * wincmd p
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Gitgutter color
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

" disable balloon to display error messages
let g:syntastic_enable_balloons = 0

" Syntastic ignore html error
"let g:syntastic_html_tidy_ignore_errors=["<ion-", "discarding unexpected </ion-", " proprietary attribute \"ng-", " proprietary attribute \"on-"]

" enable JSX syntax highlighting and indenting in .js files
let g:jsx_ext_required = 0

" Ack config The Silver Searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
" don't jump to the first result automatically
cnoreabbrev Ack Ack!

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" FZF
nmap <Leader>f :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>a :Ag<CR>

" javascript
" Enables syntax highlighting for JSDocs
let g:javascript_plugin_jsdoc = 1
" Enables syntax highlighting for Flow
let g:javascript_plugin_flow = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
" neosnippet
"let g:neosnippet#enable_completed_snippet = 1
"let g:autocomplete_flow#insert_paren_after_function = 0

" Gundo
nnoremap <F5> :GundoToggle<CR>

" ALE
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
" Set this setting in vimrc if you want to fix files automatically on save.
let g:ale_fix_on_save = 1

" Vim-gitgutter
set updatetime=500
