if exists("b:did_ftplugin") | finish | endif

" support tags: https://solargraph.org/guides/yard

let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '|':'|'}
let b:surround_100 = "do \r\nend"

if has_key(g:plugs, 'nvim-treesitter')
    setlocal foldmethod=expr
    setlocal foldexpr=nvim_treesitter#foldexpr()
elseif line('$') > 2000
    let b:ruby_no_expensive = 1
    let b:ruby_minlines = 75
    setlocal foldmethod=indent
else
    setlocal foldmethod=syntax
end

nmap <buffer> <LocalLeader>r :update <bar> !ruby %<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
" xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend
xmap <buffer> <LocalLeader><CR> "*y:let @*.=';'<bar>SlimeSend1 pry_instance.eval `pbpaste`, {generated: true}<CR>

nnoremap <buffer> <LocalLeader>c :<C-U>YcmDiags<CR>
nnoremap <buffer> <LocalLeader>gc :<C-U>YcmCompleter DocComment<CR>

nnoremap <buffer> <LocalLeader>lt :<C-U>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>

" look in rspec rake_task.rb, use SPEC to override default pattern, or set task options's pattern can override it.
" we need to ignore it to specify simple spec

" current line
nmap <buffer> <LocalLeader>t :update <bar> Rake spec 'SPEC=<C-R>%:<C-R>=line('.')<CR>'<CR>
" copy current line command without job
nmap <buffer> <LocalLeader><C-t> :update <bar>
            \ let @* = "bundle exec rake spec 'SPEC=<C-R>%:<C-R>=line('.')<CR>'"<CR>
" current file
nmap <buffer> <LocalLeader><M-t> :Rake spec 'SPEC=<C-R>%'<CR>
" all
nmap <buffer> <LocalLeader>T :Rake spec<CR>

" 现在先只加载一次
" if filereadable(".rubocop.yml")
"     " 是否启动rubocop. 无配置的rubocop太烦人了
"     let b:ale_fixers = ["rubocop"]
"     let b:ale_linters = ["rubocop"]
" endif

" coc project root check
let b:coc_root_patterns = ["Gemfile"]

if has_key(g:plugs, 'YouCompleteMe')
  nmap <LocalLeader>f :YcmCompleter Format<CR>
endif
