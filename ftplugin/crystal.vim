let b:surround_100 = "do \r\nend"
setl sw=2

nmap <buffer> <LocalLeader>t :update <bar> Dispatch crystal spec --error-trace --location '%:<C-R>=line('.')<CR>'<CR>
