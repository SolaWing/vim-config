if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>c :update <bar> Start! -wait=never plantuml -tsvg -quiet -nbthread auto -o /tmp/uml "%"
nnoremap <buffer> <F1> :silent! !open -a Firefox http://plantuml.com/zh/commons<CR>
