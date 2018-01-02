if exists("b:did_ftplugin")
  finish
endif

setl textwidth=120
setl formatoptions-=t
setl cursorline

" use / to surround /* block comment
let b:surround_47 = "<!-- \r -->"

nnoremap <buffer> <LocalLeader>p :<C-U>KeepCursor %call markdown#preview()<CR>
xnoremap <buffer> <LocalLeader>p :call markdown#preview()<CR>
xnoremap <buffer> <LocalLeader>o :<C-U>call system('open '.'<C-R>=GetVisualString()<CR>')<CR>

nnoremap <buffer> <LocalLeader>h :<C-U>call <SID>header_line('-')<CR>
nnoremap <buffer> <LocalLeader>H :<C-U>call <SID>header_line('=')<CR>

nnoremap <buffer> <LocalLeader>m :<C-U>Toc<CR>
nnoremap <buffer> <LocalLeader>1 :<C-U>call <SID>toggle_header(1)<CR>
nnoremap <buffer> <LocalLeader>2 :<C-U>call <SID>toggle_header(2)<CR>
nnoremap <buffer> <LocalLeader>3 :<C-U>call <SID>toggle_header(3)<CR>
nnoremap <buffer> <LocalLeader>4 :<C-U>call <SID>toggle_header(4)<CR>
nnoremap <buffer> <LocalLeader>5 :<C-U>call <SID>toggle_header(5)<CR>
nnoremap <buffer> <LocalLeader>6 :<C-U>call <SID>toggle_header(6)<CR>

" strong, stroke through
xmap <buffer> <LocalLeader>b s*gvs*
xmap <buffer> <LocalLeader>s s~gvs~

nnoremap <buffer> <LocalLeader>a| :silent KeepCursor ?^\s*\n?+1,/^\s*\n/-1 EasyAlign * |<CR>
nnoremap <buffer> <LocalLeader>at :TableFormat<CR>

nnoremap <buffer> <LocalLeader>^ :sort /^.*\%=virtcol('.')-1<CR>v/
xnoremap <buffer> <LocalLeader>^ :'<,'>sort /^.*\%=virtcol('.')-1<CR>v/

function! s:header_line(char)
    let vc = virtcol('$')
    if vc > 0
        let sep = repeat(a:char, vc - 1)
        call append(line('.'), sep)
        exe "norm! j$\<CR>"
    endif
endfunction

function! s:toggle_header(headerCount)
    let l = getline(".")
    let offset = matchend(l, '^#\+\s')
    let cursor = getcurpos()
    if offset == a:headerCount + 1 " clear header
        call setline('.', l[offset:])
        let cursor[2] -= offset
    elseif offset >= 0 " replace header
        call setline('.', repeat('#', a:headerCount) . ' ' . l[offset:])
        let cursor[2] += a:headerCount + 1 - offset
    else " add header
        call setline('.', repeat('#', a:headerCount) . ' ' . l)
        let cursor[2] += a:headerCount + 1
    endif
    call setpos('.', cursor)
endfunction

