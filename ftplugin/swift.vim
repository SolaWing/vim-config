if exists("b:did_ftplugin")
  finish
endif
setl fdm=indent

nnoremap <buffer> <LocalLeader>m :<C-U>call fzf#vim#buffer_lines("'func | 'class | 'struct | 'MARK: ", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>f :!swiftlint autocorrect --path %:p<CR>

" use / to surround /* block comment
let b:surround_47 = "/* \r */"
