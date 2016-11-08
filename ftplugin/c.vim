if exists("b:did_ftplugin")
  finish
endif
" case statement in c indent style
setl cinoptions+=l1

com! -range=% CReFold <line1>,<line2>call <SID>refold()
com! -range=% CFold silent! exe printf('norm! %dGV%dGzD', <line1>,<line2>) | <line1>,<line2>g/\v^[-+a-zA-Z]&[^;{]*%(\n+\s*%(\s[^;{]*)?)*\{[^;{}]*$/.,/\v(^\}\s*\n\zs^\s*$|^\})/fold

inoremap <buffer> <M-;> <End>;<CR>
inoremap <buffer> <M-:> <End>;<Esc>

nnoremap <buffer> <leader>h      :call <SID>toggleHeader(1)<CR>
nnoremap <buffer> <C-W><leader>h :call <SID>toggleHeader(0)<CR>
nnoremap <buffer> <Space>mf :CReFold<CR>
vnoremap <buffer> <Space>mf :CReFold<CR>
" comment
" nnoremap <buffer> <Space>m/ I//<esc>
" vnoremap <buffer> <Space>m/ :s'\m^'//<CR>
" nnoremap <buffer> <Space>m? :<C-U>s'\m^\s*\zs//\+'<CR>
" vnoremap <buffer> <Space>m? :s'\m^\s*\zs//\+'<CR>
" compile
nnoremap <buffer> <Space>mc :<C-U>YcmDiags<CR>

nnoremap <buffer> <Space>mh :call <SID>moveImportToList()<CR>
vnoremap <buffer> <Space>mh :call <SID>moveImportToList()<CR>

" Clang-Format integrate
nmap <buffer> gq <Plug>(operator-clang-format)
vnoremap <buffer> gq :ClangFormat<CR>

" Unite integrate
" iMenu
nnoremap <buffer> <Space>mm :<C-U>Unite line -start-insert -input=^[-+@a-zA-Z_]<CR>

" ycmd mouse integrate
" nmap <2-LeftMouse> <M-g>

if exists("*s:refold") | finish | endif
function! s:refold() range
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
  let l:s = printf('%d,%dg/\v^[-+a-zA-Z]&[^;{]*(\n+\s*(\s[^;{]*)?)*\{[^;{}]*$/.,/^}/+1fold', a:firstline, l:c)
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

