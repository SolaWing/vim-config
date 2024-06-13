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
" let g:fzf_launcher='~/.vim/bin/fzfIterm.js %s'
let g:fzf_history_dir='~/.vim/bundle/fzf.vim/.history'
let g:fzf_command_prefix = 'FZ'
let g:fzf_preview_window = 'up:hidden'
" FIXME: fzf_action now execute first, not append args after, so tab drop not work..
let g:fzf_action = {
  \ 'ctrl-t': 'tab drop',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let $FZF_DEFAULT_OPTS=' --bind="' . join([
            \    'alt-j:down,alt-k:up',
            \    'alt-h:backward-char,alt-l:forward-char',
            \    'alt-a:select-all,alt-d:deselect-all',
            \    'alt-space:jump,`:jump-accept',
            \    'F4:toggle-preview,alt-[:preview-page-up,alt-]:preview-page-down',
            \    'ctrl-f:page-down,ctrl-b:page-up'
            \], ',') . '" --color="pointer:15"'
" let g:fzf_layout = { 'up' : '~40%'  }
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
if has('nvim-0.5.0')
    Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
end
 if g:hasCOC
     Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
     let g:coc_fzf_opts = []
     let g:coc_fzf_preview_fullscreen = 1
     " Show all diagnostics.
     nnoremap <silent> <localleader>La  <Cmd>CocFzfList diagnostics<cr>
     " Show commands.
     nnoremap <silent> <localleader>Lc  <Cmd>CocFzfList commands<cr>
     " Find symbol of current document.
     nnoremap <silent> <localleader>Lo  <Cmd>CocFzfList outline<cr>
     " Search workspace symbols.
     nnoremap <silent> <localleader>Ls  <Cmd>CocFzfList symbols<cr>
     " workspace folders
     "nnoremap <silent> <localleader>Lw  <Cmd>CocFzfList folders<cr>
     " Resume latest coc list.
     nnoremap <silent> <localleader>Ll  <Cmd>CocFzfListResume<CR>
 endif

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
function! LastSearchCount(opts = {}) abort
    let result = searchcount(a:opts)
    if empty(result)
        return ''
    endif
    if result.incomplete ==# 1     " timed out
        return printf(' /%s [?/??]', @/)
    elseif result.incomplete ==# 2 " max count exceeded
        if result.total > result.maxcount &&
                    \  result.current > result.maxcount
            return printf(' /%s [>%d/>%d]', @/,
                        \             result.current, result.total)
        elseif result.total > result.maxcount
            return printf(' /%s [%d/>%d]', @/,
                        \             result.current, result.total)
        endif
    endif
    return printf(' /%s [%d/%d]', @/,
                \             result.current, result.total)
endfunction
function! Myslash_after()
    call slash#blink(2, 50)
    echo LastSearchCount(#{recompute: 1, timeout: 100})
    return ''
endfunction
map <expr> <plug>(slash-after) Myslash_after()
" }}}
