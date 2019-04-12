if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>c :update <bar> Start! plantuml -o /tmp/uml "%"<CR>
