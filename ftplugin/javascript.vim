if exists("b:did_ftplugin") | finish | endif

setl foldmethod=indent

setl shiftwidth=2
setl softtabstop=2
setl tabstop=4

nnoremap <buffer> <LocalLeader>e :<C-U>let tmp = system("osascript -l JavaScript", getline(2,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
xnoremap <buffer> <LocalLeader>e :w !osascript -l JavaScript<CR>

" nmap <buffer> <LocalLeader>f :update<bar>ALEFix<CR>
" nmap <buffer> <LocalLeader>gq :YcmCompleter Format<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
