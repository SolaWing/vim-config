let g:UltiSnipsListSnippets        = "<Plug>UltisnipList"
let g:UltiSnipsExpandTrigger       = "<Plug>UltisnipExpand"
" function! ExpandOrList()
"     let l = getline('.')
"     let l:kw = matchstr(l,'\v\S+$')
"     if len(l:kw)
"         return "\<Plug>UltisnipExpand"
"     endif
"     return "\<Plug>UltisnipList"
" endfunction
" imap <expr> <M-'> ExpandOrList()
imap <M-'> <Plug>UltisnipExpand
" visual expand
xmap <M-'> <Plug>UltisnipExpand
imap <M-C-'> <Plug>UltisnipList
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
