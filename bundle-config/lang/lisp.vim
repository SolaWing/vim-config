" 和racket兼容不太好用，各种错误和路径问题。出错时还容易卡. 也没命令行交互模式的功能全
" 现在slimv只有scheme filetype才启动...
" interactive environment for lisp language
if has('nvim-0.5.0')
    Plug 'Olical/aniseed' " nvim lisp integration
    Plug 'bakpakin/fennel.vim'
    " aniseed#env will trigger lua load
    " enable .fnl file autoload
    " let g:aniseed#env = v:true
    " let g:aniseed#env = { "compile": v:false }
    " init options =  { useMetadata = "true" } 
    command! AniseedCompile lua require('aniseed.env').init({})
    Plug 'Olical/conjure',               { 'for': ['hy', 'racket', 'scheme', 'fennel'] }
    let g:conjure#filetype#racket = "conjure.client.racket.mystdio"
    let g:conjure#filetypes = ["clojure", "fennel", "hy", "racket", "lisp", "scheme", "lua"]
    let g:conjure#mapping#doc_word = "K" " with localLeader
    " let g:conjure#debug = 1

    Plug 'nvim-lua/plenary.nvim'
end

" Plug 'kovisoft/slimv',               {'for': ['racket', 'scheme']}
" " 这个服务器目前只能先有了前缀才能过滤，不然内容太多了。
" let g:slimv_swank_cmd = '!tmux new -d -n REPL-Racket "racket ~/.vim/bin/swank-racket/server.rkt"'
" let g:slimv_unmap_cr = 1
" " prefer vim edit functions
" let g:paredit_mode = 0
" let g:paredit_disable_scheme = 1

" waiting try
            " \ 'do': 'cargo build --release',

Plug 'eraserhd/parinfer-rust', {
            \ 'for': ['racket', 'scheme', 'hy', 'fennel'],
            \ 'do': 'cargo build --release'
            \ }
" let g:parinfer_enabled = 0 " 尝试结构化编辑

" Plug 'MicahElliott/vrod',                          {'for': ['racket', 'scheme']}
Plug 'wlangstroth/vim-racket'
" 我看着不明显，而且需要显示启用, 不支持单独启用
" Plug 'kien/rainbow_parentheses.vim',               {'for': ['racket', 'scheme']}
" 动态加载FileType触发有延迟，首次打开不生效..
Plug 'guns/vim-sexp',                              {'for': ['racket', 'scheme', 'hy', 'fennel', 'lisp']}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': ['racket', 'scheme', 'hy', 'fennel', 'lisp']}
let g:sexp_filetypes = 'clojure,scheme,lisp,racket,hy,fennel'
let g:sexp_enable_insert_mode_mappings = 0
" not need element emit and capture, since paren can be adjust by parinfer-rust
let g:sexp_mappings = {
            \ 'sexp_emit_head_element':         '',
            \ 'sexp_emit_tail_element':         '',
            \ 'sexp_capture_prev_element':      '',
            \ 'sexp_capture_next_element':      '',
            \ 'sexp_indent':                    '',
            \ 'sexp_indent_top':                '',
            \ }

" Plug 'hylang/vim-hy'
