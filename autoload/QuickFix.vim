function! QuickFix#Do(cmd, jumpFile, uselocal, bang)
  let l:hid = &hid
  let l:ei = &eventignore
  set hid
  set eventignore=all
  " let l:old_swb = &swb
  " set switchbuf=usetab,newtab   " open newtab for each execute file
  " echom a:cmd
  try
    let l:prefix = a:uselocal? 'l':'c'
    if exists(":cdo") == 2
        exe printf("%s%sdo%s %s", l:prefix, 
                    \ a:jumpFile? 'f' : '',
                    \ a:bang, a:cmd)
        return
    endif

    let v:errmsg = ""
    exe printf("%sfirst%s", l:prefix, a:bang)
    let l:next = printf("%s%s%s",
                \ a:uselocal? 'l':'c',
                \ a:jumpFile? 'nfile' : 'next',
                \ a:bang)
    while 1
      if v:errmsg != ''
        " echom v:errmsg
        return
      endif

      let l:foldenable = &foldenable
      set nofoldenable

      exe a:cmd

      let &foldenable = l:foldenable

      let v:errmsg = ""
      silent! exe l:next
    endwhile
  finally
    " let &switchbuf = l:old_swb
    let &hid = l:hid
    let &eventignore = l:ei
  endtry
endfunction
