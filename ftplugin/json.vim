if exists("b:did_ftplugin")
  finish
endif

setl fdm=syntax
nnoremap <buffer> <Space>mf :<C-U>%!$HOME/bin/jsontool.py<CR>
vnoremap <buffer> <Space>mf :!$HOME/bin/jsontool.py<CR>
