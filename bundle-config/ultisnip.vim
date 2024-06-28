" 配置的trigger失败会返回对应的key。不需要
"let g:UltiSnipsListSnippets        = "<M-C-'>"
"let g:UltiSnipsExpandTrigger       = "<M-'>"
function! MyUltiSnipsExpandSnippet() range
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
      echo "expand fail"
  endif
  return ""
endfunction
imap <M-'> <C-R>=MyUltiSnipsExpandSnippet()<CR>
xnoremap <M-'> :call UltiSnips#SaveLastVisualSelection()<cr>gvs
imap <M-C-'> <Cmd>call UltiSnips#ListSnippets()<CR>
let g:UltiSnipsJumpForwardTrigger  = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsEnableSnipMate = 0
" nvim have a different location, so set it
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
" load two version of python spend a lot of time
let g:UltiSnipsUsePythonVersion = 3

" Optional:
Plug 'honza/vim-snippets'
let g:ultisnips_python_style = 'jedi'

com! UltiTmpSnippet call UltiSnips#AddFiletypes("tmp") | UltiSnipsEdit tmp
nnoremap <Leader>eS <Cmd>UltiTmpSnippet<CR>
nnoremap <Leader>es <Cmd>exe "sp ~/.vim/UltiSnips/"..&ft..".snippets"<CR>

" preview auto stop snippet. so disable it
autocmd mine User UltiSnipsEnterFirstSnippet set completeopt-=preview
autocmd mine User UltiSnipsExitLastSnippet   set completeopt+=preview
