if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>e :<C-U>update <bar> !sh %<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
