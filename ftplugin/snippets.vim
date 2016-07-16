if exists("b:did_ftplugin") | finish | endif

let b:snipCount = 0
function! s:markParamOP(type) range
    let b:snipCount=g:count?g:count : b:snipCount + 1
    unlet g:count
    norm! `[v`]c${=b:snipCount:"}
endfunction

vnoremap <M-$> c${:let b:snipCount=v:count? v:count : b:snipCount+1=b:snipCount:"}<ESC>
nnoremap <M-$> :<C-U>let g:count=v:count<bar>set opfunc=<SID>markParamOPg@
