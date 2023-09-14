if !has('nvim-0.5.0')
    finish
endif
" aniseed#env will trigger lua load
" enable .fnl file autoload
" let g:aniseed#env = v:true
" let g:aniseed#env = { "compile": v:false }
" init options =  { useMetadata = "true" } 

Plug 'Olical/aniseed' " nvim lisp integration
Plug 'Olical/conjure',               { 'for': ['hy', 'racket', 'scheme', 'fennel', 'lua'] }
let g:conjure#filetype#racket = "conjure.client.racket.mystdio"
let g:conjure#filetypes = ["clojure", "fennel", "hy", "racket", "lisp", "scheme", "lua"]
let g:conjure#mapping#doc_word = "K" " with localLeader
let g:conjure#eval#result_register = '"'
" let g:conjure#debug = 1

command! AniseedCompile lua require('aniseed.env').init({})
