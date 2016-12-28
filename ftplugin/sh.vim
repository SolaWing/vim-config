if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>e :<C-U>update <bar> !sh %<CR>
