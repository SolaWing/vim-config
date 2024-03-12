if exists("b:did_ftplugin")
  finish
endif

setl textwidth=120
setl cursorline
setl conceallevel=2 " 隐藏链接

" use / to surround /* block comment
let b:surround_47 = "<!-- \r -->"
" use ^ to surround with ```
let b:surround_94 = "```\r```"


nnoremap <buffer> <LocalLeader>h :<C-U>call <SID>header_line('-')<CR>
nnoremap <buffer> <LocalLeader>H :<C-U>call <SID>header_line('=')<CR>

nnoremap <buffer> <LocalLeader>m :<C-U>Toc<CR>
nnoremap <buffer> <LocalLeader>1 :<C-U>call <SID>toggle_header(1)<CR>
nnoremap <buffer> <LocalLeader>2 :<C-U>call <SID>toggle_header(2)<CR>
nnoremap <buffer> <LocalLeader>3 :<C-U>call <SID>toggle_header(3)<CR>
nnoremap <buffer> <LocalLeader>4 :<C-U>call <SID>toggle_header(4)<CR>
nnoremap <buffer> <LocalLeader>5 :<C-U>call <SID>toggle_header(5)<CR>
nnoremap <buffer> <LocalLeader>6 :<C-U>call <SID>toggle_header(6)<CR>

" nnoremap <buffer> <LocalLeader>i :<C-U>call <SID>toggle_list(v:count)<CR>
nnoremap <buffer> <LocalLeader>i :<C-U>call v:lua.require("config.ft.markdown")["toggle-list-item"](v:count % 10)<CR>
xmap <buffer> <LocalLeader>i :call v:lua.require("config.ft.markdown")["toggle-list-item"](v:count % 10)<CR>

" strong, stroke through
xmap <buffer> <LocalLeader>b s*gvs*
xmap <buffer> <LocalLeader>s s~gvs~
xmap <buffer> <LocalLeader>c gs^

nnoremap <buffer> <LocalLeader>a| :silent KeepCursor ?^\s*\n?+1,/^\s*\n/-1 EasyAlign * |<CR>
nnoremap <buffer> <LocalLeader>at :TableFormat<CR>

nnoremap <buffer> <LocalLeader>^ :sort /^.*\%=virtcol('.')-1<CR>v/
xnoremap <buffer> <LocalLeader>^ :'<,'>sort /^.*\%=virtcol('.')-1<CR>v/

function! s:header_line(char)
    call s:remove_prefix_header()
    call s:remove_section_header()
    let vc = virtcol('$')
    if vc > 0
        let sep = repeat(a:char, vc - 1)
        call append(line('.'), sep)
        exe "norm! j$\<CR>"
    endif
endfunction

function! s:remove_prefix_header()
    " remove ### header
    let l = getline('.')
    let offset = matchend(l, '^#\+\s')
    if offset > 1
        call setline('.', l[offset:])
    end
endf
function! s:remove_section_header()
    " remove [-=] next line header
    let lno = line('.') + 1
    let l = getline(lno)
    if l =~ '^[-=]\+$'
        KeepCursor .+1delete _
    endif
endfunction

function! s:toggle_header(headerCount)
    call s:remove_section_header()
    let l = getline(".")
    let offset = matchend(l, '^#\+\s')
    let cursor = getcurpos()
    if offset == a:headerCount + 1 " clear header
        call setline('.', l[offset:])
        let cursor[2] -= offset
    elseif offset >= 0 " replace header
        call setline('.', repeat('#', a:headerCount) . ' ' . l[offset:])
        let cursor[2] += a:headerCount + 1 - offset
    else " add header
        call setline('.', repeat('#', a:headerCount) . ' ' . l)
        let cursor[2] += a:headerCount + 1
    endif
    call setpos('.', cursor)
endfunction
