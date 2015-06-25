finish " disable
if exists("loaded_autopair")
    finish
endif
let loaded_autopair = 1

if !exists('g:autopair')
    let g:autopair = ['""', "''", '()', '[]', '{}']
endif

let s:expectchar = ''
let s:lastTime = reltime()

function! s:needPair() 
    let l:newTime = reltime()
    let l:diffTime = (l:newTime[0]-s:lastTime[0]) * 1000000 + l:newTime[1] - s:lastTime[1]
    let s:lastTime = l:newTime
    if l:diffTime < 5000 | return | endif
    ""let @Z = v:char
    if s:expectchar == v:char
        let s:expectchar = ''
        if getline('.')[col('.') - 1] == v:char 
            let v:char = ''
            call feedkeys("\<Right>")
        endif
    else
        if exists("b:autopair") | let l:autopair = b:autopair | else | let l:autopair = g:autopair | endif
        let s:expectchar = ''
        for l:item in l:autopair
            if l:item[0] == v:char 
                " let v:char = l:item
                let s:expectchar = l:item[1]
                call feedkeys(l:item[1] . "\<Left>")
                break
            endif
        endfor
    endif
endfunction

augroup autopair
    au!
    au InsertCharPre * call s:needPair()
augroup END

""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=0 foldmethod=marker:

