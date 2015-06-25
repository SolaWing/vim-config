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
  if a:type == 0
    pedit +setl\ bt=nofile\ modifiable|silent\ exe\ "%d_|0put!=l:msg" [output]
  endif
endfunction
