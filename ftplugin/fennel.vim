if exists("b:did_ftplugin") | finish | endif

if has_key(g:plugs, 'YouCompleteMe')
    " ensure auto complete when input .
    imap <buffer> . .<C-Space>
endif

nnoremap <buffer> <LocalLeader>m <Cmd>call fzf#vim#buffer_lines('fn-\?\s\+\w\|\%(MARK\|TODO\|FIXME\):', {'options': '+s'})<CR>
nnoremap <buffer> ,c <Cmd>update<bar>AniseedCompile<CR>
nnoremap <buffer> ,hh <Cmd>!open 'https://fennel-lang.org/reference'<CR>

" TODO: set include path to help find module "
