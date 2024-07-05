" 配置不够好用，不喜欢配色，文档不够方便
Plug 'phaazon/hop.nvim'

map  <S-Space> <Cmd>HopWord<CR>
imap <S-Space> <Cmd>HopWord<CR>
map  <M-/> <Cmd>HopWord<CR>
imap <M-/> <Cmd>HopWord<CR>

Map  <Space><CR>    <Cmd>HopLine<CR>
Map  <Space><Space> <Cmd>HopChar1<CR>
" nmap <C-W><Space>   <Plug>(easymotion-overwin-f)
" nmap <C-W><M-/>     <Plug>(easymotion-overwin-w)
" nmap <C-W><CR>      <Plug>(easymotion-overwin-line)
" zap to char
" imap <M-z> <C-o>d<Plug>(easymotion-s)

" function! _ConfigHop()
"   lua require'hop'.setup{ create_hl_autocmd = false }
"   hi! link HopNextKey Search
"   hi! HopNextKey1 cterm=bold ctermfg=11 gui=bold guifg=#ffb400
"   hi! HopNextKey2 cterm=bold ctermfg=3 gui=bold guifg=#b98300
" endfunction

"autocmd mine User plug#end ++once call _ConfigHop()
