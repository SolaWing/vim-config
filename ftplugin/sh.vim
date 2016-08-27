if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <Space>me :<C-U>update <bar> !sh %<CR>
