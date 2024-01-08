echom "run nvimginit"

nnoremap <D-1>    1gt
inoremap <D-1>    <esc>1gt
nnoremap <D-2>    2gt
inoremap <D-2>    <esc>2gt
nnoremap <D-3>    3gt
inoremap <D-3>    <esc>3gt
nnoremap <D-4>    4gt
inoremap <D-4>    <esc>4gt
nnoremap <D-5>    5gt
inoremap <D-5>    <esc>5gt
" move tabs
nnoremap <D-M-]>    :tabm +1<cr>
nnoremap <D-M-[>    :tabm -1<cr>

if has("gui_vimr")
    map <M-S-*> <M-*>
elseif exists("g:neovide")
    " 感觉作用不大，中文状态下输入的全角字符，还是得切换语言
    " augroup ime_input
    "     autocmd!
    "     autocmd InsertLeave * let g:neovide_input_ime=v:false
    "     autocmd InsertEnter * let g:neovide_input_ime=v:true
    "     autocmd CmdlineEnter [/\?] let g:neovide_input_ime=v:false
    "     autocmd CmdlineLeave [/\?] let g:neovide_input_ime=v:true
    " augroup END

    map <M-S-8> <M-*>
    nnoremap <D-n> <Cmd>!~/.cargo/bin/neovide<CR>
    noremap <D-c> "*y
    noremap <D-v> "*p
    inoremap <D-v> <C-R><C-O>*
    cnoremap <D-v> <C-R><C-R>*
    tnoremap <D-v> <C-\><C-N>"*pi
    noremap <D-w> <C-w>q
    " not work...
    " noremap <D-S-w> <Cmd>confirm quitall<CR>
else
    " set guifont=Fira\ Code:h14
    set guifont=FiraCode\ Nerd\ Font\ Mono:h14
    " set guifont=Hack_Regular_Nerd_Font_Complete_Mono:h14
end

" autocmd! mine InsertLeave * set imdisable
" autocmd! mine InsertEnter * set noimdisable
