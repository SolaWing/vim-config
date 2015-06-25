"{
let s:cpo_save = &cpo
set cpo&vim

command SSHPush call sshHelper#Push()

function! sshHelper#map(local, remote)
    if a:local[0] == "/"
        let g:sshMapLocal = a:local
    else
        let g:sshMapLocal = getcwd() . '/' . a:local
    endif
    if ! isdirectory(g:sshMapLocal)
        echo 'local path not a directory.'
        unlet g:sshMapLocal
    endif

    let g:sshMapLocal = simplify(g:sshMapLocal)

    if g:sshMapLocal[-1:] != "/" 
        let g:sshMapLocal = g:sshMapLocal . '/'
    endif
    let g:sshMapRemote = a:remote

    if a:remote[-1:] != "/" 
        let g:sshMapRemote = a:remote . '/'
    else
        let g:sshMapRemote = a:remote
    endif
    
    echo g:sshMapLocal
    echo g:sshMapRemote
endfunction

function! sshHelper#Push()
    if ! exists("g:sshMapLocal")
        return
    endif
    let l:curpath = expand('%:p')
    let l:relativePos = stridx(l:curpath, g:sshMapLocal) 
    if l:relativePos != 0
        echo "not start with mapLocal"
        return
    endif

    let l:relativePath = strpart(l:curpath, strlen(g:sshMapLocal) )
    echo l:relativePath

    let l:remotePath = g:sshMapRemote . l:relativePath

    exe printf('!scp -p -q %s %s', l:curpath, l:remotePath)
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=1 foldmethod=marker:
"}
