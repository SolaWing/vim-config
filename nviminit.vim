""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=1 foldmethod=marker:
"{
"exe printf("set rtp=%s,%s,%s", expand('~/.vim'), &rtp, expand('~/.vim/after'))

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
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

tnoremap <ESC> <C-\><C-n>
tnoremap jk <C-\><C-n>
source ~/.vimrc

" ensure ~/.vim at first
set rtp-=~/.vim
set rtp^=~/.vim
"}
