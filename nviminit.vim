""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=1 foldmethod=marker:
"{
"exe printf("set rtp=%s,%s,%s", expand('~/.vim'), &rtp, expand('~/.vim/after'))

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

set rtp^=~/.vim
set rtp+=~/.vim/after
set vdir=~/.vim/view

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

if has("gui_vimr")
    call setenv('LANG', 'zh_CN.UTF-8') " https://github.com/qvacua/vimr/issues/807
end

" 自动进入输入状态
source ~/.vimrc
autocmd mine TermOpen * startinsert

" ensure ~/.vim at first
set rtp-=~/.vim
set rtp^=~/.vim
"}
