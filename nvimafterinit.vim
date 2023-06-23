command! Fish sp | terminal /usr/local/bin/fish -l
command! -bang Bwipeout lua require('config.function').Bwipeout('<bang>')
command! -bang PutRegisters put<bang> =luaeval('require\"util.vim-info\"[\"registers->vimscript\"]()')
