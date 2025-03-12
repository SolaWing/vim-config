if exists("b:did_ftplugin") | finish | endif

" support tags: https://solargraph.org/guides/yard

let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

" surround_d
let b:surround_100 = "do \r\nend"

if has_key(g:plugs, 'nvim-treesitter')
    " treesitter indent comment wrong, temp disable it
    setlocal indentexpr=
    setlocal smartindent autoindent

    setlocal foldmethod=expr
    " expr foldmethod cause easymotion jum when split very slow, use cache to avoid performance issue
    setlocal foldexpr=fold#cache(\"nvim_treesitter#foldexpr()\")

    if exists("g:no_ruby_maps") " 补充file和tag跳转map
        nmap <buffer><script> <SID>c: :<C-U><C-R>=v:count ? v:count : ''<CR>
        nmap <buffer><script> <SID>:  :<C-U>

        cmap <buffer><script><expr> <Plug><cfile> substitute(RubyCursorFile(),'^$',"\022\006",'')
        cmap <buffer> <C-R><C-F> <Plug><cfile>
        nmap <buffer><silent> gf           <SID>c:find <Plug><cfile><CR>')
        nmap <buffer><silent> <C-W>f      <SID>c:sfind <Plug><cfile><CR>')
        nmap <buffer><silent> <C-W><C-F>  <SID>c:sfind <Plug><cfile><CR>')
        nmap <buffer><silent> <C-W>gf   <SID>c:tabfind <Plug><cfile><CR>')

        cmap <buffer><script><expr> <Plug><ctag> substitute(RubyCursorTag(),'^$',"\022\027",'')
        cmap <buffer><script><expr> <SID>tagzv &foldopen =~# 'tag' ? '<Bar>norm! zv' : ''
        nmap <buffer> <C-]>       <SID>:exe  v:count1."tag <Plug><ctag>"<SID>tagzv<CR>
        nmap <buffer> g<C-]>      <SID>:exe         "tjump <Plug><ctag>"<SID>tagzv<CR>
        " nmap <buffer> g]          <SID>:exe       "tselect <Plug><ctag>"<SID>tagzv<CR>
        nmap <buffer> g]          <SID>:exe       "FZTags <Plug><ctag>"<CR>
        nmap <buffer> <C-W>]      <SID>:exe v:count1."stag <Plug><ctag>"<SID>tagzv<CR>
        nmap <buffer> <C-W><C-]>  <SID>:exe v:count1."stag <Plug><ctag>"<SID>tagzv<CR>
        nmap <buffer> <C-W>g<C-]> <SID>:exe        "stjump <Plug><ctag>"<SID>tagzv<CR>
        nmap <buffer> <C-W>g]     <SID>:exe      "stselect <Plug><ctag>"<SID>tagzv<CR>
        nmap <buffer> <C-W>}      <SID>:exe v:count1."ptag <Plug><ctag>"<CR>
        nmap <buffer> <C-W>g}     <SID>:exe        "ptjump <Plug><ctag>"<CR>
    end
elseif line('$') > 2000
    let b:ruby_no_expensive = 1
    let b:ruby_minlines = 75
    set foldmethod< " default is indent
else
    setlocal foldmethod=syntax
end

if !exists("g:ruby_pry")
    let g:ruby_pry = v:false
end

nmap <buffer> <LocalLeader>r :update <bar> !ruby %<CR>
nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer><expr> <LocalLeader><CR> g:ruby_pry ? "\"*y:let @*.=';'\<bar>SlimeSend1 pry_instance.eval `pbpaste`, {generated: true}\<CR>" : "\<Plug>SlimeRegionSend"
nmap <buffer> <LocalLeader>sf <Cmd>update<Bar>exe "SlimeSend1 load '"..expand("%:p").."'"<CR>

" vim ruby eval
nmap <buffer> <LocalLeader>ef :update <Bar> rubyfile %<CR>
xmap <buffer> <LocalLeader>E :<C-U>echo rubyeval("eval(VIM.evaluate('GetVisualString()'))")<CR>
xmap <buffer> <LocalLeader>ee <LocalLeader>E
nmap <buffer> <LocalLeader>ee :<C-U>echo rubyeval("eval(VIM.evaluate('getline(\".\")'))")<CR>

nnoremap <buffer> <LocalLeader>lt :<C-U>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>

" look in rspec rake_task.rb, use SPEC to override default pattern, or set task options's pattern can override it.
" we need to ignore it to specify simple spec

" FIXME: nest Rakefile local pwd will be reset after dispatch. but parent dir is wrong..

if has("nvim")
    if !exists("g:rubytest_dir")
        let g:rubytest_dir = v:false
        let g:rubytest = v:false
    end

    " use g:rubytest or b:test to run test, default to bundle exec rake spec
    nmap <buffer> <LocalLeader>t :update <bar> Dispatch -dir=<C-R><C-O>=g:rubytest_dir ?? "%:h"<CR> <C-R><C-O>=v:lua.require("config.ft.ruby").test_cmd("line")<CR><CR>
    nmap <buffer> <LocalLeader><C-t> :update <bar>
                \ let @* = v:lua.require("config.ft.ruby").test_cmd("line")<CR>
    nmap <buffer> <LocalLeader><M-t> :Dispatch -dir=<C-R><C-O>=g:rubytest_dir ?? "%:h"<CR> <C-R><C-O>=v:lua.require("config.ft.ruby").test_cmd("file")<CR><CR>
    " all
    nmap <buffer> <LocalLeader>T :Dispatch -dir=<C-R><C-O>=g:rubytest_dir ?? "%:h"<CR> <C-R><C-O>=v:lua.require("config.ft.ruby").test_cmd("all")<CR>
else
    " current line
    nmap <buffer> <LocalLeader>t :update <bar> Dispatch -dir=%:h bundle exec rake spec 'SPEC=<C-R>=expand("%:p")<CR>:<C-R>=line('.')<CR>'<CR>
    " copy current line command without job
    nmap <buffer> <LocalLeader><C-t> :update <bar>
                \ let @* = "bundle exec rspec '<C-R>=expand("%:p")<CR>:<C-R>=line('.')<CR>'"<CR>
    " current file
    nmap <buffer> <LocalLeader><M-t> :Dispatch -dir=%:h bundle exec rake spec 'SPEC=<C-R>=expand("%:p")<CR>'<CR>
    " all
    nmap <buffer> <LocalLeader>T :Dispatch -dir=%:h bundle exec rake spec<CR>
endif


" 现在先只加载一次
" if filereadable(".rubocop.yml")
"     " 是否启动rubocop. 无配置的rubocop太烦人了
"     let b:ale_fixers = ["rubocop"]
"     let b:ale_linters = ["rubocop"]
" endif

" coc project root check
" echo coc#util#root_patterns()
" let b:coc_root_patterns = ["Gemfile", ".solargraph.yml"]

if has_key(g:plugs, 'YouCompleteMe')
  nmap <buffer> <LocalLeader>f :YcmCompleter Format<CR>
  nnoremap <buffer> <LocalLeader>c :<C-U>YcmDiags<CR>
  nnoremap <buffer> <LocalLeader>gc :<C-U>YcmCompleter DocComment<CR>
else
  nnoremap <buffer> <LocalLeader>c :<C-U>CocDiagnostics<CR>
endif
