let g:NERDTreeBookmarksFile = $HOME . "/.vim/bundle/nerdtree/.NERDTreeBookmarks"
" let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeCascadeSingleChildDir=1
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeWinSize = 51
" disable netrw
let g:loaded_netrwPlugin = 1
Plug 'scrooloose/nerdtree', {'on':[ 'NERDTreeToggle', 'NERDTreeFind' ]}
augroup nerd_loader
    autocmd!
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd BufEnter,BufNew *
                \  if isdirectory(expand('<amatch>'))
                \|   call plug#load('nerdtree')
                \|   execute 'autocmd! nerd_loader'
                \| endif
augroup END
nnoremap <F2> <Cmd>let g:NERDTreeQuitOnOpen = 0 <bar> NERDTreeToggle<CR>
nnoremap <S-F2> <Cmd>let g:NERDTreeQuitOnOpen = 1 <bar> NERDTreeFind<CR>
nmap <F14> <S-F2>
nmap <Leader><F2> <S-F2>
