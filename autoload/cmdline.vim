function cmdline#ForwordDeleteWord()
    let cmdtext = getcmdline()
    let cmdtext = substitute(cmdtext, '\%'.getcmdpos().'c.\s*\w*', '',"")
    return cmdtext
endfunction

function cmdline#SearchChar(isForward, stopAfter, charCount) " like f in normal mode
    let cmdtext = getcmdline()
    let pos = getcmdpos() " 1 base pos

    " get input char
    let chars = ""
    let c = 0
    while c < a:charCount
        echo ":".cmdtext . " | input ".(a:isForward?"forward":"backward")." char: ".chars
        let char = getchar()
        if type(char) == type(0)
            let char = nr2char(char)
        endif

        if char ==# "\r" || char ==# "\n"
            break
        endif

        let chars .= char

        let c += 1
    endwhile

    if c == 0 " invalid input char
        return cmdtext
    endif
    " search and jump pos
    if a:isForward
        " if stopAfter, can match current, and move after current
        " else, search after current pos
        let pos = pos - a:stopAfter
        let topos = stridx(cmdtext, chars, pos) " 0 base pos
    else
        " if stopAfter, match previous char won't move, need to search furthor
        " else can match previous char
        let pos = pos-2- a:stopAfter * c
        let topos = strridx(cmdtext, chars, pos) " 0 base pos, will match at pos
    endif
    " echom cmdtext "|" char pos topos a:isForward
    if topos != -1
        call setcmdpos(topos+1+ a:stopAfter * c)
    endif
    return cmdtext
endfunction

