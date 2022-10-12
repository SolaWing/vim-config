if exists("b:did_ftplugin")
  finish
endif

setl keywordprg=:Man
setl iskeyword+=45

nnoremap <buffer> Z! :<C-U>update <bar> !sh "%"<CR>
" dirvish will map to Z!, which will close after exe
nmap <buffer> <LocalLeader>r Z!

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
