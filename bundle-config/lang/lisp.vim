" 和racket兼容不太好用，各种错误和路径问题。出错时还容易卡. 也没命令行交互模式的功能全
" 现在slimv只有scheme filetype才启动...
" interactive environment for lisp language
Plug 'Olical/conjure',               { 'for': ['hy', 'racket', 'scheme'] }
" Plug 'kovisoft/slimv',               {'for': ['racket', 'scheme']}
" 这个服务器目前只能先有了前缀才能过滤，不然内容太多了。
let g:slimv_swank_cmd = '!tmux new -d -n REPL-Racket "racket ~/.vim/bin/swank-racket/server.rkt"'
let g:slimv_unmap_cr = 1
" prefer vim edit functions
let g:paredit_mode = 0
let g:paredit_disable_scheme = 1

" waiting try
            " \ 'do': 'cargo build --release',
Plug 'eraserhd/parinfer-rust', {
            \ 'for': ['racket', 'scheme', 'hy']
            \ }

" Plug 'MicahElliott/vrod',                          {'for': ['racket', 'scheme']}
Plug 'wlangstroth/vim-racket'
" 我看着不明显，而且需要显示启用, 不支持单独启用
" Plug 'kien/rainbow_parentheses.vim',               {'for': ['racket', 'scheme']}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': ['racket', 'scheme', 'hy']}
Plug 'guns/vim-sexp',                              {'for': ['racket', 'scheme', 'hy']}
let g:sexp_filetypes = 'clojure,scheme,lisp,racket,hy'
let g:sexp_enable_insert_mode_mappings = 0

Plug 'hylang/vim-hy'
