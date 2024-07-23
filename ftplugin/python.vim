if exists("b:did_ftplugin") | finish | endif

setl keywordprg<

" let b:ale_enabled = 0 " lint is too strict and distract. use ALEToggleBuffer to enable it
" if !exists("g:python_recommended_style")
"     let g:python_recommended_style = 0
"     setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=4
" endif

nnoremap <buffer> <LocalLeader>lt :<C-U>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>

if exists('g:usepy') && g:usepy == 3
    nnoremap <buffer> <LocalLeader>r :<C-U>let tmp = system("python3", getline(1,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
    xnoremap <buffer> <LocalLeader>r :w !python3<CR>
    nnoremap <buffer> <LocalLeader>s :py3 exec("\n".join(vim.current.range))<CR>
    xnoremap <buffer> <LocalLeader>s :py3 exec("\n".join(vim.current.range))<CR>
else
    nnoremap <buffer> <LocalLeader>r :<C-U>let tmp = system("python", getline(1,'$'))<bar>call setreg(v:register, tmp)<bar>echo tmp<CR>
    xnoremap <buffer> <LocalLeader>r :w !python<CR>
    nnoremap <buffer> <LocalLeader>s :py exec("\n".join(vim.current.range))<CR>
    xnoremap <buffer> <LocalLeader>s :py exec("\n".join(vim.current.range))<CR>
endif
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

" smartinent with pep8 indent, cause # to first column
" setl nosmartindent
setl formatoptions-=t
setl formatprg=yapf

com! -range=% PythonFold <line1>,<line2>call PythonFold()
nnoremap <buffer> <LocalLeader>z :%call PythonFold()<CR>
xnoremap <buffer> <LocalLeader>z :call PythonFold()<CR>
nnoremap <buffer> <LocalLeader>i :call <SID>moveImportToList()<CR>
xnoremap <buffer> <LocalLeader>i :call <SID>moveImportToList()<CR>

" in one command use fold will close text and cause include fold fail!!
function! PythonFold() range
  exe printf('silent! norm! %dGV%dGzD', a:firstline,a:lastline)
  let r = []
  exe printf('keeppatterns %d,%dg/\v^\s*%((async )?def|class)[^:]*:/', a:firstline, a:lastline)
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


function! s:moveImportToList() range
    exe printf('%d,%ds/^\s*//', a:firstline, a:lastline)
    exe printf('%d,%dd', a:firstline, a:lastline)

    let l:line = search('^\%(import\|from\)', 'b')
    " echom "lineis". l:line
    exe l:line . 'put'

    call cursor(a:lastline, 1)
endfunction

if has_key(g:plugs, 'YouCompleteMe')
  nmap <buffer> <LocalLeader>f :ALEFix<CR>
else
" echo coc#util#root_patterns()
let b:coc_root_patterns = ["pyrightconfig.json", "pyproject.toml"]
end
