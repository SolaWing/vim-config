function! config#RgFileType(vimtype)
    let tp = get( {
                \    'python': 'py',
                \    'eruby': 'erb',
                \    "scss": 'css',
                \    "fennel": "fennel --type-add 'fennel:*.fnl'"
                \}, a:vimtype, a:vimtype )
    return l:tp
endfunction
