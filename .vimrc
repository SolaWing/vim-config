""" vim: set sw=4 ts=4 sts=4 et foldlevel=1 foldmethod=marker:
"{{{
    """"""" 基本不会动的全局设定 {{{
        " create mine group, so can be used directly
        augroup mine | augroup end

        " set a map leader
        let mapleader = "\<Space>"
        let maplocalleader = ","
        " use bash shell
        let g:is_bash = 1
        unlet $MANPAGER
        if has("gui_macvim")
            set macmeta
            set pythonthreehome=/usr/local/Frameworks/Python.framework/Versions/Current
            set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/Current/lib/libpython3.9.dylib
            set rubydll=/Users/wang/.rbenv/versions/2.7.1/lib/libruby.dylib
            " py3 dir
        else " terminal
            " colorscheme solarized
            autocmd mine FocusGained * silent! checktime
        endif

        " python version
        if has('python3')
            let g:usepy = 3
            set pyxversion=3
        elseif has('python')
            let g:usepy = ""
        endif
        if exists('g:usepy')
            " selected python cmd
            command! -nargs=1 -range PY exe "<line1>,<line2>py".g:usepy <q-args>
            command! -nargs=1 -range=% PYDO exe "<line1>,<line2>py".g:usepy."do" <q-args>
            command! -nargs=1 -range PYFILE exe "<line1>,<line2>py".g:usepy."file" <q-args>
            function! PYEVAL(expr)
                return function(printf('py%seval', g:usepy))(a:expr)
            endfunction
            " python default locale is None. should set it. LC_TIME used by strftime. now use commandline date
            " PY u = {}; # import locale; locale.setlocale(locale.LC_TIME, '')
            " if has('nvim')
            "     " according to https://github.com/neovim/neovim/issues/7063#issuecomment-340590539
            "     " vim.api.eval is twice fast as vim.eval by not coercing number to string.
            "     " 不要过早优化，打破了兼容性
            "     PY import vim; vim.eval = vim.api.eval
            " endif
        endif

        command! -nargs=1 KeepCursor call KeepCursor(<q-args>)
        " NOTE: space before | matters. or will have a additional <space>
        command! -nargs=1 -complete=mapping -bar Map nmap <args>| xmap <args>| omap <args>
        command! -nargs=1 -complete=mapping -bar Noremap nnoremap <args>| xnoremap <args>| onoremap <args>
        
        source ~/.vim/functions.vim
        source ~/.vim/bundle-config/index.vim " plugins

        if 0 && has('nvim-0.10')
            colorscheme gruvbox-material
        else
            colorscheme gruvbox
        endif
        "显示行号
        set nonumber
        "显示相对行号
        set norelativenumber
        "右下角显示位置
        set ruler
        "在Vim窗口右下角显示未完成的命令
        set showcmd
        " history
        set history=10000
        " save swap file at specified dir
        set directory=$HOME/.vim/swapfiles//,/var/tmp//,/tmp//
        " 启用鼠标
        if has('mouse')
          set mouse=a
        endif
        "打开搜索高亮
        set hlsearch
        "在查找时输入字符过程中就高亮显示匹配点。然后回车跳到该匹配点。
        set incsearch
        "设置查找到文件尾部后折返开头或查找到开头后折返尾部。
        set wrapscan
        " minimum lines to keep above and below cursor
        set scrolloff=1
        set sidescroll=5
        " fileencodings
        setg fileencoding=utf-8
        set fileencodings=ucs-bom,utf-8,gbk,default,latin1
        " showmatch
        set showmatch
        " virtualedit, add onemore for more consistency
        set virtualedit=block,onemore
        " auto read when file change outside.
        set autoread
        " not save options and mapping when mksession.
        set sessionoptions-=options
        set jumpoptions=stack
        " term italic
        set t_ZH=[3m
        set t_ZR=[23m
        set lazyredraw

        if has('nvim')
            set undofile undodir=~/.vim/nvim-undodir
        else
            set undofile undodir=~/.vim/undodir
        end
        autocmd mine BufWritePre *.{log,json,csv} setlocal noundofile
    "}}}

    " formatter {{{
        " 哪些可以自动换到行首或行尾
        set whichwrap=b,s,<,>,[,]
        "tab stop
        set tabstop=8
        set softtabstop=4
        "indent width
        set sw=4
        " autoindent
        set smartindent
        set autoindent
        " indent only use space, close it in specified filetype
        set expandtab
        " wrap text
        set nowrap
        " line break
        set linebreak
        " smart ignorecase
        set ignorecase smartcase
        set wildignorecase
        " set fold method
        set foldmethod=indent
        set foldlevel=100
        set foldcolumn=1
        " no auto resize
        set noequalalways
        " min line
        set winminheight=0
        set winminwidth=0
        " backspace
        set backspace=indent,eol,start
        set formatoptions+=j " remove comment char when join
        set formatoptions-=t " don't auto wrap text when beyond textwidth
        " list unvisible char in list option on
        set listchars=trail:·,tab:>-
    "}}}

    " other setting {{{
        " vertical split to right
        set splitright
        " if show status bar
        set laststatus=2
        " commandLine 选择提示
        set wildmenu
        " commandLine 可输入字符过滤补全
        set wildmode=list:longest,full
        " 使得补全从第三状态开始(不补全,但可以输入字符过滤)
        set completeopt+=longest
        " set tags file format
        set tags+=.tags
        " 设置path使得find可以查找子文件夹
        ""set path+=**
        " 取消掉include file completion
        " because find the file in path will cost lot of time
        set complete-=i
        " grepprg
        " set grepprg=grep\ -nI\ $*\ --exclude-dir=.*\ /dev/null
        set grepprg=rg\ --vimgrep
        " switchbuf, jump to exist or open new tab
        set switchbuf=uselast
        " ignore file pattern
        set wildignore+=*.obj,*.o,*.a,*.dylib,*.app,*.pyc
        set textwidth=100 " allow to a vertical split
        set colorcolumn=+1 " highlight a textwidth tip
        set cursorline
        let diff_translations = v:false " diff 高亮里大量的translation匹配很慢, 也没必要
        "highlight trim whitespace
        hi link TrimWhiteSpace CursorLine
        augroup TrimWhiteSpace
            au ColorScheme * hi! link TrimWhiteSpace CursorLine
            au Syntax * syn match TrimWhiteSpace /\s\+$/ display oneline containedin=ALLBUT,TrimWhiteSpace
        augroup END

        " get outer clipboard into unnameregister, but yank not into clipboard, unless specify explicitily
        " NOTE: let @" will change @0..
        " autocmd FocusGained * let @" = @*
    "}}}

    """"""""""" command {{{
    command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
    command! -nargs=? -complete=dir Terminal silent exe printf( "!open -a Terminal.app '%s'" , <q-args>=='' ? getcwd() : expand(<q-args>) )
    "command! -nargs=? -complete=dir OpenITerm silent exe printf( "!open -a /Applications/iTerm.app %s" , <q-args>=='' ? getcwd() : expand(<q-args>) )
    command! -nargs=? -complete=file OpenInXcode silent exec printf("!open -a xcode %s", expand( <q-args> == '' ? '%' : <q-args>))

    command! DiffOn windo diffthis
    command! DiffOff windo diffoff
    command! Hitest sp $VIMRUNTIME/syntax/hitest.vim | so %
    command! Colortest sp $VIMRUNTIME/syntax/colortest.vim|so %
    command! -nargs=? Scratch new +set\ buftype=nowrite <args>
    command! -range=% TrimWhiteSpace <line1>,<line2>s/\m\s\+$//e
    command! -range=% TrimMultiEmptyLine silent <line1>,<line2>g/^\s*\n\s*\n\s*\n/d
    command! -nargs=1 -complete=file Profile profile start <args> | profile func *

    " TODO: 封装一个好用的通用terminal接口
    " command! -nargs=1 -complete=shellcmd Terminal call term#open(<q-args>)
    "}}}

    """"""""""""""""""""""""""
    " map  i_ctrl-v <char> 输入原字符
    """"""""""""""""""""""""""
    source ~/.vim/key-binding.vim
"}}}
