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
Plug 'tpope/vim-rhubarb' " GBrowse github
Plug 'junegunn/gv.vim', {'on': 'GV'}
silent! source ~/.vim/Private/gitlab.vim
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
      \ },
      \ "Package.swift": {
      \   "Sources/*.swift": {"type": "source", "alternate": "Tests/lib-tests/{}Tests.swift"},
      \   "Tests/lib-tests/*Tests.swift": {"type": "test", "alternate": "Sources/{}.swift", "template": ["import XCTest", "", "final class {basename}Tests: XCTestCase {open}{close}"]},
      \   "Package.swift": {"type": "package"}
      \ }
      \}

" 优化不必要的检查，加速打开性能（特别是fugtive的各种buffer）
" 各种插件容易触发fugitive的FileReadable
" https://github.com/tpope/vim-fugitive/issues/2310
let g:fugitive_file_api = v:false

"function! ExcludeBufferFromDiscovery(file, type)
"    if stridx(a:file, ":") != -1
"        return v:true
"    endif
"    return v:false
"endfunction
"let g:projectionist_ignore_fugitive = v:true
"}}}
if has('nvim-0.10.0')
    nmap gcu gcgc
else
    Plug 'tpope/vim-commentary'
end

Plug 'tpope/vim-dadbod', {'on': ['DB', 'DBUI']}
Plug 'kristijanhusak/vim-dadbod-ui', {'on': ['DBUI']}
let g:db_ui_auto_execute_table_helpers = 1
