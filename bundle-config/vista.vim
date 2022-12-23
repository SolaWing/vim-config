Plug 'liuchengxu/vista.vim'

let g:vista_sidebar_width = 50

autocmd mine FileType vista,vista_kind nnoremap <buffer> <silent> // <Cmd>call vista#finder#fzf#Run()<CR>
nnoremap <F3> <Cmd>Vista<CR>

let g:vista#renderer#enable_icon = 1
" let g:vista#renderer#enable_kind = 1
let g:vista#renderer#icons = {
            \ "singletonmethod": ""
            \ }
