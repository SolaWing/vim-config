function! edit#toggleFullChar(...) range
    if a:0 > 0 && a:1
        echo "not implement"
    else
        '<,'>sm/\([,.]\)\s\?/\={',': '，', '.': '。'}[submatch(1)]/g
    endif
endfunction

function! edit#markResolver()
    let l:cursor = getcurpos()
    let l:start = search('^<<<<<<<', 'bcW')
    if l:start == 0 | return | endif
    let l:middle = search('^=======', 'W')
    if l:middle == 0 | return | endif
    let l:end = search('^>>>>>>>', 'W')
    if l:end == 0 | return | endif

    " echo "was" . l:start . l:middle . l:end
    echo "keep which part(k/j/all/none)? "
    let l:answer = nr2char(getchar())
    if l:answer ==# 'k'
        silent exe printf("%d,%dd", l:middle, l:end)
        silent exe l:start . 'd'
        let l:ve = l:middle - 2 " 修改后保留的最下面一行
    elseif l:answer ==# 'j'
        silent exe l:end . 'd'
        silent exe printf("%d,%dd", l:start, l:middle)
        let l:ve = l:start + l:end - l:middle - 2
    elseif l:answer ==# 'a'
        silent exe l:end . 'd'
        silent exe l:middle . 'd'
        silent exe l:start . 'd'
        let l:ve = l:end - 3
    elseif l:answer ==# 'n'
        silent exe printf("%d,%dd", l:start, l:end)
        let l:ve = l:start - 1
    else
        call setpos('.', l:cursor)
        return
    endif

    " blink to visible changes
    if l:ve < l:start
        let l:time = 100
    else
        let l:time = 500
    end
    let l:hi_id = matchadd("IncSearch", printf('\%%%dl\|\%%>%dl\%%<%dl', l:start, l:start, l:ve+1))
    " let l:hi_id = matchaddpos("IncSearch", l:hi_pos)
    call timer_start(l:time, {-> matchdelete(l:hi_id) })
endfunction
