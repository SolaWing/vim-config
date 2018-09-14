if exists("b:did_ftplugin") | finish | endif

let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

" 现在先只加载一次
if filereadable(".rubypaths")
    if !exists('g:ruby_version_paths')
        let g:ruby_version_paths = {}
    endif
    let b:ruby_version = "custom"
    if !has_key(g:ruby_version_paths, b:ruby_version)
      let g:ruby_version_paths[b:ruby_version] = readfile(".rubypaths")
    endif
endif
