
" slimv-scheme.vim:
"               Scheme filetype plugin for Slimv
" Version:      0.9.13
" Last Change:  04 May 2014
" Maintainer:   Tamas Kovacs <kovisoft at gmail dot com>
" License:      This file is placed in the public domain.
"               No warranty, express or implied.
"               *** ***   Use At-Your-Own-Risk!   *** ***
"
" =====================================================================
"
"  Load Once:
setl commentstring=;\ %s
finish " Disable, prefer conjure

if exists("g:slimv_disable_scheme") || exists("b:did_load_racket_slimv")
    finish
endif

let b:did_load_racket_slimv = 1

" ---------- Begin part loaded once ----------
if !exists( 'g:slimv_racket_loaded' )

let g:slimv_racket_loaded = 1

" Try to autodetect Scheme executable
" Returns list [Scheme executable, Scheme implementation]
function! SlimvAutodetect( preferred )
    " Currently only MIT Scheme on Linux
    if executable( 'racket' )
        " MIT Scheme
        return ['racket', 'racket']
    endif

    return ['', '']
endfunction

" Try to find out the Scheme implementation
function! SlimvImplementation()
    if exists( 'g:slimv_impl' ) && g:slimv_impl != ''
        " Return Lisp implementation if defined
        return tolower( g:slimv_impl )
    endif

    return 'racket'
endfunction

" Try to autodetect SWANK and build the command to load the SWANK server
function! SlimvSwankLoader()
    if g:slimv_impl == 'racket'
        let swanks = split( globpath( &runtimepath, 'bin/swank-racket/server.rkt'), '\n' )
        if len( swanks ) == 0
            return ''
        endif
        return printf('"%s" "%s"', g:slimv_lisp, swanks[0])
    endif
    return ''
endfunction

" Filetype specific initialization for the REPL buffer
function! SlimvInitRepl()
    set filetype=racket
endfunction

" Lookup symbol in the Hyperspec
function! SlimvHyperspecLookup( word, exact, all )
    " No Hyperspec support for Scheme at the moment
    let symbol = []
    return symbol
endfunction

" Source Slimv general part
runtime ftplugin/**/slimv.vim

endif "!exists( 'g:slimv_racket_loaded' )
" ---------- End of part loaded once ----------

" runtime ftplugin/**/lisp.vim

" The balloonexpr of MIT-Scheme is broken. Disable it.
let g:slimv_balloon = 0

" The fuzzy completion of MIT-Scheme is broken. Disable it.
let g:slimv_simple_compl = 1

" Must be called for each lisp buffer
call SlimvInitBuffer()

" Don't load another plugin for this buffer
" let b:did_ftplugin = 1

