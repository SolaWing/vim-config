""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:
" Config File {{{
    Plug 'cespare/vim-toml'
    " wannesm/wmgraphviz.vim  {{{
        let g:WMGraphviz_output = 'png'
        Plug 'wannesm/wmgraphviz.vim', {'for': 'dot'}
    "}}}
    Plug 'aklt/plantuml-syntax'
    source ~/.vim/bundle-config/lang/markdown.vim
" }}}
" Script {{{
    Plug 'dag/vim-fish', {'for': 'fish'} " slow, better than None
    " vim-ruby/vim-ruby{{{
        " let g:rubycomplete_buffer_loading = 1
        " let g:rubycomplete_classes_in_global = 1
        " let g:rubycomplete_load_gemfile = 1
        Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
        Plug 'tpope/vim-rake', {'for': 'ruby'}
        Plug 'tpope/vim-bundler', {'for': 'ruby'}
        Plug 'tpope/vim-rails', {'for': 'ruby'}
    "}}}
    Plug 'hynek/vim-python-pep8-indent'

    " Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
    Plug 'HerringtonDarkholme/yats.vim' " typescript
    Plug 'mattn/emmet-vim', {'for': ['eruby', 'html']}

    " 暂时不用lisp
    " source ~/.vim/bundle-config/lang/lisp.vim
" }}}
" Static Language {{{
    Plug 'udalov/kotlin-vim'
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
    Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
    Plug 'rust-lang/rust.vim', {'for': 'rust'}
" }}}
