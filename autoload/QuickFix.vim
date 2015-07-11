function! QuickFix#Do(cmd, hasbang, uselocal)
  let v:errmsg = ""
  if a:hasbang
    if a:uselocal
      lfirst
      let l:next = 'lnext'
    else
      cfirst
      let l:next = 'cnext'
    endif
  else
    if a:uselocal
      lfirst!
      let l:next = 'lnext!'
    else
      cfirst!
      let l:next = 'cnext!'
    endif
  endif
  if v:errmsg != '' | return | endif
  exe a:cmd
  while 1
    let v:errmsg = ""
    silent! exe l:next
    if v:errmsg != '' | return | endif
    exe a:cmd
  endwhile
endfunction
