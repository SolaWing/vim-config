Plug 'mg979/vim-visual-multi'
" <M-Down> not work in terminal...
let g:VM_maps = {
            \ 'Toggle Mappings': '<Space>',
            \ 'Add Cursor Down': '<M-Down>',
            \ 'Add Cursor Up':   '<M-Up>',
            \ 'Add Cursor At Pos': 'g<CR>',
            \ 'Mouse Cursor': '<M-LeftMouse>',
            \ 'Select All':      '<M-*>',
            \ 'Visual All':      '<M-*>',
            \ 'Visual Find':     '<M-F>',
            \ }
map \\8 <M-*>
" let g:VM_Mono_Cursor_hl = 'StatusLine'
" let g:VM_Ins_Mode_hl = 'Underlined'
