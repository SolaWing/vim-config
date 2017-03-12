if exists("b:did_ftplugin") | finish | endif

setl softtabstop=2 shiftwidth=2 tabstop=4
setl foldmethod=indent

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
