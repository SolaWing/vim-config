" dirvish source directly before set filetype to dirvish
if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

nnoremap <buffer> <LocalLeader>d :!mkdir -p '<C-R>%'
nnoremap <buffer> <LocalLeader>f :e <C-R>%
nnoremap <buffer><silent> <LocalLeader>o :silent !open '<C-R><C-F>'<CR>
nnoremap <buffer><silent> <LocalLeader>r :silent !open '<C-R>%'<CR>
nnoremap <buffer><silent> <LocalLeader>t <Cmd>Terminal %<CR>
nnoremap <buffer> // <Cmd>FZF %<CR>
nnoremap <buffer> <LocalLeader>/ :Grepper -tool rg -dir file<CR>

nmap <buffer> <LocalLeader><BS> .rm -r
