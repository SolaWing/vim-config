if exists("b:did_ftplugin") | finish | endif

function! s:markParamOP(type) range
    norm! `[v`]c${=g:savecount:"}
    unlet g:savecount
endfunction

vnoremap <M-$> c${=v:count:"}<ESC>
nnoremap <M-$> :<C-U>let g:savecount=v:count<bar>set opfunc=<SID>markParamOPg@
