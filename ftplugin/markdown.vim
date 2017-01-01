if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <LocalLeader>p :<C-U>KeepCursor %call markdown#preview()<CR>
vnoremap <buffer> <LocalLeader>p :call markdown#preview()<CR>
vnoremap <buffer> <LocalLeader>o :<C-U>call system('open '.'<C-R>=GetVisualString()<CR>')<CR>

nnoremap <buffer> <LocalLeader>h :<C-U>call <SID>header_line('-')<CR>
nnoremap <buffer> <LocalLeader>H :<C-U>call <SID>header_line('=')<CR>

function! s:header_line(char)
    let vc = virtcol('$')
    if vc > 0
        let sep = repeat(a:char, vc - 1)
        call append(line('.'), sep)
        norm! j$
    endif
endfunction

