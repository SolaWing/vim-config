if exists("b:did_ftplugin") | finish | endif

let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}
let b:surround_100 = "do \r end"

nmap <buffer> <LocalLeader>e :update <bar> !ruby %<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
nmap <buffer> <LocalLeader>f :ALEFix<CR>

" look in rspec rake_task.rb, use SPEC to override default pattern, or set task options's pattern can override it.
" we need to ignore it to specify simple spec
nmap <buffer> <LocalLeader>t :update <bar> Dispatch rake spec SPEC="%\:<C-R>=line('.')<CR>"<CR>
nmap <buffer> <LocalLeader><M-t> :Dispatch rake spec SPEC="%"<CR>
nmap <buffer> <LocalLeader>T :Dispatch rake spec<CR>

setl foldmethod=syntax

" 现在先只加载一次
if filereadable(".rubocop.yml")
    " 是否启动rubocop. 无配置的rubocop太烦人了
    let b:ale_fixers = ["rubocop"]
    let b:ale_linters = ["rubocop"]
endif
" if filereadable(".rubypaths")
"     " see vim-ruby filetype definition. this variable will set path and tags
"     if !exists('g:ruby_version_paths')
"         let g:ruby_version_paths = {}
"     endif
"     let b:ruby_version = "custom"
"     if !has_key(g:ruby_version_paths, b:ruby_version)
"       let g:ruby_version_paths[b:ruby_version] = readfile(".rubypaths")
"     endif
" endif
