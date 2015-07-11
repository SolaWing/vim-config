function! s:WaitYankAndPasteEnd(paste) "{{{
  if a:paste
    call setpos('.', b:WaitYankAndPasteInfo.pos)
    let l:cpos = getpos('.')
    if l:cpos[2] != b:WaitYankAndPasteInfo.pos[2] "col not equal paste after
      exe printf('norm! %dp', b:WaitYankAndPasteInfo.count)
    else
      exe printf('norm! %dP', b:WaitYankAndPasteInfo.count)
    endif
    if b:WaitYankAndPasteInfo.mode ==# 'i'
      call feedkeys('a', 'ni')
    endif
  endif

  au! WaitYankAndPaste
  unlet! b:WaitYankAndPasteInfo

  vunmap <buffer> y
  vunmap <buffer> Y
  nunmap <buffer> y
  nunmap <buffer> Y
endfunction
"}}}
function! s:yop(type) "{{{
  normal! `[v`]y
  call s:WaitYankAndPasteEnd(1)
endfunction
"}}}
function! WaitYank#Paste() "{{{
  let @@ = ""

  let b:WaitYankAndPasteInfo = {
        \ "pos"   : getpos('.'),
        \ "mode"  : mode()     ,
        \ "count" : v:count1   ,
        \ }

  vnoremap <silent><buffer> y y:call <SID>WaitYankAndPasteEnd(1)<CR>
  vnoremap <silent><buffer> Y Y:call <SID>WaitYankAndPasteEnd(1)<CR>
  nnoremap <silent><buffer> y :<C-U>set opfunc=<SID>yop<CR>g@
  nnoremap <silent><buffer> Y Y:call <SID>WaitYankAndPasteEnd(1)<CR>

  augroup WaitYankAndPaste
    au!
    " au CursorMoved,CursorHold <buffer> if @@ != "" | call <SID>WaitYankAndPasteEnd(1) | endif
    au InsertEnter <buffer> call <SID>WaitYankAndPasteEnd(0)
  augroup END
  return "\<C-\>\<C-N>"
endfunction
"}}}
