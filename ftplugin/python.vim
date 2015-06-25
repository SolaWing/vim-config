if exists("b:did_ftplugin") | finish | endif

nnoremap <buffer> <Space>me :<C-U>let tmp = system("python", getline(1,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
vnoremap <buffer> <Space>me :w !python<CR>
nnoremap <buffer> <Space>ms :PY exec("\n".join(vim.current.range))<CR>
vnoremap <buffer> <Space>ms :PY exec("\n".join(vim.current.range))<CR>
setl formatoptions-=t
