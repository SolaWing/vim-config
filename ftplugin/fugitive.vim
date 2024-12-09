nmap <buffer> q gq
xmap <buffer> co .Git checkout<space>

nmap <buffer> czl <Cmd>Git -p stash list '--pretty=format:%h %as %<(10)%gd %<(76,trunc)%s'<CR>
nmap <buffer> czL <Cmd>Git -p stash list -p '--pretty=format:%h %as %<(10)%gd %<(76,trunc)%s'<CR>
