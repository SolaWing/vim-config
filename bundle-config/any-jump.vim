Plug 'pechorin/any-jump.vim'
let g:any_jump_disable_default_keybindings = 1

" Normal mode: Jump to definition under cursore
nnoremap <localleader>j <Cmd>AnyJump<CR>

" Visual mode: jump to selected text in visual mode
xnoremap <localleader>j <Cmd>AnyJumpVisual<CR>

" Normal mode: open previous opened file (after jump)
nnoremap <localleader><M-j> <Cmd>AnyJumpBack<CR>

" Normal mode: open last closed search window again
nnoremap <localleader><C-j> <Cmd>AnyJumpLastResults<CR>
