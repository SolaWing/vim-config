if exists("b:did_ftplugin") | finish | endif

if has_key(g:plugs, 'YouCompleteMe')
    " ensure auto complete when input .
    imap <buffer> . .<C-Space>
endif

nnoremap <buffer> ,c <Cmd>AniseedCompile<CR>
nnoremap <buffer> ,hh <Cmd>!open 'https://fennel-lang.org/reference'<CR>

" TODO: set include path to help find module "
