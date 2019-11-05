if exists("b:did_ftplugin") | finish | endif

" support tags: https://solargraph.org/guides/yard

let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}
let b:surround_100 = "do \r end"

nmap <buffer> <LocalLeader>e :update <bar> !ruby %<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
nmap <buffer> <LocalLeader>f :ALEFix<CR>

" look in rspec rake_task.rb, use SPEC to override default pattern, or set task options's pattern can override it.
" we need to ignore it to specify simple spec

" current line
nmap <buffer> <LocalLeader>t :update <bar> Rake spec 'SPEC=<C-R>%:<C-R>=line('.')<CR>'<CR>
" current line without job
nmap <buffer> <LocalLeader><C-t> :update <bar>
            \ let @* = "rake spec 'SPEC=<C-R>%:<C-R>=line('.')<CR>'"<CR>
" current file
nmap <buffer> <LocalLeader><M-t> :Rake spec 'SPEC=<C-R>%'<CR>
" all
nmap <buffer> <LocalLeader>T :Rake spec<CR>

" 现在先只加载一次
if filereadable(".rubocop.yml")
    " 是否启动rubocop. 无配置的rubocop太烦人了
    let b:ale_fixers = ["rubocop"]
    let b:ale_linters = ["rubocop"]
endif
