if exists("b:did_ftplugin")
  finish
endif
setl foldmethod=marker
setl foldmarker={,}
setl formatoptions+=r
setl comments=f:/*,e:*/,b:///,://

" Coc失效了，先在文件里定义, 等release发布
let b:coc_root_patterns = ["buildServer.json", "Package.swift"]

" use / to surround /* block comment
let b:surround_47 = "/* \r */"

nnoremap <buffer> <LocalLeader>m <Cmd>call fzf#vim#buffer_lines("func \\|class \\|extension \\|struct \\|protocol \\|enum \\|[^.]init(\\|\\%(MARK\\|TODO\\|FIXME\\):", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>lt <Cmd>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>r :update <bar> !swift '%'<CR>
nnoremap <buffer> <LocalLeader>gk <Cmd>YcmCompleter RestartServer<CR>
nnoremap <buffer> <M-o> :OpenInXcode<CR>

nnoremap <buffer> <LocalLeader>b :Dispatch swift build --build-tests<CR>
nnoremap <buffer> <LocalLeader>t :Dispatch swift test --filter<Space>
nnoremap <buffer> <LocalLeader>T :Dispatch swift test<CR>

nnoremap <buffer> <LocalLeader>i :call <SID>moveImportToList()<CR>
xnoremap <buffer> <LocalLeader>i :call <SID>moveImportToList()<CR>

snoremap <buffer> <CR> <ESC>:call <SID>ExpandClosure(1)<CR>
snoremap <buffer> <M-CR> <ESC>:call <SID>ExpandClosure(0)<CR>
" make g:UltiSnipsMappings don't remove select mode mapping of ExpandClosure
let g:UltiSnipsMappingsToIgnore = ["ExpandClosure"]

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

if has_key(g:plugs, 'YouCompleteMe')
nnoremap <buffer> <LocalLeader>c :<C-U>YcmDiags<CR>
nnoremap <buffer> <LocalLeader>gd :<C-U>YcmCompleter DocComment<CR>
else
nnoremap <buffer> <LocalLeader>c :<C-U>CocDiagnostics<CR>
nnoremap <buffer><expr> <LocalLeader>xt <SID>insertHint()
endif


let b:ale_swift_swiftlint_config = findfile(".swiftlint.yml", expand("%:p:h") . ";")
if filereadable(b:ale_swift_swiftlint_config)
    let b:ale_swift_swiftlint_config = fnamemodify(b:ale_swift_swiftlint_config, ":p")
    unlet! b:ale_linters_ignore
    " nnoremap <buffer> <LocalLeader>f :!cd '%:h' && swiftlint lint --fix -- '%:t'<CR>
    nnoremap <buffer> <LocalLeader>f :!cd <C-R>=fnamemodify(b:ale_swift_swiftlint_config, ":p:h")<CR>; swiftlint lint --fix -- '%:p'<CR>
else
    nnoremap <buffer> <LocalLeader>f :%!swift-format --configuration ~/.swift-format<CR>
    let b:ale_linters_ignore = ['swiftlint', 'my_swiftlint']
endif
nnoremap <buffer> <LocalLeader>F :%!swift-format --configuration ~/.swift-format<CR>


" should select expanding closure before call this method, when curry, expand last closure as a single curry argument
function! s:ExpandClosure(curry) range
    PY import swifttool
    " PY from importlib import reload
    " PY reload(swifttool)
    return PYEVAL( printf( "swifttool.expand_closure(%d)", a:curry))
endfunction

function! s:moveImportToList() range
    exe printf('%d,%ds/^\s*//', a:firstline, a:lastline)
    exe printf('%d,%dd', a:firstline, a:lastline)

    let l:line = search('^\s*\%(import\)', 'b')
    exe l:line . 'put'

    call cursor(a:lastline, 1)
endfunction

if has_key(g:plugs, "coc.nvim")
function! s:insertHint()
    let hover = CocAction('getHover')[0]
    let m = matchlist(hover, ':\s*\(.\{-}\)\ze[\r\n]')
    if len(m) > 1
        return "wgea: "..m[1].."\<esc>"
    end
    echo "can't get type"
    return ""
endfunction
endif
