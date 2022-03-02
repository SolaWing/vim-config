if exists("b:did_ftplugin") | finish | endif

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
setl shiftwidth=2
