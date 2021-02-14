if exists("b:did_ftplugin")
  finish
endif

" c-w不做映射
nnoremap <buffer> <C-W><CR> <C-W><CR>
nnoremap <buffer> <Space>t<CR> <C-W><CR><C-W>T

nnoremap <buffer> <C-M-W> <C-W><CR>
nnoremap <buffer> <C-M-T> <C-W><CR><C-W>T
