if exists("b:did_ftplugin")
  finish
endif

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

nnoremap <buffer> <LocalLeader>e :<C-U>update <bar> !fish %<CR>


