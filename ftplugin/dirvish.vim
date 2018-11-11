if exists("b:did_ftplugin")
  finish
endif

nmap <buffer> <LocalLeader>d :!mkdir <C-R>%
nmap <buffer> <LocalLeader>f :e <C-R>%
nnoremap <buffer><silent> <LocalLeader>o :silent exe "!open <C-R><C-F>"<CR>
nnoremap <buffer><silent> <LocalLeader>r :silent exe "!open <C-R>%"<CR>
