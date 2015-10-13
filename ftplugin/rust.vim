if exists("b:did_ftplugin")
  finish
endif

let b:AutoPairs = {'(':')', '[':']', '{':'}', "<":">",'"':'"', '`':'`'}
setl makeprg=cargo
setl fdm=syntax
nnoremap <buffer> <Space>mb :update <bar> make build<CR>
nnoremap <buffer> <Space>mr :update <bar> make run<CR>
nnoremap <buffer> <Space>mt :update <bar> make test<CR>
nnoremap <buffer> <Space>mp :update <bar> make bench<CR>
nnoremap <buffer> <Space>mc :make clean<CR>
