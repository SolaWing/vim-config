function! DevioSearch(filetype, keyword)
    if a:filetype == "swift" || a:filetype == "objc" || a:filetype == "objcpp"
        call system( printf("open -a Firefox 'https://developer.apple.com/search/?q=%s'", a:keyword) )
    elseif a:filetype == "racket"
        call system( printf("raco docs '%s'", a:keyword) )
    else
        call system( printf("open -a Firefox 'https://devdocs.io/#q=%s%%20%s'", a:filetype, a:keyword) )
    endif
endfunction
nnoremap <LocalLeader>k :call DevioSearch(&ft, '<C-R><C-W>')<CR>
vnoremap <LocalLeader>k :call DevioSearch(&ft, '<C-R>=GetVisualString()<CR>')<CR>
map <LocalLeader>K <LocalLeader>k
