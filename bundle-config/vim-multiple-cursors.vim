Plug 'terryma/vim-multiple-cursors'

"" integrate with other plugin
function! Multiple_cursors_before()
    let g:ycm_auto_trigger = 0
endfunction

function! Multiple_cursors_after()
    let g:ycm_auto_trigger = 1
endfunction
