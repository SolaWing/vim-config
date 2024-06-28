if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <F1> :silent! !open -a Firefox https://graphviz.org/doc/info/shapes.html<CR>
inoremap <buffer> <M-.> ->
