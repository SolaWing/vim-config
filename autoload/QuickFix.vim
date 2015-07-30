function! QuickFix#Do(cmd, hasbang, uselocal)
  let l:old_hid = &hid
  set hid
  " let l:old_swb = &swb
  " set switchbuf=usetab,newtab   " open newtab for each execute file
  " echom a:cmd
  try
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

    while 1
      if v:errmsg != ''
        " echom v:errmsg
        return
      endif

      let l:fen = &fen
      set nofen

      exe a:cmd

      let &fen = l:fen

      let v:errmsg = ""
      silent! exe l:next
    endwhile
  finally
    " let &switchbuf = l:old_swb
    let &hid = l:old_hid
  endtry
endfunction
