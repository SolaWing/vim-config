"{
let s:cpo_save = &cpo
set cpo&vim

"mysvn#commit{ 
function! mysvn#commit(args)
    " cd ~/svntestpro/svntest/
    let l:bufnr = bufnr('[SVN] commit')
    if l:bufnr == -1 
        silent vne +setl\ bt=acwrite\ noswapfile\ bh=hide [SVN] commit
        augroup mysvn
            au! * <buffer>
            au BufWriteCmd <buffer> call <SID>Commit()
        augroup END

        " map {
        nnoremap <buffer> <LocalLeader>y :call <SID>changeLines(1)<CR>
        nnoremap <buffer> <LocalLeader>n :call <SID>changeLines(0)<CR>
        nnoremap <buffer><special> - :call <SID>changeLines(2)<CR>
        vnoremap <buffer> <LocalLeader>y :call <SID>changeLines(1)<CR>gv
        vnoremap <buffer> <LocalLeader>n :call <SID>changeLines(0)<CR>gv
        vnoremap <buffer><special> - :call <SID>changeLines(2)<CR>gv
        nnoremap <buffer> <LocalLeader>d :call <SID>command('diff')<CR>
        vnoremap <buffer> <LocalLeader>d :call <SID>command('diff')<CR><ESC>gv
        nnoremap <buffer> <LocalLeader>r :call <SID>command('revert')<CR>
        vnoremap <buffer> <LocalLeader>r :call <SID>command('revert')<CR>
        " }
    else
        exe 'silent vert sb ' . l:bufnr
    endif

    silent %d " clear content
    silent exe printf('r !svn st %s', a:args) 
    silent g/^ M/s//MM/  " so can change ignore property
    silent g/^\S...\s\+/norm! 8|i 
    " ignore file in pattern list
    let l:ignoreLines = []
    let l:ignorePatterns = []
    if exists('g:svncommitIgnore') && type(g:svncommitIgnore) == type([])
        call extend(l:ignorePatterns, g:svncommitIgnore)
    endif
    if filereadable("svncommit.ignore") " ignore path feature
        call extend(l:ignorePatterns, filter(readfile("svncommit.ignore"), 'v:val =~"\\S"'))
    endif
    " echo l:ignorePatterns
    for l:item in l:ignorePatterns
        silent exe printf('g/\C^[ADM]...\s\+.*%s/d|call add(l:ignoreLines, @")', l:item)
    endfor

    silent g/\C^[ADM]...\s\+/norm! 8|rx
    silent sort!
    " add ignore file to bottom
    if len(l:ignoreLines) > 0
        " add ignoreLines at the buttom
        call cursor(line('$'), 0)
        silent put = '+IGNORE LIST -----------------------------------'
        for l:item in l:ignoreLines
            silent put = l:item
        endfor
    endif

    silent 0put =
         \\"\n------------------------------------------------\n
             \the message above will be used as commit message\n
             \\n
             \use <LocalLeader>y to enable item,\n
             \  <LocalLeader>n to disable item,\n
             \  - to toggle item\n
             \  <LocalLeader>d to diff item\n
             \  <LocalLeader>r to revert item\n
             \the flags at the first,\n
             \the x before filepath show the file will be commit\n
             \\n
             \the line below is committed file\n
             \================================================\"
    call cursor(1,1)
    silent setl nomodified syntax=svn
endfunction
"}
"s:Commit{
function! s:Commit()
    let l:savepos = getpos('.')
    let l:saveList = []
    while 1
        " search Modify files
        call cursor(2,1)
        let l:svnBegin = search('^===============') + 1

        " first add new file {
        call cursor(l:svnBegin,1)
        silent .,$g/\m\C^?...\s\+x /call add(l:saveList, 
            \substitute(getline('.'), '\C^?...\s\+x\s\+', "", "") )
        if len(l:saveList) > 0
            " add file to addList
            call writefile(l:saveList, "svnadd.tmp")
            !svn add --targets svnadd.tmp -q --parents --force --depth 'empty'
            if v:shell_error
                break 
            endif
            silent !rm svnadd.tmp
        endif "}
        " then delete miss file {
        let l:deleteList = []
        call cursor(l:svnBegin, 1)
        silent .,$g/\C^!...\s\+x /call add(l:deleteList, 
            \substitute(getline('.'), '\C^!...\s\+x\s\+', "", "") )
        if len(l:deleteList) > 0
            " add file to deleteList
            call writefile(l:deleteList, "svndelete.tmp")
            !svn rm --targets svndelete.tmp -q
            if v:shell_error
                break
            endif
            silent !rm svndelete.tmp
            call extend(l:saveList, l:deleteList)
        endif
        unlet l:deleteList "}
        " last get commit file and commit them {
        call cursor(l:svnBegin,1)
        silent .,$
            \g/\C^[ADM]...\s\+x /
            \call add(l:saveList, 
            \substitute(getline('.'), '\C^[ADM]...\s\+x\s\+', "", "") )
        if len(l:saveList) > 0 
            " save commit msg
            call cursor(1,1)
            call writefile(getline(1,search('^----------------') - 1), "svncommitMsg.tmp")
            " has something to commit
            call writefile(l:saveList, "svncommit.tmp")
            !svn commit --targets svncommit.tmp -F svncommitMsg.tmp 
            if v:shell_error
                break 
            endif
            silent !rm svncommit*.tmp
            setl nomodified

            quit
        else
            echo 'nodata wil be write'
        endif "}

        break
    endwhile

    call setpos('.', l:savepos)
    
endfunction
"}
" s:changeLine {
function! s:changeLine(command)
    if a:command == 2 
        norm! 8|yl
        if @" == 'x' " replace with space
            norm! r 
        else         " replace with x
            norm! rx
        endif
    elseif a:command == 0
        norm! 8|r 
    else
        norm! 8|rx
    endif
endfunction
" }
" s:changeLines, command 0:disable, 2:toggle, other:enable {
function! s:changeLines(command,...) range
    let l:firstline = a:firstline
    let l:lastline = a:lastline
    let l:savepos = getpos('.')
    call cursor(2,1)
    let l:svnBegin = search('^===============') + 1
    if l:lastline < l:svnBegin 
        call setpos('.', l:savepos)
        if a:0 > 0 
            exe a:1
        endif
        return 0    " show not deal it
    endif

    " begin from actual area
    if l:firstline < l:svnBegin
        let l:firstline = l:svnBegin
    endif

    " change line
    silent exe printf('%d,%dg/\C^[AMD!?]...\s\+/call %s',
        \l:firstline, l:lastline,
        \"<SID>changeLine(a:command)")
    return 1
endfunction
" }
" s:diffFile {
function! s:command(command) range
    let l:firstline = a:firstline
    let l:lastline = a:lastline
    let l:savepos = getpos('.')
    call cursor(2,1)
    let l:svnBegin = search('^===============') + 1
    if l:lastline < l:svnBegin 
        call setpos('.', l:savepos)
        return 0    " show not deal it
    endif

    " begin from actual area
    if l:firstline < l:svnBegin
        let l:firstline = l:svnBegin
    endif

    " diff line
    let l:files = []
    silent exe printf('%d,%dg/\C^[AMD]...\s\+/call 
        \add(l:files, substitute(getline("."), 
        \%s\C^....\s\+.\s\+%s, "", "" ))',
        \l:firstline, l:lastline,
        \"'","'")
    if len(l:files) > 0
        if a:command == 'diff'
            exe printf('!svn di %s', join(l:files, ' '))
        elseif a:command == 'revert'
            exe printf('!svn revert %s', join(l:files, ' '))
            silent exe printf('%d,%dg/\C^[AMD]...\s\+/d', l:firstline, l:lastline)
        endif
    endif
    call setpos('.', l:savepos)
    return 1
endfunction
" }
" mysvn#revert {
function! mysvn#revert(args)
    let l:bufnr = bufnr('[SVN] revert')
    if l:bufnr == -1 
        silent vne +setl\ bt=acwrite\ noswapfile\ bh=hide [SVN]\ revert
        augroup mysvn
            au! * <buffer>
            au BufWriteCmd <buffer> call <SID>Revert()
        augroup END

        " map {
        nnoremap <buffer> <LocalLeader>y :call <SID>changeLines(1)<CR>
        nnoremap <buffer> <LocalLeader>n :call <SID>changeLines(0)<CR>
        nnoremap <buffer><special> - :call <SID>changeLines(2)<CR>
        vnoremap <buffer> <LocalLeader>y :call <SID>changeLines(1)<CR>gv
        vnoremap <buffer> <LocalLeader>n :call <SID>changeLines(0)<CR>gv
        vnoremap <buffer><special> - :call <SID>changeLines(2)<CR>gv
        nnoremap <buffer> <LocalLeader>d :call <SID>command('diff')<CR>
        vnoremap <buffer> <LocalLeader>d :call <SID>command('diff')<CR><ESC>gv
        " }
    else
        exe 'silent vert sb ' . l:bufnr
    endif

    silent %d
    silent exe printf('r !svn st %s', a:args) 
    silent g/^[?]...\s\+/d
    silent g/^[AMD!]...\s\+/norm! 8|i 

    silent 0put = 
             \\"------------------------------------------------\n
             \use <LocalLeader>y to revert item,\n
             \  <LocalLeader>n to ignore item,\n
             \  space to toggle item\n
             \  <LocalLeader>d to diff item\n
             \the flags at the first,\n
             \the x before filepath show the file will be revert\n
             \================================================\"
    call cursor(9,1)
    silent setl nomodified syntax=svn
endfunction
" }
"s:Revert{
function! s:Revert()
    let l:savepos = getpos('.')
    let l:saveList = []
    while 1
        " search Modify files
        call cursor(1,1)
        let l:svnBegin = search('^===============') + 1

        " last get revert file and revert them {
        call cursor(l:svnBegin,1)
        silent .,$
            \g/\C^[ADM!]...\s\+x /
            \call add(l:saveList, 
            \substitute(getline('.'), '\C^[ADM!]...\s\+x\s\+', "", "") )
        if len(l:saveList) > 0 
            " has something to revert
            call writefile(l:saveList, "svnrevert.tmp")
            !svn revert --targets svnrevert.tmp
            if v:shell_error
                break 
            endif
            silent !rm svnrevert.tmp
            setl nomodified

            quit
        else
            echo 'nodata wil be write'
        endif "}

        break
    endwhile

    call setpos('.', l:savepos)
endfunction
"}
let &cpo = s:cpo_save
unlet s:cpo_save

""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=1 foldmethod=marker:
"}
