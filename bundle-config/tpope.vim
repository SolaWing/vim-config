""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:

" tpope/vim-surround "{{{
let g:surround_no_insert_mappings = 1
let g:surround_indent = 0
Plug 'tpope/vim-surround'
xmap s <Plug>VSurround
xmap gs <Plug>VgSurround
"}}}

" tpope/vim-unimpaired"{{{
Plug 'tpope/vim-unimpaired', {'on': []} " custom
call timer_start(1000, {-> plug#load('vim-unimpaired') })
nmap co yo
nnoremap yoD :<C-R>=&diff ? 'windo diffoff' : 'windo diffthis'<CR><CR>
nnoremap [oD <Cmd>windo diffthis<CR>
nnoremap ]oD <Cmd>windo diffoff<CR>
nnoremap yoe :set ei=<C-R>=(&ei ==# '')? "all" : ""<CR><CR>
nnoremap [oe <Cmd>set ei=all<CR>
nnoremap ]oe <Cmd>set ei=<CR>
"}}}

" tpope/vim-repeat"{{{
Plug 'tpope/vim-repeat'
"}}}

" tpope/fugitive {{{
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim', {'on': 'GV'}
" re setf git to enable fugitive map, fugitive#detect need a path to detect
autocmd mine VimEnter * if expand('<amatch>')=='' && &filetype=='git' | setf git | endif
" 反应太慢了, 主要也就是把status window和diff合并了。
" Plug 'jreybert/vimagit'
" }}}
" tpope/vim-dispatch {{{
Plug 'tpope/vim-dispatch'
let g:dispatch_no_maps = 1
" }}}
" tpope/vim-projectionist{{{
Plug 'tpope/vim-projectionist'
let g:projectionist_heuristics = {
      \ "*.podspec": {
      \   "*.swift": {"type": "source"},
      \   "*.podspec": {"type": "podspec"}
      \ }
      \}
"}}}
Plug 'tpope/vim-commentary'

" Plug 'tpope/vim-dadbod'
