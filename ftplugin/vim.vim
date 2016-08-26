if exists("b:did_ftplugin")
  finish
endif

set keywordprg=:help
" execute current line
nnoremap <buffer> <Space>me :<C-U>exe getline(".")<CR>
vnoremap <buffer> <Space>me :<C-U>for tmp in getline("'<","'>")<bar>exe tmp<bar>endfor<CR>
vnoremap <buffer> <Space>ml :<C-U>exe join(map(getline("'<","'>"), 'substitute(v:val, "^\\s*\\\\","", "")'))<CR>
nnoremap <buffer> <Space>ms :<C-U>update <bar>source %<CR>
vnoremap <buffer> <Space>ms :<C-U>let tmp = tempname() <bar>exe "'<,'>w" tmp<bar>exe "source" tmp<CR>

setl omnifunc=MyVIMComplete

function! MyVIMComplete( findstart, base )
    let l:line_prefix = getline('.')[0: col('.') - 2]
    " echom "prefix: ". l:line_prefix
    if a:findstart
        let l:ret = necovim#get_complete_position(l:line_prefix)
        if l:ret < 0 | let l:ret = col('.') | endif " default to current
        " echom "complete at ". l:ret
        return l:ret
    else
        " echom "base: ".a:base
        let l:ret = necovim#gather_candidates(l:line_prefix . a:base, a:base)
        " echom len(l:ret). string(l:ret[0:5])
        return l:ret
    endif
endfunction

