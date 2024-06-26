
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-neco'
" Plug '~/.vim/bundle/coc-yaml'
" Plug 'yaegassy/coc-typeprof', {'do': 'yarn install --frozen-lockfile'}
" fix special comment in json file of common js config file
Plug 'neoclide/jsonc.vim'

""" use ultisnip
Plug 'SirVer/ultisnips'
source ~/.vim/bundle-config/ultisnip.vim
autocmd mine BufLeave * call UltiSnips#LeavingBuffer()
""" or coc-snippets
" Plug 'honza/vim-snippets'
" nnoremap <Leader>es <Cmd>exe "sp ~/.vim/UltiSnips/"..&ft..".snippets"<CR>
" imap <M-'> <Plug>(coc-snippets-expand)

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
            \ coc#pum#visible() ? coc#pum#next(1):
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

let g:AutoPairsMapCR = 0
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>\<C-R>=AutoPairsReturn()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <LocalLeader>gg <Plug>(coc-definition)
nmap <silent> <LocalLeader>gt <Plug>(coc-type-definition)
nmap <silent> <LocalLeader>gi <Plug>(coc-implementation)
nmap <silent> <LocalLeader>gd <Plug>(coc-declaration)
nmap <silent> <LocalLeader>gr <Plug>(coc-references)
nmap <silent> <LocalLeader>gR <Cmd>CocCommand document.showIncomingCalls<CR>
nnoremap <LocalLeader>gc <Cmd>CocDiagnostics<CR>

" disable auto-preview
" let g:coc_enable_locationlist = 0
" autocmd User CocLocationsChange CocList --normal location

nmap <C-W><LocalLeader>gr <C-W>s<LocalLeader>gr
nmap <C-W><LocalLeader>gg <C-W>s<LocalLeader>gg
nmap <C-W><M-g> <C-W>s<M-g>
nmap <Space>t<M-g> <C-W>s<C-W>T<M-g>
nmap <M-g> <LocalLeader>gg
nmap gr <Plug>(coc-references-used)

" Use K to show documentation in preview window.

command! -nargs=* CocHover :call CocActionAsync('definitionHover')
set keywordprg=:CocHover
nmap <silent> <LocalLeader>gk <Cmd>call CocActionAsync('definitionHover')<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <LocalLeader>gn <Plug>(coc-rename)

" Formatting selected code.
xmap <LocalLeader>f  <Plug>(coc-format-selected)
nmap <LocalLeader>f  <Plug>(coc-format)

" Applying codeAction to the selected region.
" Example: `<LocalLeader>aap` for current paragraph
xmap <LocalLeader>a  <Plug>(coc-codeaction-selected)
xmap <LocalLeader>aa  <Plug>(coc-codeaction-selected)
nmap <LocalLeader>a  <Plug>(coc-codeaction-selected)
nmap <LocalLeader>aa  <Plug>(coc-codeaction-cursor)

" Remap keys for applying codeAction to the current line.
nmap <LocalLeader>ac  <Plug>(coc-codeaction-line)
nmap <LocalLeader>a:  <Plug>(coc-codelens-action)
nmap <LocalLeader>as  <Plug>(coc-codeaction-source)
" Apply AutoFix to problem on the current line.
nmap <LocalLeader>gf  <Plug>(coc-fix-current)

nmap <LocalLeader>ar  <Plug>(coc-codeaction-refactor-selected)
nmap <LocalLeader>arr  <Plug>(coc-codeaction-refactor)
xmap <LocalLeader>ar  <Plug>(coc-codeaction-refactor-selected)

nnoremap <LocalLeader>gc <Cmd>CocDiagnostics<CR>

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
" vim repplay macro bugs: https://github.com/vim/vim/issues/6350 https://github.com/neovim/neovim/issues/12551
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

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
nnoremap <silent> <LocalLeader>la  <Cmd>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <LocalLeader>le  <Cmd>CocList extensions<cr>
" Manage extensions.
nnoremap <silent> <LocalLeader>lE  <Cmd>CocList sources<cr>
" Show commands.
nnoremap <silent> <LocalLeader>lc  <Cmd>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <LocalLeader>lo  <Cmd>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <LocalLeader>ls  <Cmd>CocList symbols<cr>
" workspace folders
nnoremap <silent> <LocalLeader>lw  <Cmd>CocList folders<cr>
" Do default action for next item.
nnoremap <silent> <LocalLeader>lj  <Cmd>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <LocalLeader>lk  <Cmd>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <LocalLeader>ll  <Cmd>CocListResume<CR>

augroup my_COC
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " autocmd FileType scss setl iskeyword+=@-@
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" map vim ft to the LSP langid
let g:coc_filetype_map = {
  \ 'xhtml': 'html',
  \ 'objc': 'objective-c',
  \ 'objcpp': 'objective-cpp',
  \ }
