nnoremap <buffer> <LocalLeader>p :<C-U>KeepCursor %call markdown#preview()<CR>
xnoremap <buffer> <LocalLeader>p :call markdown#preview()<CR>
xnoremap <buffer> <LocalLeader>o :<C-U>call system('open '.'<C-R>=GetVisualString()<CR>')<CR>
