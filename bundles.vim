""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:
" vundle manager
    set nocompatible              " be iMproved, required
    call plug#begin('~/.vim/bundle')
    " my bundles here {{{
    " ==================== Basic{{{
        " tagbar {{{
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
        let g:tagbar_type_rust = {
                    \ 'ctagstype' : 'Rust',
                    \ 'kinds' : [
                    \       'n:module:1:0',
                    \       's:struct:0:1',
                    \       'i:trait:0:1',
                    \       'c:implementation:0:0',
                    \       'f:function:0:1',
                    \       'g:enum:0:1',
                    \       't:type alias:0:1',
                    \       'v:global variable:0:1',
                    \       'M:macro:0:1',
                    \       'm:struct field:0:1',
                    \       'e:enum variant:0:1',
                    \       'F:method:0:1',
                    \ ],
                    \ 'sro' : '::',
                    \ 'kind2scope' : {
                        \ 'n' : 'module',
                        \ 's' : 'struct',
                        \ 'i' : 'interface',
                        \ 'c' : 'implementation',
                        \ 'f' : 'function',
                        \ 'g' : 'enum',
                        \ 'F' : 'method',
                    \ },
                    \ 'scope2kind' : {
                        \ 'module'        : 'n',
                        \ 'struct'        : 's',
                        \ 'interface'     : 'i',
                        \ 'implementation': 'c',
                        \ 'function'      : 'f',
                        \ 'enum'          : 'g',
                        \ 'method'        : 'F',
                    \ }
                    \}
        Plug 'majutsushi/tagbar' , { 'on': 'TagbarToggle'}
        nnoremap <F3> :TagbarToggle<CR>
        " }}}

        " Lokaltog/vim-easymotion"{{{
        let g:EasyMotion_do_mapping = 0
        let g:EasyMotion_startofline = 0
        " let g:EasyMotion_use_upper = 1
        " let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
        Plug 'easymotion/vim-easymotion' " custom
        map  <S-Space> <Plug>(easymotion-bd-w)
        imap <S-Space> <C-o><Plug>(easymotion-bd-w)
        " <M-/>
        map  <M-/> <Plug>(easymotion-bd-w)
        imap <M-/> <C-o><Plug>(easymotion-bd-w)
        map  <M-?> <Plug>(easymotion-s)
        imap <M-?> <C-o><Plug>(easymotion-s)

        Map  <Space><CR>    <Plug>(easymotion-bd-jk)
        Map  <Space><Space> <Plug>(easymotion-s)
        nmap <C-W><Space>   <Plug>(easymotion-overwin-f)
        nmap <C-W><M-/>     <Plug>(easymotion-overwin-w)
        nmap <C-W><CR>      <Plug>(easymotion-overwin-line)
        " zap to char
        imap <M-z> <C-o>d<Plug>(easymotion-s)

        "}}}

        " justinmk/vim-sneak {{{
        Plug 'justinmk/vim-sneak'
        let g:sneak#use_ic_scs = 1
        Map \ <Plug>Sneak_s
        Map <bar> <Plug>Sneak_S
        Map , <Plug>SneakPrevious
        " }}}

        " YouCompleteMe {{{
            " let g:ycm_autoclose_preview_window_after_insertion = 1
            let g:ycm_collect_identifiers_from_comments_and_strings = 1
            let g:ycm_extra_conf_globlist = ['~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py']
            " let g:ycm_confirm_extra_conf = 0
            let g:ycm_collect_identifiers_from_tags_files = 1
            let g:ycm_seed_identifiers_with_syntax = 1
            let g:ycm_complete_in_comments = 1
            let g:ycm_max_num_candidates = 10
            " let g:ycm_enable_diagnostic_highlighting = 0
            let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/mine.ycm_extra_conf.py'
            " let g:ycm_key_invoke_completion = '<M-.>'
            let g:ycm_key_detailed_diagnostics = '<LocalLeader>d'
            " ycm only use key, value has no effect, so must remove to enable
            let g:ycm_filetype_blacklist = {
                        \ 'tagbar' : 1,
                        \ 'qf' : 1,
                        \ 'notes' : 1,
                        \ 'markdownEnable' : 1,
                        \ 'unite' : 1,
                        \ 'text' : 1,
                        \ 'vimwiki' : 1,
                        \ 'pandoc' : 1,
                        \ 'infolog' : 1,
                        \ 'mail' : 1,
                        \ 'fzf' : 1,
                        \}
            " let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}
            let g:ycm_semantic_triggers = {
                        \ 'swift' : ['.']
                        \ }
            " let g:ycm_key_list_previous_completion = [] "for use enter to confirm select
            " let g:ycm_key_list_select_completion = []
            " let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
            " let g:ycm_python_binary_path = 'python'
            " let g:ycm_log_level = 'debug'
            " let g:ycm_server_keep_logfiles = 1
            " let g:ycm_server_use_vim_stdout = 1
            let g:ycm_use_ultisnips_completer = 1
            let g:ycm_rust_src_path=$HOME."/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
            Plug '~/.vim/bundle/YouCompleteMe', {'on': ['YcmCompleter']}
            call timer_start(2000, {-> plug#load('ultisnips', 'YouCompleteMe') })
            augroup my_ycm_load
                autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
                            \| autocmd! my_ycm_load
            augroup END

            nmap <C-W><LocalLeader>gr <C-W>s<LocalLeader>gr
            nmap <C-W><LocalLeader>gg <C-W>s<LocalLeader>gg
            nmap <C-W><LocalLeader>gh <C-W>s<LocalLeader>gh

            nmap <C-W><M-g> <C-W>s<M-g>
            nmap <Space>t<M-g> <C-W>s<C-W>T<M-g>
            nmap <M-g> <LocalLeader>gg

            nnoremap <LocalLeader>gr :YcmCompleter GoToReferences<CR>
            nnoremap <LocalLeader>gg :YcmCompleter GoTo<CR>
            nnoremap <LocalLeader>gh :YcmCompleter GoToImprecise<CR>

            nnoremap <LocalLeader>gd :YcmCompleter GetDoc<CR>
            nnoremap <LocalLeader>gt :YcmCompleter GetType<CR>
            nnoremap <LocalLeader>gp :YcmCompleter GetParent<CR>
            nnoremap <LocalLeader>g  :YcmCompleter GetType<CR>
            nnoremap <LocalLeader>gf :YcmCompleter FixIt<CR>
            nnoremap <LocalLeader>gc :YcmDiags<CR>
            nnoremap <LocalLeader>ge :YcmCompleter RefactorRename 

            " put here for compatibility, autopair's bufenter will prior to ycm's vimenter, so need to define first
            silent! inoremap <expr> <CR> youcompleteme#OnCompleteAction("\<CR>")
            " if has('nvim')
            "     Plug 'ncm2/float-preview.nvim'
            " end
        " }}}

        " Shougo/neco-vim "{{{
        Plug 'Shougo/neco-vim', {'for': 'vim'}
        let g:ycm_semantic_triggers.vim = ['$', '&']
        ""}}}

        " SirVer/ultisnips {{{
        let g:UltiSnipsListSnippets        = "<Plug>UltisnipList"
        let g:UltiSnipsExpandTrigger       = "<Plug>UltisnipExpand"
        " function! ExpandOrList()
        "     let l = getline('.')
        "     let l:kw = matchstr(l,'\v\S+$')
        "     if len(l:kw)
        "         return "\<Plug>UltisnipExpand"
        "     endif
        "     return "\<Plug>UltisnipList"
        " endfunction
        " imap <expr> <M-'> ExpandOrList()
        imap <M-'> <Plug>UltisnipExpand
        " visual expand
        xmap <M-'> <Plug>UltisnipExpand
        imap <M-"> <Plug>UltisnipList
        let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
        let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
        let g:UltiSnipsEditSplit = "horizontal"
        let g:UltiSnipsEnableSnipMate = 0
        " nvim have a different location, so set it
        let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
        " load two version of python spend a lot of time
        let g:UltiSnipsUsePythonVersion = 3
        Plug 'SirVer/ultisnips', {'on': []}

        " Optional:
        Plug 'honza/vim-snippets'
        let g:ultisnips_python_style = 'jedi'

        com! UltiTmpSnippet call UltiSnips#AddFiletypes("tmp") | UltiSnipsEdit tmp
        nnoremap <Leader>eS :UltiTmpSnippet<CR>
        nnoremap <Leader>es :UltiSnipsEdit<CR>

        " preview auto stop snippet. so disable it
        autocmd mine User UltiSnipsEnterFirstSnippet set completeopt-=preview
        autocmd mine User UltiSnipsExitLastSnippet   set completeopt+=preview
        " }}}

        " tpope/vim-surround "{{{
        let g:surround_no_insert_mappings = 1
        let g:surround_indent = 0
        Plug 'tpope/vim-surround'
        xnoremap S s
        xmap s <Plug>VSurround
        xmap gs <Plug>VgSurround
        "}}}

        " tpope/vim-unimpaired"{{{
        Plug 'tpope/vim-unimpaired' " custom
        nmap co yo
        nnoremap yoD :<C-R>=&diff ? 'windo diffoff' : 'windo diffthis'<CR><CR>
        nnoremap [oD :windo diffthis<CR>
        nnoremap ]oD :windo diffoff<CR>
        nnoremap yoe :set ei=<C-R>=(&ei ==# '')? "all" : ""<CR><CR>
        nnoremap [oe :set ei=all<CR>
        nnoremap ]oe :set ei=<CR>
        "}}}

        " tpope/vim-repeat"{{{
        Plug 'tpope/vim-repeat'
        "}}}

        " tpope/fugitive {{{
        Plug 'tpope/vim-fugitive'
        Plug 'tpope/vim-rhubarb'
        " re setf git to enable fugitive map, fugitive#detect need a path to detect
        autocmd mine VimEnter * if expand('<amatch>')=='' && &filetype=='git' |
                    \ call fugitive#detect(getcwd()) | setf git |
                    \ endif
        " 反应太慢了, 主要也就是把status window和diff合并了。
        " Plug 'jreybert/vimagit'
        " }}}
        " tpope/vim-dispatch {{{
        Plug 'tpope/vim-dispatch'
        let g:dispatch_no_maps = 1
        " }}}
        " tpope/vim-projectionist{{{
        Plug 'tpope/vim-projectionist'
        "}}}

        " Yggdroot/LeaderF {{{
        " let g:Lf_CacheDirectory = "/tmp/LeaderF"
        " " let g:Lf_WindowPosition = "top"
        " let g:Lf_PreviewResult = {
        "     'Line': 1,
        " }
        " let g:Lf_ShortcutB = "<Leader>bb"
        " let g:Lf_ShortcutF = "<Leader>ff"
        " let g:Lf_CommandMap = {'<Down>': ['<Down>', '<M-j>', '∆'], '<Up>': ['<Up>', '<M-k>', '˚']}
        " Plug 'Yggdroot/LeaderF'
        " Plug 'Yggdroot/LeaderF-marks'
        " }}}

        " junegunn/gv.vim {{{
        Plug 'junegunn/gv.vim', {'on': 'GV'}
        " }}}

        " junegunn/vim-easy-align {{{
        Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
        xmap <cr> <Plug>(EasyAlign)
        nmap ga   <Plug>(EasyAlign)
        " }}}

        " junegunn/fzf.vim {{{
        " 易用性上还差一节, 而且需要集成到term里面..
        " ctrlp的自动定位git很有用.  unite的方便性比它好..
        " fzf 性能上有些优势.

        let g:fzf_launcher='~/.vim/bin/fzfIterm.js %s'
        let g:fzf_history_dir='~/.vim/bundle/fzf.vim/.history'
        let g:fzf_command_prefix = 'FZ'
        let $FZF_DEFAULT_OPTS=' --bind="'.join([
        \    'alt-j:down,alt-k:up',
        \    'alt-h:backward-char,alt-l:forward-char',
        \    'alt-a:select-all,alt-d:deselect-all',
        \    'alt-space:jump,`:jump-accept',
        \], ',') . '" --color="pointer:15" --exact'
        " let g:fzf_layout = { 'up' : '~40%'  }
        Plug '/usr/local/opt/fzf'
        Plug 'junegunn/fzf.vim'

        command! -bang -nargs=* FZRg
                    \ call fzf#vim#grep(
                    \   'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
                    \   <bang>0 ? fzf#vim#with_preview('up:60%')
                    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                    \   <bang>0)

        " function! MarksToLocation(line)
        "     " 运行时本地的buffer文件已经变了，不太好获取啊
        "     return a:line
        "     " let pos = getpos("'".matchstr(line, '\S'))
        "     redir => cout
        "     silent marks
        "     redir END
        "     return l:cout
        " endfunction
        " command! -bar -bang FZMarks call fzf#vim#marks(
        "             \ {'options': ['--preview-window', 'right:50%', '--preview', printf('v={}; echo "$(~/.vim/bin/evalInVim.sh "%s" "MarksToLocation(''""${v//\''/''''}""'')" )"', v:servername)]},
        "             \ <bang>0)
        " "}}}

        " junegunn/goyo.vim {{{
        Plug 'junegunn/goyo.vim'
        " }}}

        " junegunn/vim-slash {{{
        Plug 'junegunn/vim-slash'
        " nvim slash effect is awkward...
        if has('timers') && !has('nvim')
            nmap <expr> <plug>(slash-after) "\<Plug>SearchIndex" . slash#blink(2, 50)
        else
            nmap <expr> <plug>(slash-after) "\<Plug>SearchIndex"
        endif
        " }}}
        " google/vim-searchindex{{{
        " 不支持visual star, 配合vim-slash一起用
        Plug 'google/vim-searchindex'
        let g:searchindex_line_limit = 20000
        "}}}

        " kshenoy/vim-signature"{{{
        let g:SignaturePeriodicRefresh = 0
        "let g:SignatureEnabledAtStartup = 0
        let g:SignatureUnconditionallyRecycleMarks = 1
        Plug 'kshenoy/vim-signature'
        "}}}

        " restore_view {{{
        Plug 'vim-scripts/restore_view.vim'
        set viewoptions=folds,cursor
        let g:skipview_files = ['.*\.vim']
        " }}}

        " dash {{{
        " Plug 'rizzatti/dash.vim', {'on': '<Plug>DashSearch'}
        " nmap <LocalLeader>K <Plug>DashSearch
        " let g:dash_map = {
        "     \ 'objc':   ['ios', 'c', 'manpages'],
        "     \ 'objcpp': ['ios', 'cpp', 'c', 'manpages'],
        "     \ 'lua':    ['lua','cocos2dx']
        "     \}
        " }}}
        " devio {{{
        function! DevioSearch(filetype, keyword)
            if a:filetype == "swift" || a:filetype == "objc" || a:filetype == "objcpp"
                call system( printf("open -a Firefox 'https://developer.apple.com/search/?q=%s'", a:keyword) )
            elseif a:filetype == "racket"
                call system( printf("raco docs '%s'", a:keyword) )
            else
                call system( printf("open -a Firefox 'https://devdocs.io/#q=%s%%20%s'", a:filetype, a:keyword) )
            endif
        endfunction
        nnoremap <LocalLeader>k :call DevioSearch(&ft, '<C-R><C-W>')<CR>
        vnoremap <LocalLeader>k :call DevioSearch(&ft, '<C-R>=GetVisualString()<CR>')<CR>
        map <LocalLeader>K <LocalLeader>k
        " }}}

        " my plugin" {{{
        " Plug '~/.vim/bundle/vim-grepeditor'
        Plug 'SolaWing/vim-objc-syntax', {'for': ['objc', 'objcpp']},
        Plug 'SolaWing/quick-ultisnip'
        Plug 'SolaWing/WaitYank.vim'
        " <C-r><CR> has problem, may not recognized
        inoremap <C-r>$ <C-R>=quickUltiSnip#Insert()<CR>
        nnoremap <M-p> :call quickUltiSnip#Paste()<CR>
        vmap <M-y> <Plug>quickUltiSnipYankVisual
        nmap <M-Y> <Plug>quickUltiSnipYankLineWise
        nmap <M-y> <Plug>quickUltiSnipYankOperator
        inoremap <expr> <M-y>  WaitYank#Paste()
        inoremap <expr> <C-R>? WaitYank#Paste()
        " }}}

        " " lldb-plugin {{{
        " Plugin 'gilligan/vim-lldb'
        " " }}}

        " jiangmiao/auto-pair {{{
        let g:AutoPairsShortcutBackInsert = ""
        let g:AutoPairsFlyMode = 0
        let g:AutoPairsShortcutToggle = ""
        let g:AutoPairsMoveCharacter = ""
        let g:ycm_key_param_template = 0
        " let g:AutoPairs = {'`': '`', '"': '"', '{': '}', '''': '''', '(': ')', '[': ']', '"""': '"""'}

        " compatibility between YCM and autopair, and none-buffer map make VM-Cursor map happy
        let g:AutoPairsMapBS = 0
        let g:AutoPairsMapCh = 0
        function! FixMapCh()
          if pumvisible()
              return "\<Plug>YCM_BS"
          elseif exists('b:autopairs_enabled')
              return "\<C-R>=AutoPairsDelete()\<CR>"
          else
              return "\<BS>"
          endif
        endfunction
        imap <silent> <expr> <BS> FixMapCh()
        imap <C-H> <BS>

        let g:AutoPairsMapCR = 0
        function! FixMapCR()
            if pumvisible()
                return youcompleteme#OnCompleteAction("\<CR>")
            endif
            return "\<CR>\<C-R>=AutoPairsReturn()\<CR>"
        endfunction
        inoremap <silent><expr> <CR> FixMapCR()

        Plug 'jiangmiao/auto-pairs'
        " }}}

        " scrooloose/nerdtree {{{
            " let g:NERDTreeBookmarksFile = $HOME . "/.vim/bundle/nerdtree/.NERDTreeBookmarks"
            " " let g:NERDTreeShowLineNumbers = 1
            " let g:NERDTreeCascadeSingleChildDir=1
            " let g:NERDTreeMapOpenSplit = 's'
            " let g:NERDTreeMapOpenVSplit = 'v'
            " let g:NERDTreeWinSize = 51
            " " disable netrw
            " let g:loaded_netrwPlugin = 1
            " Plug 'scrooloose/nerdtree', {'on':[ 'NERDTreeToggle', 'NERDTreeFind' ]}
            " augroup nerd_loader
            "     autocmd!
            "     autocmd VimEnter * silent! autocmd! FileExplorer
            "     autocmd BufEnter,BufNew *
            "                 \  if isdirectory(expand('<amatch>'))
            "                 \|   call plug#load('nerdtree')
            "                 \|   execute 'autocmd! nerd_loader'
            "                 \| endif
            " augroup END
            " nnoremap <F2> :let g:NERDTreeQuitOnOpen = 0 <bar> NERDTreeToggle<CR>
            " nnoremap <S-F2> :let g:NERDTreeQuitOnOpen = 1 <bar> NERDTreeFind<CR>
            " nmap <F14> <S-F2>
            " nmap <Leader><F2> <S-F2>
        " }}}
        " justinmk/vim-dirvish {{{
        let g:loaded_netrwPlugin = 1
        command! -nargs=? -complete=dir Explore Dirvish <args>
        command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
        command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
        Plug 'justinmk/vim-dirvish'
        "}}}

        " w0rp/ale async lint engine{{{
        let g:ale_lint_delay = 5000
        let g:ale_lint_on_text_changed = 0
        let g:ale_lint_on_save = 1
        let g:ale_lint_on_enter = 0
        let g:ale_set_highlights = 1
        let g:ale_linters_explicit = 1
        let g:ale_linters = {
                    \ 'javascript' :[ 'eslint' ],
                    \ 'swift' : ['swiftlint'],
                    \ 'php': ['php'],
                    \ 'python': ['flake8']
                    \ }
        let g:ale_fixers = {
                    \ 'javascript': ['remove_trailing_lines', 'trim_whitespace', 'eslint'],
                    \ 'python': ['yapf']
                    \}
        " let g:ale_completion_enabled = 1
        " let g:ycm_filetype_specific_completion_to_disable = {
        "             \ 'rust': 1
        "             \}
        Plug 'w0rp/ale'
        " }}}

        " tpope/vim-commentary{{{
        Plug 'tpope/vim-commentary'
        " }}}

        " mileszs/ack.vim"{{{
        let g:ackhighlight = 1
        " let g:ackprg = 'ag --vimgrep'
        let g:ackprg = 'rg --vimgrep --smart-case -g "!*.xcodeproj"'
        " let g:ack_apply_qmappings = 0
        " let g:ack_apply_lmappings = 0
        " this seems to only set fcl = all, will affect other buffer
        " let g:ack_autofold_results = 1

        " Plug 'mhinz/vim-grepper'
        Plug 'mileszs/ack.vim', { 'on': 'Ack'}
        " Plug 'dyng/ctrlsf.vim'


        "}}}

        " ludovicchabant/vim-gutentags {{{
        " let g:gutentags_add_default_project_roots = 0
        " let g:gutentags_project_root = ['.git']
        " " let g:gutentags_ctags_auto_set_tags = 0
        " " let g:gutentags_generate_on_missing = 0
        " let g:gutentags_generate_on_new = 0
        " let g:gutentags_init_user_func = 'GutentTagsCanEnable'
        " let g:gutentags_trace = 1
        " function! GutentTagsCanEnable(file)
        "     let gutentags_root = gutentags#get_project_root( fnamemodify(a:file, ':p:h') )
        "     return filereadable(gutentags_root . '/tags')
        " endfunction
        " Plug 'ludovicchabant/vim-gutentags'
        "}}}

        " mbbill/undotree "{{{
        Plug 'mbbill/undotree' ",             { 'on': 'UndotreeToggle'   }
        nnoremap <F4> :UndotreeToggle<CR>
        "}}}

        " kana/vim-submode"{{{
        let g:submode_timeout = 0
        let g:submode_keep_leaving_key = 1
        Plug 'kana/vim-submode' " custom
        autocmd mine VimEnter * call timer_start(200, {-> s:submode_init() })
    function! s:submode_init()
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
        call SubmodeMap('Diff(nNwpou)', 'n',
                    \ [['[c', 'N', '[c', '']
                    \ ,[']c', 'n', ']c', '']
                    \ ,['', 'w', '<C-W>w', '']
                    \ ,['', 'p', 'dp', '']
                    \ ,['', 'o', 'do', '']
                    \ ,['', 'u', 'u', '']
                    \ ,['', '<C-r>', '<C-r>', ''] ])
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
                    \ ,['<C-W><C-W>', '<C-W>', '<C-W>w',  '']
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
                    \ ,['',           'q',     '<C-W>q',  '']
                    \ ,['',           'c',     '<C-W>c',  '']
                    \ ,['',           'o',     '<C-W>o',  '']
                    \ ,['',           'f',     '<C-F>',   '']
                    \ ,['',           'b',     '<C-B>',   '']
                    \ ,['',           'd',     '<C-D>',   '']
                    \ ,['',           'u',     '<C-U>',   '']
                    \ ])
    endfunction
        "}}}
        " https://github.com/mg979/vim-visual-multi
        " if has('nvim')
            Plug 'mg979/vim-visual-multi'
            " <M-Down> not work in terminal...
            let g:VM_maps = {
                        \ 'Toggle Mappings': '<Space>',
                        \ 'Select Operator': '',
                        \ 'Add Cursor Down': '<M-Down>',
                        \ 'Add Cursor Up':   '<M-Up>',
                        \ 'Select All':      '<M-*>',
                        \ 'Visual All':      '<M-*>',
                        \ 'Visual Find':     '<M-F>',
                        \ }
            let g:VM_Mono_Cursor_hl = 'StatusLine'
            let g:VM_Ins_Mode_hl = 'Underlined'
            nmap  z]         <Plug>(VM-Find-Under)
            xmap  z]         <Plug>(VM-Find-Subword-Under)
        " endif
        "
        "" terryma/vim-multiple-cursors "{{{
        " if has('gui_macvim')
        " Plug 'terryma/vim-multiple-cursors'
        " "" integrate with other plugin
        " function! Multiple_cursors_before()
        "     let g:ycm_auto_trigger = 0
        " endfunction

        " function! Multiple_cursors_after()
        "     let g:ycm_auto_trigger = 1
        " endfunction
        " end
        ""}}}
        " terryma/vim-expand-region {{{
        Plug 'terryma/vim-expand-region'
        " }}}

        " jpalardy/vim-slime "{{{
        let g:slime_no_mappings = 1
        " if has('nvim')
        "     let g:slime_target = "neovim"
        " elseif v:version >= 801
        "     let g:slime_target = "vimterminal"
        " else
            let g:slime_target = "tmux"
        " endif
        let g:slime_paste_file = tempname()
        " pandas not support cpaste..
        let g:slime_python_ipython = 1
        Plug 'jpalardy/vim-slime', {'on': ['<Plug>SlimeLineSend', '<Plug>SlimeRegionSend']}
        "}}}
        " kassio/neoterm{{{
        " 能满足基本需要，不过窗口管理还需要进一步加强，比如重用时看不到。新建时不自动进去等等。
        " let g:neoterm_shell = 'fish'
        " let g:neoterm_default_mod = 'botright'
        " Plug 'kassio/neoterm'
        "}}}

        " -- nathanaelkane/vim-indent-guides"{{{
        " more distract than useful
        Plug 'nathanaelkane/vim-indent-guides', {'on': 'IndentGuidesToggle'}
        let g:indent_guides_guide_size = 1
        let g:indent_guides_start_level = 2
        nnoremap yog :IndentGuidesToggle<CR>
        ""}}}
        "}}}
        " ==================== Language"{{{
        " hynek/vim-python-pep8-indent"{{{
        Plug 'hynek/vim-python-pep8-indent'
        "}}}

        " itchyny/lightline.vim {{{
        autocmd mine BufEnter,FileChangedShellPost * call CacheClear("fugitive#head")
        function! CachedFugitiveHead()
            return CacheWrap("fugitive#head")
        endfunction
        let g:lightline = {
                    \   'colorscheme' : 'base16_solarized_custom',
                    \   'active': {
                    \     'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ], [ 'gitbranch' ] ],
                    \     'right': [ [ 'percent' ],
                    \                [ 'lineinfo' ],
                    \                ['linter_errors', 'linter_warnings',
                    \                 'fileformat', 'fileencoding', 'filetype' ] ]
                    \   },
                    \   'inactive': {
                    \     'left': [ [ 'filename', 'modified' ] ],
                    \     'right': [ [ 'percent' ], [ 'lineinfo' ] ]
                    \   },
                    \   'component_function': {
                    \     'gitbranch': 'CachedFugitiveHead',
                    \   },
                    \   'component_expand': {
                    \     'linter_warnings': 'LightlineLinterWarnings',
                    \     'linter_errors':   'LightlineLinterErrors',
                    \   },
                    \   'component_type': {
                    \     'linter_warnings': 'warning',
                    \     'linter_errors':   'error',
                    \   },
                    \ }
        Plug 'itchyny/lightline.vim'

        function! LightlineLinterWarnings() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            let l:all_non_errors = l:counts.total - l:all_errors
            return l:all_non_errors == 0 ? '' : printf('W%d', all_non_errors)
        endfunction

        function! LightlineLinterErrors() abort
            let l:counts = ale#statusline#Count(bufnr(''))
            let l:all_errors = l:counts.error + l:counts.style_error
            " let l:all_non_errors = l:counts.total - l:all_errors
            return l:all_errors == 0 ? '' : printf('E%d', all_errors)
        endfunction

        autocmd mine User ALELint call lightline#update()
        " }}}

        " kchmck/vim-coffee-script"{{{
        " Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
        "}}}

        "cespare/vim-toml "{{{
        Plug 'cespare/vim-toml'
        "}}}"

        " keith/swift.vim "{{{
        Plug 'keith/swift.vim', {'for': 'swift'}
        " 现在支持还不够好. 以后真的需要再说吧. 暂时用xcode开发swift
        " Plug '~/.vim/bundle/sourcekittendaemon.vim', {'for': 'swift'}
        " Plug 'mitsuse/autocomplete-swift', {'for': 'swift'}
        "}}}

        " rhysd/vim-clang-format "{{{
        Plug 'kana/vim-operator-user'
        let g:clang_format#detect_style_file = 1 " use .clang-format
        Plug 'rhysd/vim-clang-format', {'on': ['<Plug>(operator-clang-format)']}
        " fix lazy load not not consider default range
        command! -range=% -nargs=0 ClangFormat call plug#load('vim-clang-format') | call clang_format#replace(<line1>, <line2>)
        "}}}

        " octol/vim-cpp-enhanced-highlight"{{{
        Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
        ""}}}

        " rust-lang/rust.vim"{{{
        Plug 'rust-lang/rust.vim', {'for': 'rust'}
        let $RUST_SRC_PATH = g:ycm_rust_src_path
        "}}}

        " " racer-rust/vim-racer"{{{
        " let g:racer_insert_paren = 0
        " let g:racer_experimental_completer = 1
        " let g:racer_no_default_keymappings = 1 " this option use custom mapping in filetype
        " " let g:racer_cmd = $HOME."/.cargo/bin/racer"
        " Plug 'racer-rust/vim-racer', {'for': 'rust'}
        " "}}}

        " dag/vim-fish"{{{
        " slow, better than None
        Plug 'dag/vim-fish', {'for': 'fish'}
        ""}}}

        " vim-ruby/vim-ruby{{{
        " let g:rubycomplete_buffer_loading = 1
        " let g:rubycomplete_classes_in_global = 1
        " let g:rubycomplete_load_gemfile = 1
        Plug 'vim-ruby/vim-ruby', {'for': 'ruby'}
        Plug 'tpope/vim-rake', {'for': 'ruby'}
        Plug 'tpope/vim-bundler', {'for': 'ruby'}
        "}}}

        " plasticboy/vim-markdown "{{{
        " 体验不够好
        Plug 'godlygeek/tabular', {'for': 'markdown'}
        Plug 'plasticboy/vim-markdown'
        " Plug 'euclio/vim-markdown-composer'
        " Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
        let g:vim_markdown_math = 1
        let g:vim_markdown_folding_style_pythonic = 1
        " fix ]c conflict with diff
        map ]h <Plug>Markdown_MoveToCurHeader
        " let g:vim_markdown_new_list_item_indent = 2
        " Plug 'vim-pandoc/vim-pandoc'
        "}}}

        " chriskempson/base16-vim "{{{ color scheme(After Tomorrow)
        Plug 'chriskempson/base16-vim' " custom
        "}}}


        " wannesm/wmgraphviz.vim  {{{
        let g:WMGraphviz_output = 'png'
        Plug 'wannesm/wmgraphviz.vim', {'for': 'dot'}
        "}}}
        " plantuml{{{
        Plug 'aklt/plantuml-syntax'
        "}}}


        " lisp test{{{
        " 和racket兼容不太好用，各种错误和路径问题。出错时还容易卡. 也没命令行交互模式的功能全
        " 现在slimv只有scheme filetype才启动...
        Plug 'kovisoft/slimv',               {'for': ['racket', 'scheme']}
        " 这个服务器目前只能先有了前缀才能过滤，不然内容太多了。
        let g:slimv_swank_cmd = '!tmux new -d -n REPL-Racket "racket ~/.vim/bin/swank-racket/server.rkt"'
        let g:slimv_unmap_cr = 1
        " prefer vim edit functions
        let g:paredit_mode = 0
        let g:paredit_disable_scheme = 1
        " Plug 'MicahElliott/vrod',                          {'for': ['racket', 'scheme']}
        Plug 'wlangstroth/vim-racket',                     {'for': ['racket', 'scheme']}
        " 我看着不明显，而且需要显示启用, 不支持单独启用
        " Plug 'kien/rainbow_parentheses.vim',               {'for': ['racket', 'scheme']}
        Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': ['racket', 'scheme']}
        Plug 'guns/vim-sexp',                              {'for': ['racket', 'scheme']}
        let g:sexp_enable_insert_mode_mappings = 0
        " }}}
        "}}}
  "}}}

    call plug#end()
    " filetype plugin indent on     " required
