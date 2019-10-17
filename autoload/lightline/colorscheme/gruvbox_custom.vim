if exists("*lightline#colorscheme#base16_solarized_custom#gen")
  finish
endif

function! lightline#colorscheme#gruvbox_custom#gen()
    runtime autoload/lightline/colorscheme/gruvbox.vim
    let g:lightline#colorscheme#gruvbox_custom#palette = g:lightline#colorscheme#gruvbox#palette
endfunction

call lightline#colorscheme#gruvbox_custom#gen()

augroup lightline_base16
    au!
    autocmd ColorScheme * call lightline#colorscheme#gruvbox_custom#gen() | call lightline#colorscheme()
augroup END
