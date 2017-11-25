""" vim: set foldmethod=marker:
" global helper function. other keybinding function should put in autoload

" functions {{{
function! GetVisualString()
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    normal! gvy
    let ret = @@
    call setreg('"',old_reg, old_regtype)
    return ret
endfunction

function! KeepCursor(cmd)
    let l:cursor = getcurpos()
    exe "keepjumps" a:cmd
    call setpos('.', l:cursor)
endfunction

let s:CachedProperty = {}
function! CacheWrap(func, ...) abort
    let n = string(a:func)
    if has_key(s:CachedProperty, n)
        return s:CachedProperty[n]
    endif

    let v = call(a:func, a:000)
    let s:CachedProperty[n] = v
    return v
endfunction

function! CacheClear(func) range
    silent! unlet s:CachedProperty[string(a:func)]
endfunction
" }}}
