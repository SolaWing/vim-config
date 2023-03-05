if exists("b:did_ftplugin") | finish | endif

if has_key(g:plugs, 'YouCompleteMe')
    " ensure auto complete when input .
    imap <buffer> . .<C-Space>
endif

let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"'}

nnoremap <buffer> <LocalLeader>m <Cmd>call fzf#vim#buffer_lines('fn-\?\s\+\w\|\%(MARK\|TODO\|FIXME\):', {'options': '+s'})<CR>
nnoremap <buffer> ,c :<C-U>update<bar>AniseedCompile<CR>
nnoremap <buffer> ,hh <Cmd>!open 'https://fennel-lang.org/reference'<CR>
setl keywordprg=:help

nnoremap <buffer> gf <Cmd>call v:lua.require("config.ft.fennel")["goto-module"](expand("<cfile>"), v:true)<CR>
xnoremap <buffer> gf "vy<Cmd>call v:lua.require("config.ft.fennel")["goto-module"](@v, v:true)<CR>
nnoremap <buffer> gF <Cmd>call v:lua.require("config.ft.fennel")["goto-module"](expand("<cfile>"), v:false)<CR>
xnoremap <buffer> gF "vy<Cmd>call v:lua.require("config.ft.fennel")["goto-module"](@v, v:false)<CR>

" TODO: set include path to help find module "
