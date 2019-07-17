if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <silent> <LocalLeader>p :<C-U>update<bar>silent !open %<CR>
