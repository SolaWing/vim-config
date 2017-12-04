" close range tab, 0 is current, 1 is first, '$' is last
function! misc#tabclose_range(start, end) range
    let start = s:tab_get_nr(a:start)
    let end = s:tab_get_nr(a:end)
    while start <= end
        exe 'confirm '.end.'tabclose'
        let end -= 1
    endwhile
endfunction

" get tab nr, safe in range. 0 is current, '$' is last
function! s:tab_get_nr(nr) range
    if a:nr ==# '$'
        return tabpagenr('$')
    endif
    if a:nr == 0
        return tabpagenr()
    endif
    let end = tabpagenr('$')
    if a:nr > end
        return end
    endif
    return a:nr
endfunction

" close tabs >= nr, if 0, close tabs after current one
function! misc#tabclose_right(nr) range
    let start = a:nr
    if start == 0
        let start = tabpagenr() + 1
    endif
    call misc#tabclose_range(start, '$')
endfunction

function! misc#SurroundSpaceBetweenPairs(start, end) range
    exe printf('%d,%ds/\(%s\)\ze\S/\1 /ge', a:firstline, a:lastline, a:start)
    exe printf('%d,%ds/\S\zs\(%s\)/ \1/ge', a:firstline, a:lastline, a:end)
endfunction

function! misc#ToggleCamelOrUnderline(str)
    let l:ret = substitute(a:str, "_\\(\\a\\)", "\\u\\1", "g")
    if ret ==# a:str
        let l:ret = substitute(a:str, "\\l\\zs\\u", "_\\l\\0", "g")
    endif
    return l:ret
endfunction

function! misc#URLEncode(str)
py3 << EOF
from urllib.parse import quote
_ = quote(vim.eval('a:str'))
del quote
EOF
    return py3eval("_")
endfunction

function! misc#URLDecode(str) range
py3 << EOF
from urllib.parse import unquote
_ = unquote(vim.eval('a:str'))
del unquote
EOF
    return py3eval("_")
endfunction
