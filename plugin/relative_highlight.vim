" relative_highlight.vim

" Simple visual absolute line numbering with highlighted multiples of 5 and 10 only in the number column.

" This was made with chatgpt, a tool I wanted for a long while
" But didn't know the libraries well enough to venture alone.
" Let me know how much it sucks! -ryan

if exists('g:loaded_relative_highlight')
  finish
endif
let g:loaded_relative_highlight = 1

" Enable absolute line numbering
set number
set norelativenumber

function! s:UpdateColors()
  if &background ==# 'dark'
    let s:default_colors = {
          \ 'current_line': {'cterm': 'Yellow', 'gui': '#ffcc00'},
          \ 'five_line': {'cterm': 'Blue', 'gui': '#5fafff'},
          \ 'ten_line': {'cterm': 'Yellow', 'gui': '#ffd700'}
          \ }
  else
    let s:default_colors = {
          \ 'current_line': {'cterm': 'DarkYellow', 'gui': '#cc8800'},
          \ 'five_line': {'cterm': 'DarkBlue', 'gui': '#00008b'},
          \ 'ten_line': {'cterm': 'DarkRed', 'gui': '#8b0000'}
          \ }
  endif

  if !exists('g:relative_highlight_colors')
    let g:relative_highlight_colors = s:default_colors
  endif

  execute 'highlight CurrentLineNumber ctermfg=' . g:relative_highlight_colors.current_line.cterm . ' guifg=' . g:relative_highlight_colors.current_line.gui
  execute 'highlight FiveLineNumber ctermfg=' . g:relative_highlight_colors.five_line.cterm . ' guifg=' . g:relative_highlight_colors.five_line.gui
  execute 'highlight TenLineNumber ctermfg=' . g:relative_highlight_colors.ten_line.cterm . ' guifg=' . g:relative_highlight_colors.ten_line.gui
endfunction

call s:UpdateColors()

function! HighlightRelativeLines()
  " Clear previous signs
  silent! call sign_unplace('relative_highlight')

  let lnum = line('.')
  let win_start = line('w0')
  let win_end = line('w$')

  for i in range(win_start, win_end)
    let diff = abs(lnum - i)
    if diff == 0
      call sign_place(0, 'relative_highlight', 'CurrentLineNumberSign', bufnr('%'), {'lnum': i})
    elseif diff % 10 == 0
      call sign_place(0, 'relative_highlight', 'TenLineNumberSign', bufnr('%'), {'lnum': i})
    elseif diff % 5 == 0
      call sign_place(0, 'relative_highlight', 'FiveLineNumberSign', bufnr('%'), {'lnum': i})
    endif
  endfor
endfunction

" Define signs for number highlighting without extra text
execute 'sign define CurrentLineNumberSign text= texthl=NONE linehl=NONE numhl=CurrentLineNumber'
execute 'sign define FiveLineNumberSign text= texthl=NONE linehl=NONE numhl=FiveLineNumber'
execute 'sign define TenLineNumberSign text= texthl=NONE linehl=NONE numhl=TenLineNumber'

augroup RelativeLineHighlights
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinScrolled * call HighlightRelativeLines()
  autocmd OptionSet background call <SID>UpdateColors()
augroup END
