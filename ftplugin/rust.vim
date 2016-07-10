if exists("b:did_ftplugin")
  finish
endif

let b:AutoPairs = {'(':')', '[':']', '{':'}', "<":">", '"':'"', '`':'`'}
"setl makeprg=cargo
" compiler cargo
setl fdm=syntax
nnoremap <buffer> <Space>mb :update <bar> make build<CR>
nnoremap <buffer> <Space>mr :update <bar> make run<CR>
nnoremap <buffer> <Space>mt :update <bar> make test<CR>
nnoremap <buffer> <Space>mp :update <bar> make bench<CR>
nnoremap <buffer> <Space>mc :make clean<CR>

if exists("g:racer_no_default_keymappings") && g:racer_no_default_keymappings == 1
    nmap <buffer> <M-g> <Plug>RacerGoToDefinitionDrect
    nmap <buffer> <Space>t<M-g> <C-W>s<C-W>T<Plug>RacerGoToDefinitionDrect
    nmap <buffer> <C-W><M-g> <Plug>RacerGoToDefinitionSplit
    " nmap <buffer> gv <Plug>RacerGoToDefinitionVSplit
    nmap <buffer> K  <Plug>RacerShowDocumentation
endif
