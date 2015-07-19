if exists("b:did_ftplugin") | finish | endif

nnoremap <buffer> <Space>me :<C-U>let tmp = system("python", getline(1,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
vnoremap <buffer> <Space>me :w !python<CR>
nnoremap <buffer> <Space>ms :PY exec("\n".join(vim.current.range))<CR>
vnoremap <buffer> <Space>ms :PY exec("\n".join(vim.current.range))<CR>
setl formatoptions-=t

" in one command use fold will close text and cause include fold fail!!
function! PythonFold() range
  exe printf('silent! norm! %dGV%dGzD', a:firstline,a:lastline)
  let r = []
  exe printf('keeppatterns %d,%dg/\v^\s*%(def|class)[^:]*:/', a:firstline, a:lastline)
        \ 'exe "norm! ^" |'
        \ printf('call add(l:r, [line("."), search(%s)])',  ' ''\v%(\n%(^\s*\S%<''.(col(".")+2).''c)@=|%$)'' ' )

  " sort range, so contained range at the front
  function! SortR(l, r)
    if a:l[0] > a:r[1] | return 1
    elseif a:l[1] < a:r[0] | return -1
    elseif a:l[0] <= a:r[0] && a:l[1] >= a:r[1] | return 1
    else | return -1
    endif
  endfunction
  let sr = sort(r, "SortR")
  delfunction SortR

  for [s,e] in sr
    " echom "start:" s "end:" e
    exe printf('%d,%d fold', s,e)
  endfor
endfunction

com! -range=% PythonFold <line1>,<line2>call PythonFold()
nnoremap <space>mf :%call PythonFold()<CR>
vnoremap <space>mf :call PythonFold()<CR>
