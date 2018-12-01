if exists("b:did_ftplugin")
  finish
endif
setl fdm=indent
setl formatoptions+=r

" use / to surround /* block comment
let b:surround_47 = "/* \r */"

nnoremap <buffer> <LocalLeader>m :<C-U>call fzf#vim#buffer_lines("func \\|class \\|extension \\|struct \\|enum \\|[^.]init(\\|MARK:", {'options': '+s'})<CR>
nnoremap <buffer> <LocalLeader>f :!swiftlint autocorrect --path %:p<CR>

snoremap <buffer> <CR> <ESC>:call <SID>ExpandClosure(1)<CR>
snoremap <buffer> <M-CR> <ESC>:call <SID>ExpandClosure(0)<CR>

nmap <buffer> <LocalLeader><CR> <Plug>SlimeLineSend
xmap <buffer> <LocalLeader><CR> <Plug>SlimeRegionSend

let g:UltiSnipsMappingsToIgnore = ["ExpandClosure"]

if filereadable(".swiftlint.yml")
    unlet! b:ale_linters_ignore
else
    let b:ale_linters_ignore = ['swiftlint']
endif


" should select expanding closure before call this method, when curry, expand last closure as a single curry argument
function! s:ExpandClosure(curry) range
    PY import swifttool
    return PYEVAL( printf( "swifttool.expand_closure(%d)", a:curry))
endfunction
