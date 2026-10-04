augroup AutoCheckTime
  autocmd!
  autocmd BufEnter,FocusGained * checktime
augroup END

" Refresh trailing-space warnings after edits, saves, and option changes.
augroup StatuslineWarnings
  autocmd!
  autocmd TextChanged,TextChangedI,TextChangedP,CursorHold,BufWritePost,BufReadPost * unlet! b:statusline_trailing_space_warning
  autocmd OptionSet modifiable unlet! b:statusline_trailing_space_warning
augroup END
