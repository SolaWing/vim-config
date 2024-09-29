if exists('b:did_ftplugin')
    finish
endif

nnoremap <buffer><silent> <CR> ^w:silent Gpedit <C-R><C-W><CR>
nnoremap <buffer><silent> <Space>t<CR> ^w:silent Gtabedit <C-R><C-W><CR>
