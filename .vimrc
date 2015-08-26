""" vim: set sw=4 ts=4 sts=4 et foldlevel=1 foldmethod=marker:
"{{{
    " functions {{{
       function! ForwordDeleteWordInCmd()
           let cmdtext = getcmdline()
           let cmdtext = substitute(cmdtext, '\%'.getcmdpos().'c.\s*\w*', '',"")
           return cmdtext
       endfunction

       function! SearchCharInCmd(isForward, stopAfter) " like f in normal mode
           let cmdtext = getcmdline()
           let pos = getcmdpos()
           echo ":".cmdtext . " | input ".(a:isForward?"forward":"backward")." char: "
           let char = getchar()
           if type(char) == type(0)
               let char = nr2char(char)
           endif
           if a:isForward
               let pos = pos - a:stopAfter
               let topos = stridx(cmdtext, char, pos)
           else
               let pos = pos-2-a:stopAfter
               let topos = strridx(cmdtext, char, pos)
           endif
           " echom cmdtext "|" char pos topos a:isForward
           if topos != -1
               call setcmdpos(topos+1+a:stopAfter)
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
    " }}}
    """"""" 基本不会动的全局设定 {{{

        " set a map leader
        let mapleader = ","
        " use bash shell
        let g:is_bash = 1

        if !has("gui_running")
            colorscheme solarized
        endif

        if has('python')
            let g:usepy = ""
        elseif has('python3')
            let g:usepy = 3
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
        source ~/.vim/bundles.vim " vundle related

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
        set virtualedit=block
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
        set sw=2
        " autoindent
        set smartindent
        set autoindent
        " indent use tab
        set expandtab
        " wrap text
        " set wrap
        " line break
        set linebreak
        " smart ignorecase
        set ignorecase smartcase
        " set fold method
        set foldmethod=manual
        set foldlevel=100
        set foldcolumn=2
        " no auto resize
        set noequalalways
        " min line
        set winminheight=0
        " backspace
        set backspace=indent,eol,start
        " remove comment char when join
        set formatoptions+=j
        set formatoptions-=t
        " list unvisible char in list option on
        set listchars=trail:·,tab:>-
        " case statement in c indent style
        set cinoptions+=l1
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
        set grepprg=grep\ -nI\ $*\ --exclude-dir=.*\ /dev/null
        " switchbuf, jump to exist or open new tab
        set switchbuf=usetab
        " ignore file pattern
        set wildignore+=*.obj,*.o,*.a,*.dylib,*.app,*.pyc
        set textwidth=80
        set colorcolumn=+1
        "highlight trim whitespace
        hi TrimWhiteSpace ctermbg=cyan guibg=cyan
        augroup TrimWhiteSpace
            au ColorScheme * highlight TrimWhiteSpace ctermbg=cyan guibg=cyan
            au Syntax * syn match TrimWhiteSpace /\s\+$/ display oneline containedin=ALLBUT,TrimWhiteSpace
        augroup END
    "}}}

    """"""""""""""""""""""""""
    " map  i_ctrl-v <char> 输入原字符
    """"""""""""""""""""""""""

    """"""""" normal map {{{

        nnoremap Za :confirm qa<CR>
        nnoremap ZA :qa!<CR>
        nnoremap ZX :confirm xa<CR>
        " let islwin = 0
        " nnoremap <C-n>  :<C-R>=islwin?"l":"c"<CR>next<CR>
        " nnoremap <C-p>  :<C-R>=islwin?"l":"c"<CR>previous<CR>
        "z/ 取消搜索高亮
        nnoremap z/    :noh<CR>
        " <leader>j  showjumplistToEnd
        nnoremap <leader>j    :let b:prevmore=&more <bar> set nomore <bar>
                            \jumps <bar> let &more=b:prevmore<CR>
        " window convenience control
        " focus window
        nnoremap <C-J>    <C-W>j<C-W>_
        nnoremap <C-K>    <C-W>k<C-W>_
        nnoremap <C-H>    <C-W>h<C-W>_
        nnoremap <C-L>    <C-W>l<C-W>_
        nnoremap <C-=>    <C-W>=

        " map K use help and can back
        nnoremap <silent> K      :<C-r>=&keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s",expand('<cword>')) : printf("!%s %s <bar> less", &keywordprg, expand('<cword>')) <CR><CR>
        vnoremap <silent> K      <esc>:<C-r>=line("'<") == line("'>") ? &keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s", getline("'<")[col("'<")-1:col("'>")-1] ) : printf("!%s %s <bar> less", &keywordprg, getline("'<")[col("'<")-1:col("'>")-1]) : "norm! gv" <cr><CR><CR>

        " move line up or down
        nnoremap <M-J> :m .+1<CR>
        vnoremap <M-J> :m '>+1<CR>gv
        vnoremap <M-K> :m '<-2<CR>gv
        nnoremap <M-K> :m .-2<CR>
        " use F5 to open quick-fix list
        nnoremap <F5> :cwin<cr>
        nnoremap <S-F5> :lwin<cr>
        nmap <F17> <S-F5>
        nmap <Leader><F5> <S-F5>
        noremap <M-a> <C-\><C-N>ggVG
        noremap <M-c> "*y
        noremap <M-s> :<C-U>confirm w<CR>
        inoremap <M-s> <C-o>:<C-U>confirm w<CR>
        noremap <M-S> :<C-U>confirm wa<CR>
    "}}}

    """"""""""" visual map {{{
        " visual shifting (does not exit Visual mode)
        vnoremap < <gv
        vnoremap > >gv
    "}}}

    """"""""" insert map {{{
        " use alt + hjkl move cursor, alt + HL move to begin, end
        map! <M-h> <Left>
        map! <M-j> <Down>
        map! <M-k> <Up>
        map! <M-l> <Right>
        map! <M-H> <home>
        map! <M-L> <end>
        inoremap <C-F> <Right>
        inoremap <C-B> <Left>
        inoremap <C-A> <home>
        inoremap <C-E> <end>

        " alt + f b, word move
        map! <M-f> <S-Right>
        map! <M-b> <S-Left>
        map <M-H> <home>
        map <M-L> <end>
        noremap! <C-D> <Del>

        " alt + d, del word
        inoremap <M-d> <C-O>de
        cnoremap <M-d> <C-\>eForwordDeleteWordInCmd()<CR>
        cnoremap <C-L> <C-D>
        " insert visual mode
        inoremap <M-v> <C-O>v
        inoremap <M-V> <C-O>V
        inoremap <M-C-v> <C-O><C-v>
        " insert yank
        inoremap <M-y> <C-O>y
        inoremap <M-Y> <C-O>Y

        " ii,jf,fj,jk 退出插入模式
        " left hand have too many work. here use right hand
        inoremap jk <ESC>
        " inoremap ii <ESC>
        " inoremap jf <ESC>
        " inoremap fj <ESC>
        " cnoremap jf <C-c>
        " cnoremap fj <C-c>
        " :: 执行命令行
        " inoremap :: <C-O>:
        " jj <down> kk <up>
        " inoremap jj <Down>
        " inoremap kk <Up>

        " command+return 插入新行
        inoremap <D-CR> <End><CR>
        inoremap <S-CR> <End><CR>
        inoremap <D-S-CR> <C-O>^<CR><UP>
        " alt + oO
        inoremap <M-o> <C-O>o
        inoremap <M-O> <C-O>O
        " inoremap ` <C-O>  " 很少用
        " map some EX completion
        inoremap <C-]> <C-X><C-]>
        " inoremap <C-F> <C-X><C-F>
        " map tab to show completion

    "}}}

    """"""""""" command map {{{
        cnoremap <C-X><C-L> <C-L>
        cnoremap <C-X><C-A> <C-A>
        " use ctrl-A to move to begin, according to term
        cnoremap <C-A> <C-B>
        cnoremap <C-]> <C-\>eSearchCharInCmd(1,1)<CR>
        " ctrl-K kill line
        cnoremap <C-K> <C-\>egetcmdpos()==1?"":getcmdline()[:getcmdpos()-2]<CR>
        cnoremap <C-X><C-K> <C-K>
        " <M-]> to search backword
        cnoremap <M-]> <C-\>eSearchCharInCmd(0,0)<CR>
        " sudo
        cabbrev w!! w !sudo tee % >/dev/null
        " search occur
        " cnoremap <C-o> <CR>:lvim//j % <bar>lwin<CR>
    "}}}

    """"""""""" command {{{
        command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
        command! -nargs=? -complete=dir Terminal silent exe printf( "!open -a /Applications/Utilities/Terminal.app %s" , <q-args>=='' ? getcwd() : expand(<q-args>) )
        command! -nargs=? -complete=dir ITerm silent exe printf( "!open -a /Applications/iTerm.app %s" , <q-args>=='' ? getcwd() : expand(<q-args>) )
        command! DiffOn windo diffthis
        command! Hitest runtime syntax/hitest.vim
        command! Colortest sp $VIMRUNTIME/syntax/colortest.vim|so %
        command! -nargs=? Scratch new +set\ bt=nowrite <args>
        command! -range=% TrimWhiteSpace <line1>,<line2>s/\m\s\+$//e
        command! -range=% TrimMultiEmptyLine silent <line1>,<line2>g/^\s*\n\s*\n\s*\n/d
    "}}}

    " my-keybinding space category {{{
    " use a leader as group map. inspire by Spacemacs
    " in insert mode, leader is <M-m>
    " in other mode, leader is <Space>
    imap <M-m> <C-o><Space>
    """ tab keys "{{{
    " move to tab page
    nnoremap <Space>t1 1gt
    nnoremap <Space>t2 2gt
    nnoremap <Space>t3 3gt
    nnoremap <Space>t4 4gt
    nnoremap <Space>t5 5gt
    nnoremap <Space>t6 6gt
    nnoremap <Space>t7 7gt
    nnoremap <Space>t8 8gt
    nnoremap <Space>t9 9gt
    nnoremap <Space>t0 10gt
    nnoremap <M-1> 1gt
    nnoremap <M-2> 2gt
    nnoremap <M-3> 3gt
    nnoremap <M-4> 4gt
    nnoremap <M-5> 5gt
    nnoremap <M-6> 6gt
    nnoremap <M-7> 7gt
    nnoremap <M-8> 8gt
    nnoremap <M-9> 9gt
    nnoremap <M-0> 10gt
    " tabmove position
    nnoremap <Space>tl :<C-U>silent exe "tabm +". v:count1<CR>
    nnoremap <Space>tL :<C-U>silent tabm<CR>
    nnoremap <Space>th :<C-U>silent exe "tabm -". v:count1<CR>
    nnoremap <Space>tH :<C-U>silent tabm 0<CR>
    " new tab
    nnoremap <Space>ts <C-W>s<C-W>T
    nnoremap <Space>tn :<C-U>silent tabnew<CR>
    nnoremap <Space>te :<C-U>tabe<Space>
    nnoremap <Space>t] :<C-U>tab tag <C-R><C-W><CR>
    nnoremap <Space>tg] :<C-U>tab tjump <C-R><C-W><CR>
    nnoremap <Space>t} :<C-U>tab tjump /.*<C-R><C-W>.*<CR>
    vnoremap <Space>t] :<C-U>tab tag <C-R>=GetVisualString()<CR><CR>
    vnoremap <Space>tg] :<C-U>tab tjump <C-R>=GetVisualString()<CR><CR>
    " close tab
    nnoremap <Space>tc :<C-U>confirm tabclose<CR>
    nnoremap <Space>tC :<C-U>silent windo quit!<CR>
    nnoremap <Space>to :<C-U>confirm tabonly<CR>
    " tab do
    nnoremap <Space>t: :<C-U>tabdo<Space>
    "}}}
    """ windows"{{{
    nnoremap <C-W>e :<C-U>sp<Space>
    nnoremap <C-W>o :<C-U>confirm only<CR>
    nnoremap <C-W><C-O> :<C-U>confirm only<CR>
    "}}}
    """ project keys"{{{
    nnoremap <Space>pf :<C-U>CtrlP<CR>
    nnoremap <D-p> :<C-U>CtrlP<CR>
    nnoremap <Space>pr :<C-U>CtrlPMRUFiles<CR>
    nnoremap <Space>p/ :<C-U>Ack! <C-R><C-W>
    vnoremap <Space>p/ :<C-U>Ack! <C-R>=GetVisualString()<CR>
    nnoremap <Space>m/ :<C-U>Ack! --<C-R>=&ft<CR> <C-R><C-W>
    vnoremap <Space>m/ :<C-U>Ack! --<C-R>=&ft<CR> <C-R>=GetVisualString()<CR>
    ""}}}
    """ quickFix"{{{
    nnoremap <Space>Q :<C-U>cwin<CR>
    nnoremap <Space>q :<C-U>lwin<CR>
    nnoremap <Space>qs :<C-U>lvim/<C-R><C-W>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(6)<CR><BS>
    nnoremap <Space>qgs :<C-U>lvimgrepadd/<C-R><C-W>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(13)<CR><BS>
    vnoremap <Space>qs :<C-U>lvim/<C-R>=GetVisualString()<CR>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(6)<CR><BS>
    vnoremap <Space>qgs :<C-U>lvimgrepadd/<C-R>=GetVisualString()<CR>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(13)<CR><BS>
    " navigate at item
    nnoremap <Space>qn :<C-U><C-R>=v:count1<CR>lnext<CR>
    nnoremap <Space>Qn :<C-U><C-R>=v:count1<CR>cnext<CR>
    nnoremap <Space>qp :<C-U><C-R>=v:count1<CR>lNext<CR>
    nnoremap <Space>Qp :<C-U><C-R>=v:count1<CR>cNext<CR>
    nnoremap <Space>qq :<C-U>ll<C-R>=v:count1<CR><CR>
    nnoremap <Space>QQ :<C-U>cc<C-R>=v:count1<CR><CR>
    " quick window undo and redo
    nnoremap <Space>Qu :<C-U>colder <C-R>=v:count1<CR><CR>
    nnoremap <Space>Q<C-R> :<C-U>cnewer <C-R>=v:count1<CR><CR>
    nnoremap <Space>qu :<C-U>lolder <C-R>=v:count1<CR><CR>
    nnoremap <Space>q<C-R> :<C-U>lnewer <C-R>=v:count1<CR><CR>
    " use <M-q> or <M-l>
    nnoremap [<M-q> :<C-U>colder <C-R>=v:count1<CR><CR>:call repeat#set("[\<M-q>",1)<CR>
    nnoremap ]<M-q> :<C-U>cnewer <C-R>=v:count1<CR><CR>:call repeat#set("]\<M-q>",1)<CR>
    nnoremap [<M-l> :<C-U>lolder <C-R>=v:count1<CR><CR>:call repeat#set("[\<M-l>",1)<CR>
    nnoremap ]<M-l> :<C-U>lnewer <C-R>=v:count1<CR><CR>:call repeat#set("]\<M-l>",1)<CR>
    " use ack
    nnoremap <Space>Q/ :<C-U>Ack!<Space>
    nnoremap <Space>Q* :<C-U>Ack! <C-R><C-W><CR>
    vnoremap <Space>Q* :<C-U>Ack! <C-R>=GetVisualString()<CR><CR>
    nnoremap <Space>q/ :<C-U>LAck!<Space>
    nnoremap <Space>q* :<C-U>LAck! <C-R><C-W><CR>
    vnoremap <Space>q* :<C-U>LAck! <C-R>=GetVisualString()<CR><CR>
    "}}}
    """ buffer"{{{
    nnoremap <Space>bw :<C-U>confirm w<CR>
    nnoremap <Space>bx :<C-U>confirm x<CR>
    nnoremap <Space>bb :<C-U>ls<CR>
    nnoremap <Space>bs :<C-U>sb<Space>
    nnoremap <Space>bv :<C-U>vert sb<Space>
    nnoremap <Space>bt :<C-U>tab sb<Space>
    nnoremap <Space>bl :<C-U>Unite -start-insert buffer<CR>
    " quit buffer and open previous buffer
    nnoremap <Space>bq <C-^>:bd #<CR>
    "nnoremap <Space>bl :<C-U>CtrlPBuffer<CR>
    ""}}}
    """ file"{{{
    nnoremap <Space>fs :<C-U>confirm w<CR>
    nnoremap <Space>fS :<C-U>confirm wa<CR>
    nnoremap <Space>ft :<C-U>sp ~/.vim/ftplugin/<C-R>=&ft<CR>.vim<CR>
    nnoremap <Space>fr :<C-U>CtrlPMRUFiles<CR>
    "}}}
    """ text"{{{
    nnoremap <Space>xw :<C-U>TrimWhiteSpace<CR>
    nnoremap <Space>xl :<C-U>TrimMultiEmptyLine<CR>
    "}}}
    """ misc"{{{
    nnoremap <leader><Space>s :<C-U>Scratch<Space>
    nnoremap <leader><Space>sp :<C-U>Scratch<Space>tmp.py<CR>
    nnoremap <leader><Space>ss :<C-U>Scratch<Space>tmp.sh<CR>

    nnoremap <Space><C-]> :<C-U>tjump /.*<C-R><C-W>.*<CR>
    nnoremap <Space><C-W>] :<C-U>stjump /.*<C-R><C-W>.*<CR>
    nnoremap <Space><C-W>} :<C-U>ptjump /.*<C-R><C-W>.*<CR>

    nnoremap <Space><Tab> [I:let n = input("Which one: ")<Bar>if n > 0 <BAR>exe "normal" n."[\t" <BAR>endif<CR>
    vnoremap <Space><Tab> :<C-U>let pat=GetVisualString()<CR>:ilist /<C-R>=pat<CR>/<CR>:let n = input("Which one: ")<BAR>if n > 0<BAR>exe "ijump" n "/".pat."/"<BAR>endif<CR>

    " <M-x> cmdline window
    nnoremap <M-x> q:i
    vnoremap <M-x> q:i
    " repeat cmd
    inoremap <M-1> <esc>1
    inoremap <M-2> <esc>2
    inoremap <M-3> <esc>3
    inoremap <M-4> <esc>4
    inoremap <M-5> <esc>5
    inoremap <M-6> <esc>6
    inoremap <M-7> <esc>7
    inoremap <M-8> <esc>8
    inoremap <M-9> <esc>9
    inoremap <M-q> <esc>q
    " fold
    nnoremap z% v%zf
    ""}}}
    " }}}
"}}}
