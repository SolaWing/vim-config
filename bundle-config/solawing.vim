""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:
" my plugin" {{{
" Plug '~/.vim/bundle/vim-grepeditor'
Plug 'SolaWing/vim-objc-syntax', {'for': ['objc', 'objcpp']},
Plug 'SolaWing/WaitYank.vim'
" <C-r><CR> has problem, may not recognized
inoremap <C-r>$ <C-R>=quickUltiSnip#Insert()<CR>
nnoremap <M-p> <Cmd>call quickUltiSnip#Paste()<CR>
vmap <M-y> <Plug>quickUltiSnipYankVisual
nmap <M-Y> <Plug>quickUltiSnipYankLineWise
nmap <M-y> <Plug>quickUltiSnipYankOperator
inoremap <expr> <M-y>  WaitYank#Paste()
inoremap <expr> <C-R>? WaitYank#Paste()
" }}}
