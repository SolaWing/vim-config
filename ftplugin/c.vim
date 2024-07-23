if exists("b:did_ftplugin")
  finish
endif
" case statement in c indent style
setl cinoptions+=l1
setl commentstring=//\ %s

" diag will use it, avoid frequent column change
setl signcolumn=yes

com! -range=% CReFold <line1>,<line2>call <SID>refold()
com! -range=% CFold silent! exe printf('norm! %dGV%dGzD', <line1>,<line2>) | <line1>,<line2>g/\v^[-+a-zA-Z]&[^;{(]*\([^;{]*%(\n+\s*%(\s[^;{]*)?)*\{[^;{}]*$/.,/\v(^\}\s*\n\zs^\s*$|^\})/fold

inoremap <buffer> <M-;> <End>;<CR>
inoremap <buffer> <M-:> <End>;<Esc>
inoremap <buffer> <M-.> ->

nnoremap <buffer> <LocalLeader>h      :call <SID>toggleHeader(1)<CR>
nnoremap <buffer> <C-W><LocalLeader>h :call <SID>toggleHeader(0)<CR>
nnoremap <buffer> <LocalLeader>z :CReFold<HOME>KeepCursor <CR>zz
xnoremap <buffer> <LocalLeader>z :CReFold<CR>
" comment
" nnoremap <buffer> <LocalLeader>/ I//<esc>
" xnoremap <buffer> <LocalLeader>/ :s'\m^'//<CR>
" nnoremap <buffer> <LocalLeader>? :<C-U>s'\m^\s*\zs//\+'<CR>
" xnoremap <buffer> <LocalLeader>? :s'\m^\s*\zs//\+'<CR>
" compile
nnoremap <buffer> <LocalLeader>r :<C-U>update <bar> !clang++ -fobjc-arc -std=c++20 '%' -o /tmp/tmp.out && /tmp/tmp.out
nnoremap <buffer> <LocalLeader>c :<C-U>update <bar> Dispatch -compiler=gcc clang++ -fobjc-arc -std=c++20 '%' -o /tmp/tmp.out

if has_key(g:plugs, "YouCompleteMe")
    nnoremap <buffer> <LocalLeader>c :<C-U>YcmDiags<CR>
    " exchange for fast jump
    nnoremap <buffer> <LocalLeader>gh :YcmCompleter GoTo<CR>
    nnoremap <buffer> <LocalLeader>gg :YcmCompleter GoToImprecise<CR>
endif

nnoremap <buffer> <LocalLeader>i :call <SID>moveImportToList()<CR>
xnoremap <buffer> <LocalLeader>i :call <SID>moveImportToList()<CR>

" Clang-Format integrate
nmap <buffer> gq <Plug>(operator-clang-format)
xnoremap <buffer> gq :ClangFormat<CR>
nmap <buffer> gqq :ClangFormat<CR>

" use / to surround /* block comment
let b:surround_47 = "/* \r */"

" use # to surround #if 0
" let b:surround_35 = "#if 0 \r #endif"

" select next () or {}
" nnoremap <buffer> ]p /[({]<CR>v/[)}]<CR>
" select preview () or {}
" nnoremap <buffer> [p ?[)}]<CR>v?[({]<CR>

" ycmd mouse integrate
" nmap <2-LeftMouse> <M-g>

if exists("*s:refold") | finish | endif
function! s:refold() range
  if !(&foldmethod ==# 'manual' || &foldmethod ==# 'marker')
      return
  endif
  " delete old fold
  silent! exe printf('keepjumps norm! %dGV%dGzD', a:firstline, a:lastline) 
  let l:c = line("$")
  if l:c == a:lastline && getline(l:c) == '}' " add space line at lastline
    silent keepjumps norm! Go
  endif
  call cursor(a:firstline, 0)
  " add space line after }
  silent exe printf('%d,%dg/^}\n\ze\S/norm! o', a:firstline, a:lastline)
  let l:c = line("$") - l:c + a:lastline
  " create function fold
  let l:validDeclareBegin = '^[-+a-zA-Z]'
  " 先有(, 然后以{ 结尾的
  let l:validToDeclareEnd = '[^;{(]*\([^;{]*%(\n+\s*%(\s[^;{]*)?)*\{[^;{}]*$'
  let l:s = printf('%d,%dg/\v%s&%s/  .,/^}/+1fold', a:firstline, l:c, l:validDeclareBegin, l:validToDeclareEnd)
  " echom l:s
  silent exe l:s
endfunction

function! s:moveImportToList() range
    exe printf('%d,%ds/^\s*//', a:firstline, a:lastline)
    exe printf('%d,%dd', a:firstline, a:lastline)

    let l:line = search('#\%(import\|include\)', 'b')
    exe l:line . 'put'

    call cursor(a:lastline, 1)
endfunction


PY << EOF
import vim,os
def getCFamilyToggleFile(currentPath):
    header = [".h",".hpp"]
    source = [".c",".cpp",".m",".mm",".cc"]
    root, ext = os.path.splitext(currentPath)
    if not ext: return ""
    toggleExts = []
    if ext in header: #header file, return source file
        toggleExts = source
    elif ext in source:
        toggleExts = header
    for toggleExt in toggleExts:
        toggleFile = root+toggleExt
        if os.path.isfile(toggleFile):
            return toggleFile
    return ""
EOF

function! s:toggleHeader(reuseWindow)
  let l:file = expand("%:p")
  let l:ret = PYEVAL("getCFamilyToggleFile('".l:file."')")
  if !empty(l:ret)
    if a:reuseWindow
      let v:errmsg = ''
      silent! exe 'e' l:ret
      if v:errmsg == ''
        return
      endif
    endif

    if bufexists(l:ret)
      exe 'sb' l:ret
    else
      exe 'sp' l:ret
    endif
  endif
endfunction

