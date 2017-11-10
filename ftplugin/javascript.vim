if exists("b:did_ftplugin") | finish | endif

setl foldmethod=indent

nnoremap <buffer> <LocalLeader>e :<C-U>let tmp = system("osascript -l JavaScript", getline(2,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
vnoremap <buffer> <LocalLeader>e :w !osascript -l JavaScript<CR>

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
