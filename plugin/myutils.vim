if exists("loaded_myutils")
  finish
endif

let g:loaded_myutils = 1
" unlet g:loaded_myutils

""" python-shell: directly as a script interactive shell "{{{
PY << EOF
import interactivePython
u['interactiveScriptAnywhere'] = interactivePython.interactiveScriptAnywhere
u['findall'] = interactivePython.findAll
del interactivePython
EOF

imap <M-r> <esc><M-r>
nnoremap <M-r> :PY u['interactiveScriptAnywhere']('replace')<CR>
vnoremap <M-r> :PY u['interactiveScriptAnywhere']('replace')<CR>
imap <M-R> <esc><M-R>
nnoremap <M-R> :PY u['interactiveScriptAnywhere']('preview')<CR>
vnoremap <M-R> :PY u['interactiveScriptAnywhere']('preview')<CR>
imap <C-M-r> <esc><C-M-r>
nnoremap <C-M-r> :PY u['interactiveScriptAnywhere']('output')<CR>
vnoremap <C-M-r> :PY u['interactiveScriptAnywhere']('output')<CR>
"}}}

""" QuickDo"{{{
com! -nargs=1 -bang -complete=command CLDo call QuickFix#Do(<q-args>, !empty("<bang>"), 0)
com! -nargs=1 -bang -complete=command LLDo call QuickFix#Do(<q-args>, !empty("<bang>"), 1)
"}}}

""" redirect output and open in a scratch buffer
com! -nargs=1 -bang -complete=command Redir call myredirect#buffer(<q-args>, 0, !empty("<bang>"))

""" check syntax match"{{{
com! ShowSyntax let tmp = synID(line("."),col("."),1) | echo "syn<". synIDattr(tmp,"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(tmp),"name") . ">"
com! ShowSyntaxStack for tmp in synstack(line("."),col("."))|
      \ echo "syn<". synIDattr(tmp,"name") . "> lo<"
      \ . synIDattr(synIDtrans(tmp),"name") . ">"| endfor
"}}}

" WaitYankAndPaste "{{{
inoremap <expr> <M-y>  WaitYank#Paste()
inoremap <expr> <C-R>? WaitYank#Paste()
"}}}
" FindAll"{{{
com! -range=% -nargs=1 FindAll echo <q-args> | <line1>,<line2>PY u['findall'](<q-args>)
nnoremap <space>xf :FindAll<space>
vnoremap <space>xf :FindAll<space>
"}}}
" vim:set fdm=marker:
