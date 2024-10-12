if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>lt :<C-U>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>

setl shiftwidth=2 softtabstop=-1 tabstop=4
if has("nvim")
    setl foldmethod=expr foldexpr=v:lua.vim.treesitter.foldexpr()
endif
