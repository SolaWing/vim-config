if exists("b:did_ftplugin") | finish | endif

nmap <buffer> <LocalLeader>r :update <bar> !perl %<CR>
