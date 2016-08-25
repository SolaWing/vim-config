if exists("b:did_ftplugin") | finish | endif

nnoremap <buffer> <Space>me :<C-U>let tmp = system("osascript -l JavaScript", getline(2,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
vnoremap <buffer> <Space>me :w !osascript -l JavaScript<CR>
