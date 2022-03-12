" dirvish source directly before set filetype to dirvish
if exists("b:did_custom_ftplugin")
  finish
endif
let b:did_custom_ftplugin = 1

nmap <buffer> <LocalLeader>d :!mkdir -p '<C-R>%'
nmap <buffer> <LocalLeader>f :e <C-R>%
nnoremap <buffer><silent> <LocalLeader>o :silent exe "!open '<C-R><C-F>'"<CR>
nnoremap <buffer><silent> <LocalLeader>r :silent exe "!open '<C-R>%'"<CR>

nmap <buffer> <LocalLeader><BS> :!rm -r '<C-R>%'
