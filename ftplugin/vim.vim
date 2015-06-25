if exists("b:did_ftplugin")
  finish
endif

set keywordprg=:help
" execute current line
nnoremap <buffer> <Space>me :<C-U>exe getline(".")<CR>
vnoremap <buffer> <Space>me :<C-U>for tmp in getline("'<","'>")<bar>exe tmp<bar>endfor<CR>
vnoremap <buffer> <Space>ml :<C-U>exe join(map(getline("'<","'>"), 'substitute(v:val, "^\\s*\\\\","", "")'))<CR>
nnoremap <buffer> <Space>ms :<C-U>update <bar>source %<CR>
vnoremap <buffer> <Space>ms :<C-U>let tmp = tempname() <bar>exe "'<,'>w" tmp<bar>exe "source" tmp<CR>
