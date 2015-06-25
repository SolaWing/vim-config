let s:cpo_save = &cpo
set cpo&vim

function! tagcomplete#Complete(findstart, base)
    if a:findstart
        let line = getline('.')
        let start = col('.') - 1
        let lastword = 0
        while start > 0
            if line[start - 1] =~ '\w'
                let start -= 1
            else
                let lastword = start
                break
            endif
        endwhile
        return lastword
    endif

    let base = '^'.a:base
    let @z = base
    let matchTags = taglist(base)
    if len(matchTags) > 0
        call map(matchTags, 'v:val.name')
    endif
    return matchTags
    
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: set fdm=marker fmr={,} sts=4 ts=8 sw=4 et:
