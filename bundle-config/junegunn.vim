""" vim: set sw=4 ts=4 sts=4 et foldmethod=marker foldlevel=1:
" junegunn/vim-easy-align {{{
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
xmap <cr> <Plug>(EasyAlign)
nmap ga   <Plug>(EasyAlign)
" }}}
" junegunn/fzf.vim {{{
" 易用性上还差一节, 而且需要集成到term里面..
" ctrlp的自动定位git很有用.  unite的方便性比它好..
" fzf 性能上有些优势.

let g:fzf_buffers_jump = 0
let g:fzf_launcher='~/.vim/bin/fzfIterm.js %s'
let g:fzf_history_dir='~/.vim/bundle/fzf.vim/.history'
let g:fzf_command_prefix = 'FZ'
let g:fzf_preview_window = 'right:hidden'
let $FZF_DEFAULT_OPTS=' --bind="'.join([
            \    'alt-j:down,alt-k:up',
            \    'alt-h:backward-char,alt-l:forward-char',
            \    'alt-a:select-all,alt-d:deselect-all',
            \    'alt-space:jump,`:jump-accept',
            \    '?:toggle-preview'
            \], ',') . '" --color="pointer:15"'
" let g:fzf_layout = { 'up' : '~40%'  }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" if has_key(g:plugs, 'coc.nvim')
"     Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
"     " Show all diagnostics.
"     nnoremap <silent> <localleader>La  <Cmd>CocFzfList diagnostics<cr>
"     " Show commands.
"     nnoremap <silent> <localleader>Lc  <Cmd>CocFzfList commands<cr>
"     " Find symbol of current document.
"     nnoremap <silent> <localleader>Lo  <Cmd>CocFzfList outline<cr>
"     " Search workspace symbols.
"     nnoremap <silent> <localleader>Ls  <Cmd>CocFzfList symbols<cr>
"     " workspace folders
"     nnoremap <silent> <localleader>Lw  <Cmd>CocFzfList folders<cr>
"     " Resume latest coc list.
"     nnoremap <silent> <localleader>Ll  <Cmd>CocFzfListResume<CR>
" endif

command! -bang -nargs=* FZRg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! FZBD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': ['--multi','--prompt','BufDelete> ']
\ }))

" function! MarksToLocation(line)
"     " 运行时本地的buffer文件已经变了，不太好获取啊
"     return a:line
"     " let pos = getpos("'".matchstr(line, '\S'))
"     redir => cout
"     silent marks
"     redir END
"     return l:cout
" endfunction
" command! -bar -bang FZMarks call fzf#vim#marks(
"             \ {'options': ['--preview-window', 'right:50%', '--preview', printf('v={}; echo "$(~/.vim/bin/evalInVim.sh "%s" "MarksToLocation(''""${v//\''/''''}""'')" )"', v:servername)]},
"             \ <bang>0)
" "}}}
" junegunn/goyo.vim {{{
" let g:goyo_width = '90%'
" Plug 'junegunn/goyo.vim'
" }}}
" junegunn/vim-slash {{{
Plug 'junegunn/vim-slash'
" nvim slash effect is awkward...
if has('timers') && !has('nvim')
    nmap <expr> <plug>(slash-after) "\<Plug>SearchIndex" . slash#blink(2, 50)
else
    nmap <expr> <plug>(slash-after) "\<Plug>SearchIndex"
endif
" }}}
