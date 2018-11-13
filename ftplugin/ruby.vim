if exists("b:did_ftplugin") | finish | endif

let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}

nmap <buffer> <LocalLeader>e :update <bar> !ruby %<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
nmap <buffer> <LocalLeader>f :ALEFix<CR>

setl foldmethod=syntax

" 现在先只加载一次
if filereadable(".rubypaths")
    " 设置一些项目相关的参数
    let b:ale_fixers = ["rubocop"]
    let b:ale_linters = ["rubocop"]
    " see vim-ruby filetype definition. this variable will set path and tags
    if !exists('g:ruby_version_paths')
        let g:ruby_version_paths = {}
    endif
    let b:ruby_version = "custom"
    if !has_key(g:ruby_version_paths, b:ruby_version)
      let g:ruby_version_paths[b:ruby_version] = readfile(".rubypaths")
    endif
endif
