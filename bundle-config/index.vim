""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:
set nocompatible              " be iMproved, required
call plug#begin('~/.vim/bundle')

" ==================== Basic{{{
    if has('nvim-0.5.0')
        source ~/.vim/bundle-config/nvim5.vim
        " source ~/.vim/bundle-config/hop.vim
    " else
    endif
    source ~/.vim/bundle-config/easymotion.vim
    source ~/.vim/bundle-config/sneak.vim
    source ~/.vim/bundle-config/autopair.vim

    " if argv(0) =~# '\.\%(swift\|[hcm]\|mm\|cpp\|py\)$'
    if $COC == "1" || ($COC != "0" && argv(0) !~# '\.\%(swift\)$')
        let g:hasCOC = v:true
        source ~/.vim/bundle-config/coc.vim
    else
        let g:hasCOC = v:false
        source ~/.vim/bundle-config/ycm.vim
        " enable coc update. use g:hasCOC to check plugin really loaded
        Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': []}
    endif
    " source ~/.vim/bundle-config/copilot.vim
    source ~/.vim/bundle-config/tag-related.vim

    " source ~/.vim/bundle-config/vim-clap.vim
    source ~/.vim/bundle-config/tpope.vim
    source ~/.vim/bundle-config/junegunn.vim
    source ~/.vim/bundle-config/solawing.vim

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
        set viewoptions=cursor
        let g:skipview_files = ['.*\.vim']
    " }}}
    source ~/.vim/bundle-config/devdocs.io.vim

    " justinmk/vim-dirvish {{{
        let g:loaded_netrwPlugin = 1
        command! -nargs=? -complete=dir Explore Dirvish <args>
        command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
        command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
        Plug 'justinmk/vim-dirvish'
    "}}}
    Plug 'justinmk/vim-gtfo' " go to folder or terminal
    source ~/.vim/bundle-config/ale.vim
    source ~/.vim/bundle-config/grepper.vim
    " Plug 'dyng/ctrlsf.vim', {'on': ['CtrlSF']}
    " eregex.vim"{{{
        Plug 'othree/eregex.vim', { 'on': ['S'] }
        let g:eregex_default_enable = 0
    "}}}
    " mbbill/undotree "{{{
        Plug 'mbbill/undotree' ",             { 'on': 'UndotreeToggle'   }
        nnoremap <F4> <Cmd>UndotreeToggle<CR>
    "}}}
    source ~/.vim/bundle-config/submode.vim
    source ~/.vim/bundle-config/vim-visual-multi.vim
    " Plug 'terryma/vim-expand-region'
    source ~/.vim/bundle-config/slime.vim

    source ~/.vim/bundle-config/any-jump.vim
    Plug 'CoatiSoftware/vim-sourcetrail' " sourcetrail交互集成
"}}}
    source ~/.vim/bundle-config/lang.vim
    " repl的体验不如终端，ruby debugger也不如pry. 只能简单的运行表达式，控制断点..
    " if has('nvim')
    "     source ~/.vim/bundle-config/debugger.vim
    " endif

    source ~/.vim/bundle-config/indent-guide.vim
    source ~/.vim/bundle-config/theme.vim
    source ~/.vim/bundle-config/lightline.vim

call plug#end()
silent doautocmd <nomodeline> User plug#end
