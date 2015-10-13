if exists("b:did_ftplugin")
  finish
endif

nnoremap <buffer> <Space>mp :<C-U>%call markdown#preview()<CR>
vnoremap <buffer> <Space>mp :call markdown#preview()<CR>
vnoremap <buffer> <Space>mo :<C-U>call system('open '.'<C-R>=GetVisualString()<CR>')<CR>

nnoremap <buffer> <Space>mh :<C-U>call <SID>header_line('-')<CR>
nnoremap <buffer> <Space>mH :<C-U>call <SID>header_line('=')<CR>

function! s:header_line(char)
    let vc = virtcol('$')
    if vc > 0
        let sep = repeat(a:char, vc - 1)
        call append(line('.'), sep)
        norm! j$
    endif
endfunction


