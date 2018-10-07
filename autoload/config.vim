function! config#RgFileType(vimtype)
    let tp = get( {
                \    'python': 'py'
                \}, a:vimtype, a:vimtype )
    return l:tp
endfunction
