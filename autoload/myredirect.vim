function! myredirect#buffer(cmd, type, ignoreErr)
  try
    redir => l:msg
    if a:ignoreErr
      silent! execute a:cmd
    else
      silent execute a:cmd
    endif
  finally
    redir END
  endtry
  let l:msg = trim(l:msg) " redirect有奇怪的首行空白问题, 裁剪一下
  if a:type == 0
    pedit +setl\ bt=nofile\ modifiable\ noswapfile|silent\ exe\ "%d_|0put!\ =l:msg" [output]
  endif
endfunction
