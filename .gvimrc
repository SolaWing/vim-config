""" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=0 foldmethod=marker:
"gui{
    " ctags command
    let g:ctags_command = "xtags -R ."
    " guicolorscheme
    " set bg=light
    " colorscheme solarized
    colorscheme base16-solarized-custom
    " gui font size
    set guifont=Menlo\ Regular:h14

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
    " open some window quickly


    " <D-P> is override by Print, change it here
    if has("gui_macvim")
        set macmeta
        macmenu File.Print key=<D-S-P>
    endif

    " 全文搜索
    nnoremap <D-F>  :copen <bar> silent grep! -RF <C-R>=expand("<cword>")<CR> *<C-Left><Left>
    vnoremap <D-F>  <esc>:copen <bar> silent grep! -RF <C-r>=line("'<") == line("'>") ? getline("'<")[col("'<")-1:col("'>")-1] : expand("<cword>") <CR> *<C-Left><Left>
    " command + , edit vimrc
    nnoremap <D-<> :edit $MYVIMRC<CR>
"}
