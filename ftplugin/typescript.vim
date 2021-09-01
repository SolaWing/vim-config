if exists("b:did_ftplugin") | finish | endif

setl foldmethod=indent
setl shiftwidth=2
setl softtabstop=2
setl tabstop=4

nnoremap <buffer> <LocalLeader>lt :<C-U>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>
