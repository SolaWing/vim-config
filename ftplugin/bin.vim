" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl binary<"

if !&bin 
    e ++bin
endif
%!xxd

augroup binary
    au!
    au BufWritePre <buffer> if &bin | let b:save_cursor = getpos(".") | %!xxd -r
    au BufWritePre <buffer> endif
    au BufWritePost <buffer> if &bin | %!xxd
    au BufWritePost <buffer> call setpos('.', b:save_cursor) | set nomod | endif
augroup END
