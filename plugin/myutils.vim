if exists("loaded_myutils")
  finish
endif

let g:loaded_myutils = 1

""" directly as a script interactive shell
PY << EOF
import interactivePython
interactivePython.g = globals()
u['interactiveScriptAnywhere'] = interactivePython.interactiveScriptAnywhere
del interactivePython
EOF

imap <M-r> <esc><M-r>
nnoremap <M-r> :PY u['interactiveScriptAnywhere'](True)<CR>
vnoremap <M-r> :PY u['interactiveScriptAnywhere'](True)<CR>
imap <C-M-r> <esc><C-M-r>
nnoremap <C-M-r> :PY u['interactiveScriptAnywhere'](False)<CR>
vnoremap <C-M-r> :PY u['interactiveScriptAnywhere'](False)<CR>

""" QuickDo
function! QuickDo(cmd, hasbang, uselocal)
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
      lfirst
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

com! -nargs=1 -bang -complete=command CLDo call QuickDo(<q-args>, !empty("<bang>"), 0)
com! -nargs=1 -bang -complete=command LLDo call QuickDo(<q-args>, !empty("<bang>"), 1)

""" redirect output and open in a scratch buffer
com! -nargs=1 -bang -complete=command Redir call myredirect#buffer(<q-args>, 0, !empty("<bang>"))

""" check syntax match
com! ShowSyntax let tmp = synID(line("."),col("."),1) | echo "syn<". synIDattr(tmp,"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(tmp),"name") . ">"
com! ShowSyntaxStack for tmp in synstack(line("."),col("."))|
      \ echo "syn<". synIDattr(tmp,"name") . "> lo<"
      \ . synIDattr(synIDtrans(tmp),"name") . ">"| endfor


