if exists("b:did_ftplugin")
  finish
endif

" let b:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '`':'`'}
" template <|>, distinguish with only <
inoremap <buffer> <M-<> <><left>

"setl makeprg=cargo
compiler cargo
setl fdm=syntax
" diag will use it, avoid frequent column change
setl signcolumn=yes

nnoremap <buffer> <LocalLeader>b :update <bar> Make! check
nnoremap <buffer> <LocalLeader>r :update <bar> make run<CR>
nnoremap <buffer> <LocalLeader>t :update <bar> make test<CR>
nnoremap <buffer> <LocalLeader>p :update <bar> make bench<CR>

inoremap <buffer> <M-;> <End>;<CR>

if exists("g:racer_no_default_keymappings") && g:racer_no_default_keymappings == 1
    nmap <buffer> <LocalLeader>gg <Plug>(rust-def)
    " nmap <buffer> gv <Plug>RacerGoToDefinitionVSplit
    nmap <buffer> K  <Plug>(rust-doc)
endif
