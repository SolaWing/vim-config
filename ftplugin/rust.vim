if exists("b:did_ftplugin")
  finish
endif

let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '`':'`'}
inoremap <buffer> <M-<> <><left>
"setl makeprg=cargo
" compiler cargo
setl fdm=syntax
nnoremap <buffer> <LocalLeader>b :update <bar> make build<CR>
nnoremap <buffer> <LocalLeader>r :update <bar> make run<CR>
nnoremap <buffer> <LocalLeader>t :update <bar> make test<CR>
nnoremap <buffer> <LocalLeader>p :update <bar> make bench<CR>
nnoremap <buffer> <LocalLeader>c :make clean<CR>

if exists("g:racer_no_default_keymappings") && g:racer_no_default_keymappings == 1
    nmap <buffer> <LocalLeader>gg <Plug>(rust-def)
    " nmap <buffer> gv <Plug>RacerGoToDefinitionVSplit
    nmap <buffer> K  <Plug>(rust-doc)
endif
