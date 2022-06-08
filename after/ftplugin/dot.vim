setl commentstring=//\ %s
noremap <buffer> <LocalLeader>ll :<C-U>update <bar> GraphvizCompile<CR>
nnoremap <buffer> <F1> :silent! !open -a Firefox https://graphviz.org/doc/info/shapes.html<CR>
nnoremap <buffer> <LocalLeader>c :<C-U>update <bar> GraphvizCompile<CR>
inoremap <buffer> <M-;> <END>;<CR>
