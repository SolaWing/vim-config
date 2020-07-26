""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:
" ==================== Language"{{{
Plug 'hynek/vim-python-pep8-indent'
" Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'HerringtonDarkholme/yats.vim' " typescript
Plug 'udalov/kotlin-vim'
Plug 'cespare/vim-toml'

" keith/swift.vim "{{{
Plug 'keith/swift.vim', {'for': 'swift'}
" 现在支持还不够好. 以后真的需要再说吧. 暂时用xcode开发swift
" Plug '~/.vim/bundle/sourcekittendaemon.vim', {'for': 'swift'}
" Plug 'mitsuse/autocomplete-swift', {'for': 'swift'}
"}}}

" rhysd/vim-clang-format "{{{
Plug 'kana/vim-operator-user'
let g:clang_format#detect_style_file = 1 " use .clang-format
Plug 'rhysd/vim-clang-format', {'on': ['<Plug>(operator-clang-format)']}
" fix lazy load not not consider default range
command! -range=% -nargs=0 ClangFormat call plug#load('vim-clang-format') | call clang_format#replace(<line1>, <line2>)
"}}}

" octol/vim-cpp-enhanced-highlight"{{{
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
""}}}

" rust-lang/rust.vim"{{{
Plug 'rust-lang/rust.vim', {'for': 'rust'}
"}}}
" dag/vim-fish"{{{
" slow, better than None
Plug 'dag/vim-fish', {'for': 'fish'}
""}}}
" vim-ruby/vim-ruby{{{
" let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_load_gemfile = 1
Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
Plug 'tpope/vim-rake', {'for': 'ruby'}
Plug 'tpope/vim-bundler', {'for': 'ruby'}
"}}}
" wannesm/wmgraphviz.vim  {{{
let g:WMGraphviz_output = 'png'
Plug 'wannesm/wmgraphviz.vim', {'for': 'dot'}
"}}}
" plantuml{{{
Plug 'aklt/plantuml-syntax'
"}}}
source ~/.vim/bundle-config/lang/markdown.vim
source ~/.vim/bundle-config/lang/lisp.vim
"}}}
