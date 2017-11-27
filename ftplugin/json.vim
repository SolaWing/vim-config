if exists("b:did_ftplugin")
  finish
endif

setl fdm=syntax
nnoremap <buffer> gq :<C-U>%!$HOME/bin/jsontool.py<CR>
xnoremap <buffer> gq :!$HOME/bin/jsontool.py<CR>
