nnoremap <buffer> <LocalLeader>p <Cmd>KeepCursor %call markdown#preview()<CR>
xnoremap <buffer> <LocalLeader>p <Cmd>call markdown#preview()<CR>
xnoremap <buffer> <LocalLeader>o :<C-U>call system('open '.'<C-R>=GetVisualString()<CR>')<CR>
