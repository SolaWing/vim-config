Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc-neco'
" fix special comment in json file of common js config file
Plug 'neoclide/jsonc.vim'
source ~/.vim/bundle-config/ultisnip.vim

" TextEdit might fail if hidden is not set.
" lots of unclose file may cause vim slow
" set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=2000

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <localleader>gg <Plug>(coc-definition)
nmap <silent> <localleader>gt <Plug>(coc-type-definition)
nmap <silent> <localleader>gi <Plug>(coc-implementation)
nmap <silent> <localleader>gd <Plug>(coc-declaration)
nmap <silent> <localleader>gr <Plug>(coc-references)
nmap <silent> <localleader>gR :<C-U>CocCommand document.showIncomingCalls<CR>

" disable auto-preview
let g:coc_enable_locationlist = 0
autocmd User CocLocationsChange CocList --normal location

nmap <C-W><LocalLeader>gr <C-W>s<LocalLeader>gr
nmap <C-W><LocalLeader>gg <C-W>s<LocalLeader>gg
nmap <C-W><M-g> <C-W>s<M-g>
nmap <Space>t<M-g> <C-W>s<C-W>T<M-g>
nmap <M-g> <LocalLeader>gg

" Use K to show documentation in preview window.

command! -nargs=* CocHover :call CocActionAsync('doHover')
set keywordprg=:CocHover

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <LocalLeader>gn <Plug>(coc-rename)

" Formatting selected code.
xmap <LocalLeader>f  <Plug>(coc-format-selected)
nmap <LocalLeader>f  <Plug>(coc-format)

" Applying codeAction to the selected region.
" Example: `<localleader>aap` for current paragraph
xmap <localleader>a  <Plug>(coc-codeaction-selected)
nmap <localleader>a  <Plug>(coc-codeaction-selected)
nmap <localleader>aa  <Plug>(coc-codeaction-cursor)

" Remap keys for applying codeAction to the current line.
nmap <localleader>ac  <Plug>(coc-codeaction-line)
nmap <localleader>as  <Plug>(coc-codelens-action)
" Apply AutoFix to problem on the current line.
nmap <localleader>gf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <localleader>la  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <localleader>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <localleader>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <localleader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <localleader>ls  :<C-u>CocList -I symbols<cr>
" workspace folders
nnoremap <silent> <localleader>lw  :<C-u>CocList folders<cr>
" Do default action for next item.
nnoremap <silent> <localleader>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <localleader>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <localleader>ll  :<C-u>CocListResume<CR>

augroup my_COC
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " autocmd FileType scss setl iskeyword+=@-@
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd mine BufLeave * call UltiSnips#LeavingBuffer()
augroup end

let g:coc_filetype_map = {
  \ 'xhtml': 'html',
  \ }
