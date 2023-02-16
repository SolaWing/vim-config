let g:EasyMotion_do_mapping = 0
let g:EasyMotion_startofline = 0
" let g:EasyMotion_use_upper = 1
" let g:EasyMotion_keys = 'ASDGHKLQWERTYUIOPZXCVBNMFJ;'

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [] })
endfunction

Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
map  <S-Space> <Plug>(easymotion-bd-w)
imap <S-Space> <C-o><Plug>(easymotion-bd-w)
" <M-/>
map  <M-/> <Plug>(easymotion-bd-w)
imap <M-/> <C-o><Plug>(easymotion-bd-w)

Map  <Space><CR>    <Plug>(easymotion-bd-jk)
Map  <Space><Space> <Plug>(easymotion-s)
nmap <C-W><Space>   <Plug>(easymotion-overwin-f)
nmap <C-W><M-/>     <Plug>(easymotion-overwin-w)
nmap <C-W><CR>      <Plug>(easymotion-overwin-line)
" zap to char
imap <M-z> <C-o>d<Plug>(easymotion-s)

function! _EasyMotionPromptBegin()
    if g:hasCOC
        silent! CocDisable
    end
    let g:keep_fold = 1 " see usage, to quickly keep fold and handle delay
    " if has_key(g:plugs, 'nvim-treesitter')

    " endif
    " syntax off
endfunction

function! _EasyMotionPromptEnd()
    if g:hasCOC
        silent! CocEnable
    end
    unlet g:keep_fold
    " if has_key(g:plugs, 'nvim-treesitter')

    " endif
    " syntax on
endfunction

autocmd mine User EasyMotionPromptBegin call _EasyMotionPromptBegin()
autocmd mine User EasyMotionPromptEnd   call _EasyMotionPromptEnd()
" gruvbox override it..
" autocmd mine User VimEnter hi link EasyMotionShade EasyMotionShadeDefault
