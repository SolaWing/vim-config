if exists("b:did_ftplugin") | finish | endif

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

nnoremap <buffer> <LocalLeader>e :<C-U>exe "lua " . getline('.')<CR>
nnoremap <buffer> <LocalLeader>s :<C-U>luafile %<CR>
xnoremap <buffer> <LocalLeader>s :<C-U>let tmp = tempname() <bar>silent exe "'<,'>w" tmp<bar>exe "luafile" tmp<CR>
