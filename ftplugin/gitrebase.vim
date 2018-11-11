if exists('b:did_ftplugin')
    finish
endif

nnoremap <buffer><silent> <CR> :silent Gpedit <C-R><C-W><CR>
