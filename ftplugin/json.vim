if exists("b:did_ftplugin")
  finish
endif

setl fdm=syntax
setl formatprg=$HOME/bin/jsontool.py
" nnoremap <buffer> gq :<C-U>%!$HOME/bin/jsontool.py<CR>
" xnoremap <buffer> gq :!$HOME/bin/jsontool.py<CR>
