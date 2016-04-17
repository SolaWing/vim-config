""" vim: set sw=4 ts=4 sts=4 et foldmarker={{,}} foldlevel=1 foldmethod=marker:
" vundle manager
    set nocompatible              " be iMproved, required
    filetype off                  " required
    " vundle plugin {{
        " set the runtime path to include Vundle and initialize
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
        " alternatively, pass a path where Vundle should install plugins
        "let path = '~/some/path/here'
        "call vundle#rc(path)

        " let Vundle manage Vundle, required
        Plugin 'gmarik/vundle'
    "}}
    " my bundles here {{
        " ---taglist nouse{{
            "let Tlist_Ctags_Cmd="xtags"
            "let Tlist_Close_On_Select=1
            "Plugin 'taglist.vim'
            "nnoremap <D-r> TlistToggle<CR>
            "nnoremap <leader>t :TlistToggle<CR>
        " }}
        " tagbar {{
        let g:tagbar_ctags_bin = "xtags"
        let g:tagbar_autoclose = 1
        let g:tagbar_type_objc = {
                    \ 'ctagstype' : 'ObjectiveC',
                    \ 'kinds'     : [
                        \ 'i:interface',
                        \ 'I:implementation',
                        \ 'P:Protocol',
                        \ 'm:Object_method',
                        \ 'c:Class_method',
                        \ 'v:Global_variable',
                        \ 'F:Object field',
                        \ 'f:function',
                        \ 'p:property',
                        \ 't:type_alias',
                        \ 's:type_structure',
                        \ 'e:enumeration',
                        \ 'M:preprocessor_macro',
                    \ ],
                    \ 'sro'        : ' ',
                    \ 'kind2scope' : {
                        \ 'i' : 'interface',
                        \ 'I' : 'implementation',
                        \ 'P' : 'protocol',
                        \ 's' : 'type_structure',
                        \ 'e' : 'enumeration'
                    \ },
                    \ 'scope2kind' : {
                        \ 'interface'      : 'i',
                        \ 'implementation' : 'I',
                        \ 'protocol'       : 'P',
                        \ 'type_structure' : 's',
                        \ 'enumeration'    : 'e'
                    \ }
                \ }
        let g:tagbar_type_objcpp = g:tagbar_type_objc
        Plugin 'majutsushi/tagbar'
        nnoremap <leader>t :TagbarToggle<CR>
        nnoremap <F3> :TagbarToggle<CR>
        " }}
        " Lokaltog/vim-easymotion"{{
        Plugin 'Lokaltog/vim-easymotion'
        map <S-Space> <Plug>(easymotion-bd-w)
        imap <S-Space> <C-o><Plug>(easymotion-bd-w)
        " <M-/>
        map  <M-/> <Plug>(easymotion-bd-w)
        imap <M-/> <C-o><Plug>(easymotion-bd-w)
        map  <M-?> <Plug>(easymotion-s)
        imap <M-?> <C-o><Plug>(easymotion-s)

        map <Space><Space> <Plug>(easymotion-s)
        " zap to char
        imap <M-z> <C-o>d<Plug>(easymotion-s)
        "}}
        " YouCompleteMe {{
            let g:ycm_allow_changing_updatetime = 1
            " let g:ycm_autoclose_preview_window_after_insertion = 1
            let g:ycm_collect_identifiers_from_comments_and_strings = 1
            let g:ycm_collect_identifiers_from_tags_files = 1
            let g:ycm_complete_in_comments = 1
            let g:ycm_enable_diagnostic_highlighting = 0
            " can pass same extra data to global conf
            let g:ycm_extra_conf_vim_data = [['ycm_additional_flags','get(b:, "ycm_additional_flags", g:ycm_additional_flags)']]
            let g:ycm_additional_flags = []
            let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
            let g:ycm_key_invoke_completion = '<M-.>'
            " let g:ycm_semantic_triggers = {
            "             \ 'swift' : ['.', ':', '->']
            "             \ }
            " let g:ycm_key_list_previous_completion = [] "for use enter to confirm select
            " let g:ycm_key_list_select_completion = []
            " let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
            " let g:ycm_server_log_level = 'debug'
            " let g:ycm_server_keep_logfiles = 1
            " let g:ycm_server_use_vim_stdout = 1
            let g:ycm_use_ultisnips_completer = 1
            let g:ycm_rust_src_path=$HOME."/Documents/github/rust/src"
            "Plugin 'Valloric/YouCompleteMe'
            Plugin 'file://~/.vim/bundle/YouCompleteMe', {'pinned': 1}
            nnoremap <C-W><leader>ggi <C-W>s:YcmCompleter GoToDeclaration<CR>
            nnoremap <C-W><leader>ggd <C-W>s:YcmCompleter GoToDefinition<CR>
            nnoremap <C-W><leader>gg <C-W>s:YcmCompleter GoTo<CR>
            nnoremap <C-W><leader>gh <C-W>s:YcmCompleter GoToImprecise<CR>
            nnoremap <C-W><M-g> <C-W>s:YcmCompleter GoTo<CR>
            nnoremap <Space>t<M-g> <C-W>s<C-W>T:YcmCompleter GoTo<CR>
            nnoremap <leader>ggi :YcmCompleter GoToDeclaration<CR>
            nnoremap <leader>ggd :YcmCompleter GoToDefinition<CR>
            nnoremap <leader>gg :YcmCompleter GoTo<CR>
            nnoremap <M-g> :YcmCompleter GoTo<CR>
            nnoremap <leader>gh :YcmCompleter GoToImprecise<CR>
            nnoremap <leader>gt :YcmCompleter GetType<CR>
            nnoremap <leader>gp :YcmCompleter GetParent<CR>
            nnoremap <leader>g :YcmCompleter GetType<CR>
            nnoremap <leader>gf :YcmCompleter FixIt<CR>
        " }}
        " ---supertab {{
        " use this can use CR to confirm complete so can use tab as UltiSnips
            "let g:SuperTabDefaultCompletionType = "context"
            "let g:SuperTabContextDefaultCompletionType = "<c-n>"
            "let g:SuperTabLongestEnhanced = 1
            "let g:SuperTabLongestHighlight = 1
            "Plugin 'ervandew/supertab'
        " }}
        " SirVer/ultisnips {{
        let g:UltiSnipsExpandTrigger="<M-'>" " M-'
        let g:UltiSnipsJumpForwardTrigger="<C-j>"
        let g:UltiSnipsJumpBackwardTrigger="<C-k>"
        let g:UltiSnipsEditSplit = "horizontal"
        let g:UltiSnipsListSnippets="<M-\">"   " M-S-"
        let g:UltiSnipsEnableSnipMate = 0
        " nvim have a different location, so set it
        let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
        " load two version of python spend a lot of time
        let g:UltiSnipsUsePythonVersion = 2
        Plugin 'SirVer/ultisnips'

        " Optional:
        Plugin 'honza/vim-snippets'
        let g:ultisnips_python_style = 'jedi'

        com! UltiTmpSnippet call UltiSnips#AddFiletypes("tmp") | UltiSnipsEdit tmp
        nnoremap <leader>st :UltiTmpSnippet<CR>
        nnoremap <leader>se :UltiSnipsEdit<CR>

        " preview auto stop snippet. so disable it
        autocmd User UltiSnipsEnterFirstSnippet set completeopt-=preview
        autocmd User UltiSnipsExitLastSnippet set completeopt+=preview
        " }}
        " ctrlp {{
            let g:ctrlp_cache_dir = '~/.vim/bundle/ctrlp.vim/cache/'
            let g:ctrlp_buftag_ctags_bin = 'xtags'
            let g:ctrlp_lazy_update = 1
            let g:ctrlp_by_filename = 1
            let g:ctrlp_clear_cache_on_exit = 0
            let g:ctrlp_prompt_mappings = {
                        \ 'PrtSelectMove("j")':   ['<c-j>', '<down>',   '<M-j>'],
                        \ 'PrtSelectMove("k")':   ['<c-k>', '<up>',     '<M-k>'],
                        \ 'PrtCurLeft()':         ['<c-h>', '<left>',   '<M-h>'],
                        \ 'PrtCurRight()':        ['<c-l>', '<right>',  '<M-l>'],
                        \ }
            let g:ctrlp_user_command = 'find %s -type f'       " MacOSX/Linux
            Plugin 'kien/ctrlp.vim'
        " }}
        " tpope/vim-surround "{{
        Plugin 'tpope/vim-surround'
        xnoremap S s
        xmap s <Plug>VSurround
        xmap gs <Plug>VgSurround
        "}}
        " tpope/vim-unimpaired"{{
        Plugin 'tpope/vim-unimpaired'
        "}}
        " tpope/vim-repeat"{{
        Plugin 'tpope/vim-repeat'
        "}}
        " tpope/fugitive {{
        Plugin 'tpope/vim-fugitive'
        " }}
        " kshenoy/vim-signature"{{
        let g:SignaturePeriodicRefresh = 0
        "let g:SignatureEnabledAtStartup = 0
        let g:SignatureUnconditionallyRecycleMarks = 1
        Plugin 'kshenoy/vim-signature'
        "}}
        " restore_view {{
        Plugin 'restore_view.vim'
        set viewoptions=folds,cursor
        let g:skipview_files = ['.*\.vim']
        " }}
        " dash {{
        Plugin 'rizzatti/dash.vim'
        nmap <leader>K <Plug>DashSearch
        let g:dash_map = {
            \ 'objc' : ['ios', 'c', 'manpages'],
            \ 'objcpp' : ['ios', 'cpp', 'c', 'manpages'],
            \ 'lua'  : ['lua','cocos2dx']
            \}
        " }}
        " my plugin" {{
        Plugin 'file://~/.vim/bundle/vim-objc-syntax', {'pinned':1}
        Plugin 'file://~/.vim/bundle/quick-ultisnip', {'pinned' : 1}
        inoremap <C-r><CR> <C-R>=quickUltiSnip#Insert()<CR>
        " insert default register
        inoremap <C-r><CR><CR> <C-R>=quickUltiSnip#Insert()<CR>"
        nnoremap <M-p> :call quickUltiSnip#Paste()<CR>
        vmap <M-y> <Plug>quickUltiSnipYankVisual
        nmap <M-Y> <Plug>quickUltiSnipYankLineWise
        nmap <M-y> <Plug>quickUltiSnipYankOperator
        " }}
        " ---lldb-plugin {{
        "Plugin 'gilligan/vim-lldb'
        " }}
        " autopair {{
        let g:AutoPairsShortcutBackInsert = ""
        let g:AutoPairsShortcutToggle = ""

        let g:ycm_key_param_template = 0
        " put here for compatibility
        silent! inoremap <expr> <CR> pumvisible()?"<C-y><C-r>=youcompleteme#OnCompleteAction()<CR>"
                    \ : "\<CR>"

        Plugin 'jiangmiao/auto-pairs'
        " }}
        " vim-airline {{
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        " }}
        " scrooloose/nerdtree {{
            let g:NERDTreeBookmarksFile = $HOME . "/.vim/bundle/nerdtree/.NERDTreeBookmarks"
            let g:NERDTreeShowLineNumbers = 1
            let g:NERDTreeMapOpenSplit = 's'
            let g:NERDTreeMapOpenVSplit = 'v'
            Plugin 'scrooloose/nerdtree'
            nnoremap <leader>e :let g:NERDTreeQuitOnOpen = 0 <bar> NERDTreeToggle<CR>
            nnoremap <F2> :let g:NERDTreeQuitOnOpen = 0 <bar> NERDTreeToggle<CR>
            nnoremap <leader><C-e> :let g:NERDTreeQuitOnOpen = 1 <bar> NERDTreeFind<CR>
            nnoremap <S-F2> :let g:NERDTreeQuitOnOpen = 1 <bar> NERDTreeFind<CR>
            nmap <F14> <S-F2>
            nmap <leader><F2> <S-F2>
        " }}
        " scrooloose/syntastic {{
        let g:syntastic_python_checkers = ["python"]
        Plugin 'scrooloose/syntastic'
        " }}
        " scrooloose/nerdcommenter {{
        let g:NERDSpaceDelims = 1
        Plugin 'scrooloose/nerdcommenter'
        imap <C-c> <HOME><Plug>NERDCommenterInsert
        " }}
        " mileszs/ack.vim"{{
        let g:ackhighlight = 1
        let g:ackprg = 'ag --vimgrep'
        " this seems to only set fcl = all, will affect other buffer
        " let g:ack_autofold_results = 1

        " the find file will add to the unlisted buffers.
        " when there have thousands of unlisted buffers,
        " YCM will work extremly slow, I have fix it
        Plugin 'mileszs/ack.vim'
        "}}
        " sjl/gundo.vim"{{
        Plugin 'sjl/gundo.vim' " undo tree
        nnoremap <F6> :GundoToggle<CR>
        "}}
        " kana/vim-submode"{{
        let g:submode_timeout = 0
        let g:submode_keep_leaving_key = 1
        Plugin 'kana/vim-submode'
        function! SubmodeMap(name, mode, maps)
            for [enter, short, rhs, opt] in a:maps
                if !empty(enter)
                    call submode#enter_with(a:name, a:mode, opt, enter, rhs)
                endif
                if !empty(short)
                    call submode#map(a:name, a:mode, opt, short, rhs)
                endif
            endfor
        endfunction
        call SubmodeMap('undo/redo', 'n',
                    \ [['g-', '-', 'g-', '']
                    \ ,['g+', '+', 'g+', '']
                    \ ,['',   '=', 'g+', '']])
        call SubmodeMap('ChangeList', 'n',
                    \ [['g;', ';', 'g;',           '']
                    \ ,['g,', ',', 'g,',           '']
                    \ ,['',   'L', ':changes<CR>', 'x']])
        call SubmodeMap('Navigation', 'n',
                    \ [['gt',         't',     'gt',      '']
                    \ ,['gT',         'T',     'gT',      '']
                    \ ,['<C-W><C-J>', '<C-J>', '<C-W>j',  '']
                    \ ,['<C-W><C-K>', '<C-K>', '<C-W>k',  '']
                    \ ,['<C-W><C-H>', '<C-H>', '<C-W>h',  '']
                    \ ,['<C-W><C-L>', '<C-L>', '<C-W>l',  '']
                    \ ,['<C-W>J',     'J',     '<C-W>J',  '']
                    \ ,['<C-W>K',     'K',     '<C-W>K',  '']
                    \ ,['<C-W>H',     'H',     '<C-W>H',  '']
                    \ ,['<C-W>L',     'L',     '<C-W>L',  '']
                    \ ,['<C-W>r',     'r',     '<C-W>r',  '']
                    \ ,['<C-W>R',     'R',     '<C-W>R',  '']
                    \ ,['<C-W>x',     'x',     '<C-W>x',  '']
                    \ ,['<C-W>-',     '-',     '<C-W>-',  '']
                    \ ,['<C-W>+',     '+',     '<C-W>+',  '']
                    \ ,['<C-W><',     '<',     '<C-W><',  '']
                    \ ,['<C-W>>',     '>',     '<C-W>>',  '']
                    \ ,['',           '_',     '<C-W>_',  '']
                    \ ,['',           '=',     '<C-W>=',  '']
                    \ ,['',           '\|',    '<C-W>\|', '']
                    \ ,['',           '<C-T>', '<C-W>T',  '']
                    \ ,['',           's',     '<C-W>s',  '']
                    \ ,['',           'v',     '<C-W>v',  '']
                    \ ,['',           'n',     '<C-W>n',  '']
                    \ ,['',           'q',     '<C-W>q',  '']
                    \ ,['',           'c',     '<C-W>c',  '']
                    \ ,['',           'o',     '<C-W>o',  '']
                    \ ,['',           'f',     '<C-F>',   '']
                    \ ,['',           'b',     '<C-B>',   '']
                    \ ,['',           'd',     '<C-D>',   '']
                    \ ,['',           'u',     '<C-U>',   '']
                    \ ])
        "}}
        " terryma/vim-multiple-cursors "{{
        Plugin 'terryma/vim-multiple-cursors'
        "}}
        " Shougo/unite.vim"{{
        " Using ag as recursive command.
        Plugin 'Shougo/unite.vim'
        " Plugin 'Shougo/unite-outline'
        " execute command return false when have arg, this should a bug
        call unite#custom#source('buffer, file_rec/neovim, file_rec/git',
                    \ 'matchers', ['converter_tail', 'matcher_fuzzy'])
        let g:unite_source_rec_async_command = 'find'
        nnoremap <Space>ub :<C-U>Unite buffer<CR>
        nnoremap <Space>um :<C-U>Unite bookmarks<CR>
        nnoremap <Space>u; :<C-U>Unite command -start-insert<CR>
        nnoremap <Space>u: :<C-U>Unite command<CR>
        nnoremap <Space>ul :<C-U>Unite line -start-insert<CR>
        nnoremap <Space>uu :<C-U>UniteResume<CR>
        " search like occur
        cnoremap <C-o> <CR>:<C-U>Unite line -input=<C-R>=escape(@/," ")<CR> -auto-preview -no-split<CR>

        autocmd FileType unite call s:unite_my_settings()
        function! s:unite_my_settings() "{{{
            imap <buffer> '     <Plug>(unite_quick_match_default_action)
            nmap <buffer> '     <Plug>(unite_quick_match_default_action)
            imap <buffer> <C-J>     <Plug>(unite_quick_match_jump)
            nmap <buffer> J     <Plug>(unite_quick_match_jump)
            nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
            imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
            nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
            imap <silent><buffer><expr> <C-s>     unite#do_action('split')
        endfunction "}}}
        "}}
        " Shougo/vimproc.vim {{
        Plugin 'Shougo/vimproc.vim'
        " }}
        " Shougo/neomru.vim {{
        " let g:neomru#file_mru_path = '~/.vim/bundle/neomru.vim/cache/file'
        " let g:neomru#directory_mru_path = '~/.vim/bundle/neomru.vim/cache/dir'
        " let g:neomru#do_validate = 0
        " Plugin 'Shougo/neomru.vim'
        " }}
        " " godlygeek/tabular {{
        " Plugin 'godlygeek/tabular'
        " "}}
        " junegunn/vim-easy-align {{
        Plugin 'junegunn/vim-easy-align'
        vmap <cr> <Plug>(EasyAlign)
        nmap ga   <Plug>(EasyAlign)
        " }}
        " hynek/vim-python-pep8-indent"{{
        Plugin 'hynek/vim-python-pep8-indent'
        "}}
        " --- ivanov/vim-ipython"{{
        " Plugin 'ivanov/vim-ipython'
        "}}
        " keith/swift.vim "{{
        Plugin 'keith/swift.vim'
        " 现在支持还不够好. 以后真的需要再说吧. 暂时用xcode开发swift
        " Plugin 'keith/sourcekittendaemon.vim'
        " Plugin 'mitsuse/autocomplete-swift'
        "}}
        " kana/vim-operator-user  "{{
        Plugin 'kana/vim-operator-user'
        "}}
        " rhysd/vim-clang-format "{{
        let g:clang_format#detect_style_file = 1 " use .clang-format
        Plugin 'rhysd/vim-clang-format'
        "}}
        " rust-lang/rust.vim"{{
        Plugin 'rust-lang/rust.vim'
        "}}
        "racer-rust/vim-racer"{{
        " Plugin 'racer-rust/vim-racer'
        let $RUST_SRC_PATH=$HOME."/Documents/github/rust/src/"
        "}}
  "}}
    filetype plugin indent on     " required

