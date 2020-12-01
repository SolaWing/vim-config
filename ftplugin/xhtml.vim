if exists("b:did_ftplugin")
  finish
endif

nnoremap <silent> <buffer> <LocalLeader>p :<C-U>update<bar>silent !open %<CR>
