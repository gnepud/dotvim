" Set the leader before lazy.nvim initializes plugin mappings.
let mapleader = ','
if has('termguicolors')
  set termguicolors
endif
lua require('dotvim.lazy')

" ===========================
" Basic settings
" ===========================
set nocompatible
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif
set fileencoding=utf-8
set number
set ruler
set showcmd
if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
set nobackup
set nowritebackup
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
augroup AutoCheckTime
  autocmd!
  autocmd BufEnter,FocusGained * checktime
augroup END

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

"set path+=.,src/**,client/**,api/**
"set suffixesadd=.js,.jsx,.ts,.tsx
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

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{fugitive#statusline()}
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
augroup StatuslineWarnings
  autocmd!
  autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning
  autocmd CursorHold,BufWritePost * unlet! b:statusline_tab_warning
  autocmd CursorHold,BufWritePost * unlet! b:statusline_long_line_warning
augroup END

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
