
nnoremap <buffer> cf :Git commit --fixup=<C-R>=gv#sha()<CR>
nnoremap <buffer> cs :Git commit --squash=<C-R>=gv#sha()<CR>
nnoremap <buffer> rf :<C-U>Git -c sequence.editor=true rebase --interactive --autosquash <C-R>=gv#sha()<CR>^
nnoremap <buffer> ri :<C-U>Git rebase --interactive <C-R>=gv#sha()<CR>^
nnoremap <buffer> ru :<C-U>Git rebase --interactive @{upstream}
nnoremap <buffer> ~ <Cmd>call v:lua.require("config.ft.git")["gv#parent"](v:count1)<CR>
