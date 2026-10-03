" Toggle search highlighting.
nnoremap <silent><expr> <Leader>l (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

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


" Zoom / restore the current window.
map <Leader><Leader> :ZoomToggle<CR>

" Markdown to HTML; requires /usr/local/bin/Markdown.pl.
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>
