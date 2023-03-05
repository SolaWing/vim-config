if exists("b:did_ftplugin") | finish | endif

if has('nvim')
    setl keywordprg=:help
    setl tags+=$VIMRUNTIME/doc/tags
endif

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

nnoremap <buffer> <LocalLeader>e :<C-U>exe "lua " . getline('.')<CR>
nnoremap <buffer> <LocalLeader>s :<C-U>luafile %<CR>
xnoremap <buffer> <LocalLeader>s :<C-U>let tmp = tempname() <bar>silent exe "'<,'>w" tmp<bar>exe "luafile" tmp<CR>

nnoremap <buffer> gf <Cmd>call v:lua.require("config.ft.fennel")["goto-module"](expand("<cfile>"), v:true)<CR>
xnoremap <buffer> gf "vy<Cmd>call v:lua.require("config.ft.fennel")["goto-module"](@v, v:true)<CR>
nnoremap <buffer> gF <Cmd>call v:lua.require("config.ft.fennel")["goto-module"](expand("<cfile>"), v:false)<CR>
xnoremap <buffer> gF "vy<Cmd>call v:lua.require("config.ft.fennel")["goto-module"](@v, v:false)<CR>
