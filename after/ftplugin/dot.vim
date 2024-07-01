setl commentstring=//\ %s
nnoremap <buffer> <F1> :silent! !open -a Firefox https://graphviz.org/doc/info/shapes.html<CR>
nnoremap <buffer> <LocalLeader>c :<C-U>update <bar> GraphvizCompile<CR>
nnoremap <buffer> <LocalLeader>v :<C-U>update <bar> GraphvizCompile <bar> Graphviz<CR>
inoremap <buffer> <M-;> <END>;<CR>
