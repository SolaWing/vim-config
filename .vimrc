""" vim: set sw=4 ts=4 sts=4 et foldlevel=1 foldmethod=marker:
"{{{
    " functions {{{
       function! ForwordDeleteWordInCmd()
           let cmdtext = getcmdline()
           let cmdtext = substitute(cmdtext, '\%'.getcmdpos().'c.\s*\w*', '',"")
           return cmdtext
       endfunction

       function! SearchCharInCmd(isForward, stopAfter, charCount) " like f in normal mode
           let cmdtext = getcmdline()
           let pos = getcmdpos() " 1 base pos

           " get input char
           let chars = ""
           let c = 0
           while c < a:charCount
               echo ":".cmdtext . " | input ".(a:isForward?"forward":"backward")." char: ".chars
               let char = getchar()
               if type(char) == type(0)
                   let char = nr2char(char)
               endif

               if char ==# "\r" || char ==# "\n"
                   break
               endif

               let chars .= char

               let c += 1
           endwhile

           if c == 0 " invalid input char
               return cmdtext
           endif
           " search and jump pos
           if a:isForward
               " if stopAfter, can match current, and move after current
               " else, search after current pos
               let pos = pos - a:stopAfter
               let topos = stridx(cmdtext, chars, pos) " 0 base pos
           else
               " if stopAfter, match previous char won't move, need to search furthor
               " else can match previous char
               let pos = pos-2- a:stopAfter * c
               let topos = strridx(cmdtext, chars, pos) " 0 base pos, will match at pos
           endif
           " echom cmdtext "|" char pos topos a:isForward
           if topos != -1
               call setcmdpos(topos+1+ a:stopAfter * c)
           endif
           return cmdtext
       endfunction

       function! GetVisualString()
           let old_reg = getreg('"')
           let old_regtype = getregtype('"')
           normal! gvy
           let ret = @@
           call setreg('"',old_reg, old_regtype)
           return ret
       endfunction

       function! SurroundSpaceBetweenPairs(start, end) range
           exe printf('%d,%ds/\(%s\)\ze\S/\1 /ge', a:firstline, a:lastline, a:start)
           exe printf('%d,%ds/\S\zs\(%s\)/ \1/ge', a:firstline, a:lastline, a:end)
       endfunction

       function! ToggleCamelOrUnderline(str)
           let l:ret = substitute(a:str, "_\\(\\a\\)", "\\u\\1", "g")
           if ret ==# a:str
               let l:ret = substitute(a:str, "\\l\\zs\\u", "_\\l\\0", "g")
           endif
           return l:ret
       endfunction
    " }}}
    """"""" 基本不会动的全局设定 {{{

        " set a map leader
        let mapleader = ","
        " use bash shell
        let g:is_bash = 1
        if has("gui_macvim")
            let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/3.5"
            set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.5/lib/libpython3.5m.dylib
            " py3 dir
        else " terminal
            " colorscheme solarized
            autocmd FocusGained * checktime
        endif

        " python version
        if has('python3')
            let g:usepy = 3
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
            PY << EOF
import sys,os; sys.path.insert(0,os.path.expanduser('~/.vim/python')); u = {}
EOF
        endif
        source ~/.vim/bundles.vim " plugins

        colorscheme base16-solarized-custom
        "显示行号
        set number
        "显示相对行号
        set relativenumber
        "右下角显示位置
        set ruler
        "在Vim窗口右下角显示未完成的命令
        set showcmd
        " history
        set history=1000
        " save swap file at specified dir
        set directory=~/.vim/swapfiles/,/var/tmp,/tmp
        " 启用鼠标
        if has('mouse')
          set mouse=a
        endif
        "设置语法高亮
        if &t_Co > 2 || has("gui_running")
        syntax on
        endif
        "打开搜索高亮
        set hlsearch
        "在查找时输入字符过程中就高亮显示匹配点。然后回车跳到该匹配点。
        set incsearch
        "设置查找到文件尾部后折返开头或查找到开头后折返尾部。
        set wrapscan
        " minimum lines to keep above and below cursor
        set scrolloff=3
        set sidescroll=5
        " fileencodings
        set fileencodings=ucs-bom,utf-8,default,gbk,latin1
        " showmatch
        set showmatch
        " virtualedit, add onemore for more consistency
        set virtualedit=block,onemore
        " auto read when file change outside.
        set autoread
        " not save options and mapping when mksession.
        set sessionoptions-=options
        " term italic
        set t_ZH=[3m
        set t_ZR=[23m
        set lazyredraw
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
        " indent use tab
        set expandtab
        " wrap text
        set nowrap
        " line break
        set linebreak
        " smart ignorecase
        set ignorecase smartcase
        set wildignorecase
        " set fold method
        set foldmethod=manual
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
        set switchbuf=usetab
        " ignore file pattern
        set wildignore+=*.obj,*.o,*.a,*.dylib,*.app,*.pyc
        set textwidth=80
        set colorcolumn=+1
        "highlight trim whitespace
        hi link TrimWhiteSpace CursorLine
        augroup TrimWhiteSpace
            au ColorScheme * hi! link TrimWhiteSpace CursorLine
            au Syntax * syn match TrimWhiteSpace /\s\+$/ display oneline containedin=ALLBUT,TrimWhiteSpace
        augroup END

        " get outer clipboard into unnameregister, but yank not into clipboard, unless specify explicitily
        autocmd FocusGained * let @" = @*
    "}}}

    """"""""""" command {{{
    command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
    command! -nargs=? -complete=dir Terminal silent exe printf( "!open -a /Applications/Utilities/Terminal.app %s" , <q-args>=='' ? getcwd() : expand(<q-args>) )
    command! -nargs=? -complete=dir ITerm silent exe printf( "!open -a /Applications/iTerm.app %s" , <q-args>=='' ? getcwd() : expand(<q-args>) )
    command! DiffOn windo diffthis
    command! DiffOff windo diffoff
    command! Hitest runtime syntax/hitest.vim
    command! Colortest sp $VIMRUNTIME/syntax/colortest.vim|so %
    command! -nargs=? Scratch new +set\ bt=nowrite <args>
    command! -range=% TrimWhiteSpace <line1>,<line2>s/\m\s\+$//e
    command! -range=% TrimMultiEmptyLine silent <line1>,<line2>g/^\s*\n\s*\n\s*\n/d
    "}}}

    """"""""""""""""""""""""""
    " map  i_ctrl-v <char> 输入原字符
    """"""""""""""""""""""""""
    source ~/.vim/key-binding.vim
"}}}
