if exists("b:did_ftplugin")
  finish
endif

setl keywordprg=:help

" execute current line
nnoremap <buffer> <LocalLeader>e :<C-U>exe getline(".")<CR>
xnoremap <buffer> <LocalLeader>e :<C-U>for tmp in getline("'<","'>")<bar>exe tmp<bar>endfor<CR>
xnoremap <buffer> <LocalLeader>l :<C-U>exe join(map(getline("'<","'>"), 'substitute(v:val, "^\\s*\\\\","", "")'))<CR>
nnoremap <buffer> <LocalLeader>s :<C-U>update <bar>source %<CR>
xnoremap <buffer> <LocalLeader>s :<C-U>let tmp = tempname() <bar>exe "'<,'>w" tmp<bar>exe "source" tmp<CR>

nnoremap <buffer> <LocalLeader>gg <C-]>

setl omnifunc=MyVIMComplete

function! MyVIMComplete( findstart, base )
    if a:findstart
        let l:line_prefix = getline('.')[0: col('.') - 2]
        " echom "prefix: ". l:line_prefix
        let s:prefix = ""
        let l:ret = necovim#get_complete_position(l:line_prefix)
        if l:ret > 0
            let s:prefix = l:line_prefix[: l:ret - 1]
        endif
        " if l:ret < 0 | let l:ret = col('.') | endif " default to current
        " echom "complete at ". l:ret
        return l:ret
    else
        " echom "s:prefix ". s:prefix
        " echom "base: ".a:base
        let l:ret = necovim#gather_candidates(s:prefix . a:base, a:base)
        " echom len(l:ret). string(l:ret[0:5])
        return l:ret
    endif
endfunction

