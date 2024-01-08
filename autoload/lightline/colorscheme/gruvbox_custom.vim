if exists("*lightline#colorscheme#base16_solarized_custom#gen")
  finish
endif

if 0 && has('nvim-0.10')
    function! lightline#colorscheme#gruvbox_custom#gen()
        runtime autoload/lightline/colorscheme/gruvbox-material.vim
        let g:lightline#colorscheme#gruvbox_custom#palette = g:lightline#colorscheme#gruvbox_material#palette
    endfunction
else
    function! lightline#colorscheme#gruvbox_custom#gen()
        runtime autoload/lightline/colorscheme/gruvbox.vim
        let g:lightline#colorscheme#gruvbox_custom#palette = g:lightline#colorscheme#gruvbox#palette
    endfunction
endif

call lightline#colorscheme#gruvbox_custom#gen()

augroup lightline_base16
    au!
    autocmd ColorScheme * call lightline#colorscheme#gruvbox_custom#gen() | call lightline#colorscheme()
augroup END
