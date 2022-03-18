if exists("b:did_ftplugin") | finish | endif

if has_key(g:plugs, 'YouCompleteMe')
    " ensure auto complete when input .
    imap <buffer> . .<C-Space>
endif

" TODO: set include path to help find module "
