if exists("b:did_ftplugin") | finish | endif

imap <buffer> <C-l> λ
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
nmap <buffer> <LocalLeader>r <Cmd>!racket -- %<cr>

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}
setl shiftwidth=2
