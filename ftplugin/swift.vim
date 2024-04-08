if exists("b:did_ftplugin")
  finish
endif
setl foldmethod=marker
setl foldmarker={,}
setl formatoptions+=r
setl comments=f:/*,e:*/,b:///,://

" use / to surround /* block comment
let b:surround_47 = "/* \r */"

nnoremap <buffer> <LocalLeader>m <Cmd>call fzf#vim#buffer_lines("func \\|class \\|extension \\|struct \\|protocol \\|enum \\|[^.]init(\\|\\%(MARK\\|TODO\\|FIXME\\):", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>lt <Cmd>call fzf#vim#buffer_lines("\\%(TODO\\|FIXME\\):", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>r :update <bar> !swift '%'<CR>
nnoremap <buffer> <LocalLeader>gk <Cmd>YcmCompleter RestartServer<CR>
nnoremap <buffer> <M-o> :OpenInXcode<CR>

nnoremap <buffer> <LocalLeader>b :Dispatch swift build --build-tests<CR>
nnoremap <buffer> <LocalLeader>t :Dispatch swift test --filter<Space>



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
