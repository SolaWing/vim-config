
set completeopt+=preview
let g:ycm_auto_hover = "" " auto hover distract
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_max_num_candidates = 9
" let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/mine.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/*']
" let g:ycm_confirm_extra_conf = 0
let g:ycm_key_detailed_diagnostics = '<LocalLeader>d'
" ycm only use key, value has no effect, so must remove to enable
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'qf' : 1,
            \ 'notes' : 1,
            \ 'markdown' : 1,
            \ 'unite' : 1,
            \ 'text' : 1,
            \ 'vimwiki' : 1,
            \ 'pandoc' : 1,
            \ 'infolog' : 1,
            \ 'mail' : 1,
            \ 'fzf' : 1
            \}
let g:ycm_semantic_triggers = {
            \ 'swift' : ['.']
            \ }
" let g:ycm_key_list_previous_completion = [] "for use enter to confirm select
" let g:ycm_key_list_select_completion = []
" let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
" let g:ycm_log_level = 'debug'
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_use_vim_stdout = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_rust_src_path=$HOME."/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
let g:ycm_language_server = [
            \   {
            \     'name': 'rust',
            \     'cmdline': ['rust-analyzer'],
            \     'filetypes': ['rust'],
            \     'project_root_files': ['Cargo.toml']
            \   }
            \ ]

nmap <C-W><LocalLeader>gr <C-W>s<LocalLeader>gr
nmap <C-W><LocalLeader>gg <C-W>s<LocalLeader>gg
nmap <C-W><LocalLeader>gh <C-W>s<LocalLeader>gh

nmap <C-W><M-g> <C-W>s<M-g>
nmap <Space>t<M-g> <C-W>s<C-W>T<M-g>
nmap <M-g> <LocalLeader>gg

nnoremap <LocalLeader>gr :YcmCompleter GoToReferences<CR>
nnoremap <LocalLeader>gg :YcmCompleter GoTo<CR>
nnoremap <LocalLeader>gh :YcmCompleter GoToImprecise<CR>

set keywordprg=:YcmCompleter\ GetDoc
nnoremap <LocalLeader>g<space> :YcmCompleter GetType<CR>
nnoremap <LocalLeader>gp :YcmCompleter GetParent<CR>
nnoremap <LocalLeader>g  :YcmCompleter GetType<CR>
nnoremap <LocalLeader>gf :YcmCompleter FixIt<CR>
nnoremap <LocalLeader>gc :YcmDiags<CR>
nnoremap <LocalLeader>gn :YcmCompleter RefactorRename 

" put here for compatibility, autopair's bufenter will prior to ycm's vimenter, so need to define first
silent! inoremap <expr> <CR> youcompleteme#OnCompleteAction("\<CR>")

Plug '~/.vim/bundle/YouCompleteMe', {'on': ['YcmCompleter']}
Plug 'SirVer/ultisnips', {'on': []}
source ~/.vim/bundle-config/ultisnip.vim
call timer_start(2000, {-> plug#load('ultisnips', 'YouCompleteMe') })
autocmd mine InsertEnter * ++once
            \ call plug#load('ultisnips', 'YouCompleteMe')
            \| exe 'autocmd mine BufLeave * call UltiSnips#LeavingBuffer()'

" other integration

let g:ycm_semantic_triggers.vim = ['$', '&']
let $RUST_SRC_PATH = g:ycm_rust_src_path

if has_key(g:plugs, 'auto-pairs')
    " compatibility between YCM and autopair, and none-buffer map make VM-Cursor map happy
    let g:ycm_key_param_template = 0
    let g:AutoPairsMapBS = 0
    " let g:AutoPairsMapCh = 0
    " function! FixMapCh()
    "     if pumvisible()
    "         return "\<Plug>YCM_BS"
    "     elseif exists('b:autopairs_enabled')
    "         return "\<C-R>=AutoPairsDelete()\<CR>"
    "     else
    "         return "\<BS>"
    "     endif
    " endfunction
    " imap <silent> <expr> <BS> FixMapCh()
    imap <C-H> <BS>

    let g:AutoPairsMapCR = 0
    function! FixMapCR()
        if pumvisible()
            return youcompleteme#OnCompleteAction("\<CR>")
        endif
        return "\<CR>\<C-R>=AutoPairsReturn()\<CR>"
    endfunction
    inoremap <silent><expr> <CR> FixMapCR()
endif
