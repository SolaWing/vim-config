let g:EasyMotion_do_mapping = 0
let g:EasyMotion_startofline = 0
" let g:EasyMotion_use_upper = 1
" let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'
Plug 'easymotion/vim-easymotion' " custom
map  <S-Space> <Plug>(easymotion-bd-w)
imap <S-Space> <C-o><Plug>(easymotion-bd-w)
" <M-/>
map  <M-/> <Plug>(easymotion-bd-w)
imap <M-/> <C-o><Plug>(easymotion-bd-w)
map  <M-?> <Plug>(easymotion-s)
imap <M-?> <C-o><Plug>(easymotion-s)

Map  <Space><CR>    <Plug>(easymotion-bd-jk)
Map  <Space><Space> <Plug>(easymotion-s)
nmap <C-W><Space>   <Plug>(easymotion-overwin-f)
nmap <C-W><M-/>     <Plug>(easymotion-overwin-w)
nmap <C-W><CR>      <Plug>(easymotion-overwin-line)
" zap to char
imap <M-z> <C-o>d<Plug>(easymotion-s)

function! _EasyMotionPromptBegin()
    if has_key(g:plugs, 'coc.nvim')
        silent! CocDisable
    end
    " if has_key(g:plugs, 'nvim-treesitter')

    " endif
    " syntax off
endfunction

function! _EasyMotionPromptEnd()
    if has_key(g:plugs, 'coc.nvim')
        silent! CocEnable
    end
    " if has_key(g:plugs, 'nvim-treesitter')

    " endif
    " syntax on
endfunction

autocmd mine User EasyMotionPromptBegin call _EasyMotionPromptBegin()
autocmd mine User EasyMotionPromptEnd   call _EasyMotionPromptEnd()
