let g:slime_no_mappings = 1
" if has('nvim')
"     let g:slime_target = "neovim"
" elseif v:version >= 801
"     let g:slime_target = "vimterminal"
" else
let g:slime_target = "tmux"
" endif
let g:slime_paste_file = tempname()
" pandas not support cpaste..
let g:slime_python_ipython = 1
Plug 'jpalardy/vim-slime', {'on': ['<Plug>SlimeLineSend', '<Plug>SlimeRegionSend', 'SlimeSend1']}
