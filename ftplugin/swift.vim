setl fdm=indent

nnoremap <buffer> <LocalLeader>m :<C-U>call fzf#vim#buffer_lines("'func | 'class | 'struct | 'MARK: ", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>f :!swiftlint autocorrect --path %:p<CR>
