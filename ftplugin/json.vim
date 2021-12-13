if exists("b:did_ftplugin")
  finish
endif

setl fdm=indent
setl sw=2
" setl formatprg=$HOME/bin/jsontool.py
setl formatprg=jq\ -S
setl formatexpr=
" nnoremap <buffer> gq :<C-U>%!$HOME/bin/jsontool.py<CR>
" xnoremap <buffer> gq :!$HOME/bin/jsontool.py<CR>
