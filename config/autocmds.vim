augroup AutoCheckTime
  autocmd!
  autocmd BufEnter,FocusGained * checktime
augroup END

" Refresh statusline warnings when idle and after saving.
augroup StatuslineWarnings
  autocmd!
  autocmd CursorHold,BufWritePost * unlet! b:statusline_trailing_space_warning
  autocmd CursorHold,BufWritePost * unlet! b:statusline_tab_warning
  autocmd CursorHold,BufWritePost * unlet! b:statusline_long_line_warning
augroup END
