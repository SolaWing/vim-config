function! superman#SuperMan(...)
  if exists(":Man") != 2 " No :Man command defined
    " Needed to get access to Man
    source $VIMRUNTIME/ftplugin/man.vim
  endif

  " Build and pass off arguments to Man command
  execute 'Man' join(a:000, ' ')
  " echo 'Man' join(a:000, ' ')

  " Quit with error code if there is only one line in the buffer
  " (i.e., manpage not found)
  if line('$') == 1 | cquit | endif

  " Why :Man opens up in a split I shall never know
  silent only

  " " Set options appropriate for viewing manpages
  " setlocal readonly
  " setlocal nomodifiable

  " setlocal noexpandtab
  " setlocal tabstop=8
  " setlocal softtabstop=8
  " setlocal shiftwidth=8
  " setlocal nolist
  " if exists('+colorcolumn')
  "   setlocal colorcolumn=0
  " endif

  " " To make us behave more like less
  nnoremap <silent> <buffer> <nowait> q <Cmd>q<CR>
endfunction
