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
