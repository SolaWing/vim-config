""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=1 foldmethod=marker:
"{
"exe printf("set rtp=%s,%s,%s", expand('~/.vim'), &rtp, expand('~/.vim/after'))


" au SourcePre,BufAdd,BufDelete,BufHidden,BufNew,BufRead,BufReadPre,BufUnload,OptionSet,SessionLoadPost,User,VimEnter *
"   \ echom "debug auto" expand('<afile>') nvim_list_bufs()

" try use lua to write nvim config
" help lua function may be used before plugin load. these loaded function may use old version code
set rtp+=~/.vim/bundle/aniseed,~/.vim/bundle/plenary.nvim
" lua require('aniseed.env').init({module = 'config.init'})
lua require("config.init").init()
finish

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if $COLORTERM ==? 'truecolor'
    set termguicolors
end

let tmp = $COLORFGBG[strridx($COLORFGBG, ";")+1:]
if !empty("tmp")
    if tmp > 8
        set bg=light
    else
        set bg=dark
    endif
endif
unlet tmp

set nottimeout " avoid esc delay
" substitute 预览
set inccommand=nosplit

" symlink not need to add rtp
" set rtp^=~/.vim
" set rtp+=~/.vim/after
set vdir=~/.vim/view

" let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

if has("gui_vimr")
    call setenv('LANG', 'zh_CN.UTF-8') " https://github.com/qvacua/vimr/issues/807
end

" 自动进入输入状态
source ~/.vimrc
" coc会进入insert，而不是terminal..., 暂时先关掉了
" 和Start!命令冲突，会进入insert状态..
" autocmd mine TermOpen * startinsert

command Fish sp | terminal /usr/local/bin/fish -l

" ensure ~/.vim at first
" set rtp-=~/.vim
" set rtp^=~/.vim
"}
