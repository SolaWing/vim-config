function! config#RgFileType(vimtype)
    let tp = get( {
                \    'python': 'py',
                \    'eruby': 'erb',
                \    "scss": 'css'
                \}, a:vimtype, a:vimtype )
    return l:tp
endfunction
