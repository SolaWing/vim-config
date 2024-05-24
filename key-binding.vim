""" vim: set sw=4 ts=4 sts=4 et foldlevel=1 foldmethod=marker:

function! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

""""""""""" command map {{{
cnoremap <C-L> <C-D>
cnoremap <C-X><C-L> <C-L>
cnoremap <C-X><C-A> <C-A>
" use ctrl-A to move to begin, according to term
cnoremap <C-A> <C-B>
cnoremap <C-]> <C-\>ecmdline#SearchChar(1,1, 2)<CR>
" ctrl-K kill line
cnoremap <C-K> <C-\>egetcmdpos()==1?"" :getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-X><C-K> <C-K>
" <M-]> to search backword
cnoremap <M-]> <C-\>ecmdline#SearchChar(0,0, 2)<CR>
cnoremap <M-d> <C-\>ecmdline#ForwordDeleteWord()<CR>
" sudo
cabbrev w!! w !sudo tee % >/dev/null
" search occur
cnoremap <C-o> <CR><Cmd>lvim//j % <bar>lwin<CR>
cnoremap <M-o> <CR><Cmd>Redir g/<CR>
call SetupCommandAlias('F', 'FZF')
"}}}

" use a leader as group map. inspired by Spacemacs
" in insert mode, leader is <M-m>
" in other mode, leader is <Space>
imap <M-m> <C-o><Leader>

" NOTE: filetype reserved key <LocalLeader>
imap <M-CR> <C-o><LocalLeader>

""" tab keys "{{{
" nmap <C-t> <Space>t
" move to tab page
nnoremap <Space>t1 1gt
nnoremap <Space>t2 2gt
nnoremap <Space>t3 3gt
nnoremap <Space>t4 4gt
nnoremap <Space>t5 5gt
nnoremap <Space>t6 6gt
nnoremap <Space>t7 7gt
nnoremap <Space>t8 8gt
nnoremap <Space>t9 9gt
nnoremap <Space>t0 10gt
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt
nnoremap <M-0> 10gt
" tabmove position
nnoremap <Space>tl <Cmd>exe "tabm +". v:count1<CR>
nnoremap <Space>tL <Cmd>tabm<CR>
nnoremap <Space>th <Cmd>exe "tabm -". v:count1<CR>
nnoremap <Space>tH <Cmd>tabm 0<CR>
nnoremap <Space>tt <C-W>T
" new tab
nnoremap <Space>ts <C-W>s<C-W>T
nnoremap <Space>tn <Cmd> tabnew<CR>
nnoremap <Space>te :<C-U>tabe<Space>
nnoremap <Space>t] <Cmd>exe "tab tag" expand("<cword>")<CR>
nmap <Space>t<C-]> <Space>t]
nnoremap <Space>tg] <Cmd>exe "tab tjump" expand("<cword>")<CR>
nnoremap <Space>t} :<C-U>tab tjump /.*<C-R><C-W>.*<CR>
xnoremap <Space>t] :<C-U>tab tag <C-R>=GetVisualString()<CR><CR>
xnoremap <Space>tg] :<C-U>tab tjump <C-R>=GetVisualString()<CR><CR>
" close tab
nnoremap <Space>tc :<C-U>confirm <C-R>=v:count?v:count :""<CR>tabclose<CR>
nnoremap <Space>tC :<C-U>call misc#tabclose_right(v:count)<CR>
nnoremap <Space>to :<C-U>confirm <C-R>=v:count?v:count :""<CR>tabonly<CR>
" tab do
nnoremap <Space>t: :<C-U>tabdo<Space>
"}}}
""" windows"{{{
Map <Space>w <C-W>
nnoremap <C-W>w :<C-U>FZWindows<CR>
nnoremap <C-W>N :<C-U>vnew<CR>
nnoremap <C-W>e :<C-U>sp<Space>
nnoremap <C-W>E :<C-U>vsp<Space>
nnoremap <C-W>o :<C-U>confirm <C-R>=v:count?v:count :""<CR>only<CR>
nnoremap <C-W><C-O> :<C-U>confirm <C-R>=v:count?v:count :""<CR>only<CR>
nnoremap <C-W>: :<C-U>windo<Space>

" window convenience control
nnoremap <Space>1 1<C-W><C-W>
nnoremap <Space>2 2<C-W><C-W>
nnoremap <Space>3 3<C-W><C-W>
nnoremap <Space>4 4<C-W><C-W>
nnoremap <Space>5 5<C-W><C-W>
" window move
nnoremap <C-J>    <C-W>j
nnoremap <C-K>    <C-W>k
nnoremap <C-H>    <C-W>h
nnoremap <C-L>    <C-W>l
nnoremap <C-=>    <C-W>=

nnoremap <M-Left> <C-W>h
nnoremap <M-Right> <C-W>l
nnoremap <M-Up> <C-W>k
nnoremap <M-Down> <C-W>j

" use F5 to open quick-fix list
nnoremap <F5> :cwin<cr>
nnoremap <S-F5> :lwin<cr>
nmap <F17> <S-F5>
nmap <Leader><F5> <S-F5>
"}}}
""" terminal"{{{
tnoremap <ESC> <C-\><C-n>
tnoremap jk <C-\><C-n>
"}}}
""" args "{{{
nnoremap <Leader>aa :<C-u><C-R>=v:count?v:count:""<CR>argadd <Bar> argdedupe <CR>
nnoremap <Leader>ad :<C-u><C-R>=v:count?v:count:""<CR>argdelete<CR>

" }}}
""" buffer"{{{
nnoremap <Space>bw <Cmd>confirm w<CR>
nnoremap <Space>bx <Cmd>confirm x<CR>
nnoremap <Space>bd <Cmd>confirm bdelete<CR>


nnoremap <Space>bD <Cmd>FZBD<CR>
nnoremap <Space>bl <Cmd>FZBuffers<CR>
nmap <Space>bb <Space>bl
nmap <M-tab> <Space>bl
nnoremap <Space>bs :<C-U>sb<Space>
nnoremap <Space>bv :<C-U>vert sb<Space>
nnoremap <Space>bt :<C-U>tab sb<Space>
" quit buffer and open previous buffer
nnoremap <Space>bq <C-^>:bd #<CR>
""}}}
""" file"{{{
nnoremap <Space>dg :Glcd<CR>
nnoremap <Space>dp :Plcd<CR>

nnoremap <Space>fo :!open<Space>
nnoremap <silent> <Space>fd :silent !open '%:h'<CR>
nnoremap <Space>fs <Cmd>confirm w<CR>
nnoremap <Space>fS <Cmd>confirm wa<CR>
noremap <M-s> <Cmd>confirm w<CR>
inoremap <M-s> <Cmd>confirm w<CR>
noremap <M-S> <Cmd>confirm wa<CR>
inoremap <C-x><C-x> <Esc>:confirm x<CR>
nnoremap ZA :qa!<CR>
nnoremap ZX :confirm xa<CR>

nnoremap <Space>et :<C-U>0tab drop ~/.vim/ftplugin/<C-R>=&ft<CR>.vim<CR>
nnoremap <Space>eT :<C-U>0tab drop ~/.vim/after/ftplugin/<C-R>=&ft<CR>.vim<CR>
nnoremap <Space>ep :<C-U>0tab drop ~/.vim/bundle-config/index.vim<CR>
nnoremap <Space>ek :<C-U>0tab drop ~/.vim/key-binding.vim<CR>
nnoremap <Space>ei :<C-U>0tab drop ~/.vim/fnl/config/init.fnl<CR>
nnoremap <Space>fr :<C-U>CtrlPMRUFiles<CR>
nnoremap <Space>ff :<C-U>FZFiles <C-R>=expand("%:p:h")<CR>
"}}}
""" project keys"{{{
nnoremap <Space>pf :<C-U>FZGFiles<CR>
nnoremap <Space>pr :<C-U>FZHistory<CR>
nmap <F8> <Space>pr
nmap <F7> <Space>pf
" 目前不支持加query..

nnoremap <Space>h  :<C-U>FZHistory<CR>
nnoremap <Space>h: :<C-U>FZHistory:<CR>
nnoremap <Space>h; :<C-U>FZHistory:<CR>
xnoremap <Space>h; :<C-U>FZHistory:<CR>
nnoremap <Space>h/ :<C-U>FZHistory/<CR>
nnoremap <Space>p/ :<C-U>Grepper -cword<CR>
xnoremap <Space>p/ :<C-U>Grepper -query '<C-R>=GetVisualString()<CR>'<CR>
nnoremap <LocalLeader>/ :<C-U>Grepper -tool rg -query -t <C-R>=config#RgFileType(&ft)<CR> -u '<C-R><C-W>'<CR>
xnoremap <LocalLeader>/ :<C-U>Grepper -tool rg -query -t <C-R>=config#RgFileType(&ft)<CR> -u '<C-R>=GetVisualString()<CR>'<CR>
" term in vim add additional quote, and will switch to term buffer. may need async run command and show in a preview buffer
nnoremap <Space>pt :<C-U>!cd '<C-R>=getcwd()<CR>' && ctags -R .

nnoremap <Space>pxc :CDO s/\V\<<C-R><C-W>\>/<C-R>=misc#ToggleCamelOrUnderline("<C-R><C-W>")<CR>/
xnoremap <Space>pxc :<C-U>CDO s/\V<C-R>=GetVisualString()<CR>/<C-R>=misc#ToggleCamelOrUnderline(tmp)<CR>/
nnoremap <Space>pxs :CDO sno`\<<C-R><C-W>\>`<C-R><C-W>`<Left>
xnoremap <Space>pxs :<C-U>let tmp = GetVisualString()<CR>
            \:CDO sno`<C-R>=tmp<CR>`<C-R>=tmp<CR>`<Left>

" nnoremap <Space>pxc :Far <C-R><C-W> <C-R>=misc#ToggleCamelOrUnderline("<C-R><C-W>")<CR><Space>
" xnoremap <Space>pxc :<C-U>let tmp = GetVisualString()<CR>
"             \:Far <C-R>=tmp<CR> <C-R>=misc#ToggleCamelOrUnderline(tmp)<CR><Space>
" nnoremap <Space>pxs :Far <C-R><C-W><Space>
" xnoremap <Space>pxs :<C-U>Far <C-R>=GetVisualString()<CR><Space>

""}}}
""" git version control"{{{
nnoremap <silent> <Space>gg <Cmd>!cd '%:h' && gitup<CR>
nnoremap <Space>gs :Git<CR>
nnoremap <Space>gS :tab Git<CR>
nnoremap <Space>gv :GV --since='3\ months'<CR>
xnoremap <Space>gV :GV<CR>
nnoremap <Space>gV :<C-U>tab Git -p log -p <C-R>=v:count == v:count1? "-".v:count : ""<CR>  -- %<CR>
" follow is slow, so use another key when needed
nnoremap <Space>g<M-V> :tab Git -p log -p --follow -- %<CR>
nnoremap <Space>gd :<C-U>Gdiffsplit <C-R>=v:count == v:count1?"@~".v:count : ""<CR><CR>
nnoremap <Space>gD :<C-U>Gvdiffsplit <C-R>=v:count == v:count1?"@~".v:count : ""<CR><CR>
nnoremap <Space>g<C-d> :<C-U>FZBCommits<CR>
noremap <Space>gb :Git blame<CR>
noremap <Space>gB :GBrowse<CR>
nnoremap <Space>gcd :Gcd<CR>
nnoremap <Space>gf :Git fetch --prune<CR>
nnoremap <Space>gF :Git pull --rebase<CR>
nnoremap <Space>gpr :Git rv
nnoremap <Space>gm :Git mergetool<CR>
" 不要push，防误点
" nnoremap <Space>gp :Gpush
" nnoremap <Space>gpp :Gpush origin +HEAD
nnoremap <Space>gR :Grebase --autosquash -i<CR>
nnoremap <Space>gw :Gwrite<CR>
nnoremap <Space>ge :Gedit<CR>
nnoremap <Space>gr :<C-U>Gread <C-R>=v:count?"@~".v:count : ""<CR><CR>
" xnoremap <Space>gr :Gread <C-R>=v:count?"@~".v:count : ""<CR><CR>
nnoremap <Space>gl :GV?<CR>
xnoremap <Space>gl :GV?<CR>
nnoremap <Space>g<Space> :<C-U>FZGFiles?<CR>
"}}}
""" quickFix"{{{
nnoremap <Space>Q :<C-U>cwin<CR>
nnoremap <Space>q :<C-U>lwin<CR>
nnoremap <Space>QQ :<C-U>cwin<CR>
nnoremap <Space>qq :<C-U>lwin<CR>
nnoremap <Space>qs :<C-U>lvim/<C-R><C-W>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(6)<CR><BS>
nnoremap <Space>qgs :<C-U>lvimgrepadd/<C-R><C-W>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(13)<CR><BS>
xnoremap <Space>qs :<C-U>lvim/<C-R>=GetVisualString()<CR>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(6)<CR><BS>
xnoremap <Space>qgs :<C-U>lvimgrepadd/<C-R>=GetVisualString()<CR>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(13)<CR><BS>
" quick window undo and redo
nnoremap <Space>Qu :<C-U>colder <C-R>=v:count1<CR><CR>
nnoremap <Space>Q<C-R> :<C-U>cnewer <C-R>=v:count1<CR><CR>
nnoremap <Space>qu :<C-U>lolder <C-R>=v:count1<CR><CR>
nnoremap <Space>q<C-R> :<C-U>lnewer <C-R>=v:count1<CR><CR>
" use <M-q> or <M-l>
nnoremap [<M-q> :<C-U>colder <C-R>=v:count1<CR><CR>:call repeat#set("[\<M-q>",1)<CR>
nnoremap ]<M-q> :<C-U>cnewer <C-R>=v:count1<CR><CR>:call repeat#set("]\<M-q>",1)<CR>
nnoremap [<M-l> :<C-U>lolder <C-R>=v:count1<CR><CR>:call repeat#set("[\<M-l>",1)<CR>
nnoremap ]<M-l> :<C-U>lnewer <C-R>=v:count1<CR><CR>:call repeat#set("]\<M-l>",1)<CR>
"}}}
""" navigate "{{{
" use j to group jump command
nnoremap <Leader>jj    :let b:prevmore=&more <bar> set nomore <bar> jumps <bar> let &more=b:prevmore<CR>
nmap <Leader>jb <Space>bl
nmap <Leader>jw <C-W>w
nmap <Leader>jo <F3>
nmap <Leader>js <LocalLeader>m
nmap <Leader>jS <F6>
nmap <Leader>jd -
nmap <Leader>jg <Leader>gs

nmap <Space>s<Space> :<C-U>Grepper<Space>
nmap <Space>s<CR> :<C-U>Grepper<CR>

nmap <Space>sp <Space>p/
xmap <Space>sp <Space>p/
nnoremap <Space>s* <Cmd>exe "FZRg -F" shellescape(expand("<cword>"))<CR>
xnoremap <Space>s* "vy<Cmd>exe "FZRg -F" shellescape(@v)<CR>
Map <Space>s8 <Space>s*
nnoremap <Space>s] <Cmd>exe "FZTags" shellescape(expand("<cword>"))<CR>
xnoremap <Space>s] "vy<Cmd>exe "FZTags" shellescape(@v)<CR>
nmap <Space>sm <LocalLeader>/
xmap <Space>sm <LocalLeader>/

nnoremap <Space><Tab> :<C-U>FZBLines<CR>
xnoremap <Space><Tab> :<C-U>FZBLines<CR>
nnoremap <Leader>* :<C-U>FZBLines <C-R><C-W><CR>
xnoremap <Leader>* :<C-U>FZBLines <C-R>=GetVisualString()<CR><CR>
nmap <Leader>8 <Leader>*
xmap <Leader>8 <Leader>*
nnoremap <C-W><Tab> :<C-U>FZLines<CR>

nnoremap <Leader><F3> :<C-U>FZBTags<CR>
xnoremap <Leader><F3> :<C-U>exe "FZBTags" GetVisualString()<CR>
nmap <LocalLeader>m <Leader><F3>
xmap <LocalLeader>m <Leader><F3>


nnoremap <F6> :<C-U>FZTags<CR>
nnoremap <Leader><F6> :<C-U>FZTags <C-R><C-W><CR>
xnoremap <Leader><F6> :<C-U>exe "FZTags" GetVisualString()<CR>
nmap g] <Leader><F6>
xmap g] <Leader><F6>

" 取消搜索高亮
nnoremap z/    <C-L>:noh<CR>

" nnoremap n nzz
" nnoremap N Nzz

" n always foward, N always backward
" noremap <expr> n 'Nn'[v:searchforward]
" noremap <expr> N 'nN'[v:searchforward]
"}}}
""" text"{{{
" use alt + hjkl move cursor, alt + HL move to begin, end
map! <M-h> <Left>
map! <M-j> <Down>
map! <M-k> <Up>
map! <M-l> <Right>
map! <M-H> <home>
map! <M-L> <end>

" emacs style insert mapping
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-A> <home>
silent inoremap <unique> <C-E> <end>

" alt + f b, word move
map! <M-f> <S-Right>
map! <M-b> <S-Left>
" map <M-H> <home>
" map <M-L> <end>
noremap! <C-D> <Del>

" alt + d, del word
inoremap <M-d> <C-O>de
noremap! <M-BS> <C-W>

" inoremap <C-k> <C-o>D
" easier horizontal scroll
nmap zl zL
xmap zl zL
nmap zh zH
xmap zh zH

" command+return 插入新行
inoremap <D-CR> <End><CR>
inoremap <S-CR> <End><CR>
inoremap <D-S-CR> <C-O>O
" alt + oO
inoremap <M-o> <C-O>o
inoremap <M-O> <C-O>O

" move line up or down. may add zv to prevent auto refold to level
" ( test only in vim buffer, marker fold, and level )
" ADD: add zv still fold other fold.
nnoremap <M-J> :m .+1<CR>
vnoremap <M-J> :m '>+1<CR>gv
vnoremap <M-K> :m '<-2<CR>gv
nnoremap <M-K> :m .-2<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" use c* to change current word. than can use . to repeat action
nnoremap c* *Ncgn
" NOTE: depend on * to highlight current word and don't move
" cause with c, clear and start insert, response delay
" xmap c* *cgn

" visual @ execute on multilines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
xnoremap @<esc> <Nop>

" nnoremap Q @q
" xmap Q @q

" make Q to quick replay macro
function! ExecuteMacroOverVisualRange()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

nnoremap <Space>xw :TrimWhiteSpace<CR>
xnoremap <Space>xw :TrimWhiteSpace<CR>
nnoremap <Space>xl :TrimMultiEmptyLine<CR>
xnoremap <Space>xl :TrimMultiEmptyLine<CR>

nnoremap <Space>xs :sno`\<<C-R><C-W>\>`<C-R><C-W>`g<Left><Left>
xnoremap <Space>xs :<C-U>let g:count = v:count <bar> let tmp = GetVisualString()<CR>
            \:<C-R>=g:count > 1? ".,.+".(g:count-1) : ""<CR>
            \sno`<C-R>=tmp<CR>`<C-R>=tmp<CR>`g<Left><Left>
xnoremap g& :s//~/&<CR>
xnoremap &  :s<CR>

nnoremap <Space>xS :s/ /\r/g<CR>
xnoremap <Space>xS :s/ /\r/g<CR>

nnoremap <Space>xc :s/\V\<<C-R><C-W>\>/<C-R>=misc#ToggleCamelOrUnderline("<C-R><C-W>")<CR>/g
xnoremap <Space>xc :<C-U>let g:count = v:count <bar> let tmp = GetVisualString()<CR>
            \:<C-R>=g:count > 1? ".,.+".(g:count-1) : ""<CR>
            \s/\V<C-R>=tmp<CR>/<C-R>=misc#ToggleCamelOrUnderline(tmp)<CR>/g

nnoremap <Space>x( :call misc#SurroundSpaceBetweenPairs('(',')')<CR>
nnoremap <Space>x) :call misc#SurroundSpaceBetweenPairs('(',')')<CR>
nnoremap <Space>x[ :call misc#SurroundSpaceBetweenPairs('\[','\]')<CR>
nnoremap <Space>x] :call misc#SurroundSpaceBetweenPairs('\[','\]')<CR>
xnoremap <Space>x( :call misc#SurroundSpaceBetweenPairs('(',')')<CR>
xnoremap <Space>x) :call misc#SurroundSpaceBetweenPairs('(',')')<CR>
xnoremap <Space>x[ :call misc#SurroundSpaceBetweenPairs('\[','\]')<CR>
xnoremap <Space>x] :call misc#SurroundSpaceBetweenPairs('\[','\]')<CR>

imap <C-x>f <plug>(fzf-complete-path)
imap <C-x>l <plug>(fzf-complete-line)
"}}}
""" tags {{{
nnoremap <Space><C-]> :<C-U>tjump /.*<C-R><C-W>.*<CR>
nnoremap <Space><C-W>] :<C-U>stjump /.*<C-R><C-W>.*<CR>
nnoremap <Space><C-W>} :<C-U>ptjump /.*<C-R><C-W>.*<CR>
" }}}
""" textobject "{{{
xnoremap ig ggoG$
omap ig :silent norm Vig<CR>
" conflict marker
xnoremap <silent> ak <C-\><C-N>?<<<<<<<<CR>V/=======<CR>
omap <silent> ak :silent norm Vak<CR>
xnoremap <silent> aj <C-\><C-N>/>>>>>>><CR>V?=======<CR>
omap <silent> aj :silent norm Vaj<CR>
nnoremap du :<C-U>call edit#markResolver()<CR>
""" }}}
""" completion"{{{
function! s:select_pum(index)
  if !pumvisible() | return "" | endif

  " let compInfo = complete_info()
  " let idx = a:index >= 0 ? a:index : a:index + len(compInfo.items)
  " let d = idx - compInfo.selected
  return repeat( "\<Down>", a:index ) . "\<C-Y>"
endfunction

for s:i in range(1, 9)
    exe printf('inoremap <expr> <M-%d> <sid>select_pum(%d)', s:i, s:i)
endfor

inoremap <C-x><C-o> <C-x><C-o><C-p>

"}}}
""" misc"{{{

" replay s//flags
nnoremap & <Cmd>&&<CR>

" <M-x> cmdline window
nnoremap <M-x> q:i
xnoremap <M-x> q:i

" format
nmap gqq gqig
" fold
nnoremap z% v%zf
" use zx as set foldlevel if give count
nnoremap <expr> zx v:count == v:count1 ? ":\<C-U>set foldlevel=".v:count."\<CR>" : "zx"

" map K use help and can back
" nnoremap <silent> K      :<C-r>=&keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s",expand('<cword>')) : printf("!%s %s <bar> less", &keywordprg, expand('<cword>')) <CR><CR>
" xnoremap <silent> K      <esc>:<C-r>=line("'<") == line("'>") ? &keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s", getline("'<")[col("'<")-1:col("'>")-1] ) : printf("!%s %s <bar> less", &keywordprg, getline("'<")[col("'<")-1:col("'>")-1]) : "norm! gv" <cr><CR><CR>

" insert visual mode
" inoremap <M-v> <C-O>v
" inoremap <M-V> <C-O>V
" inoremap <M-C-v> <C-O><C-v>

" ii,jf,fj,jk 退出插入模式
" left hand have too many work. here use right hand
noremap! jk <ESC>

" make <C-g> same with ESC. which is the emacs style shortcut
" nmap <C-g> <ESC>
" map! <C-g> <ESC>

" make Y consistent with D, C, yank line can use yy
nnoremap Y y$

noremap <M-a> <C-\><C-N>ggVG
noremap <M-c> "*y
noremap <M-v> "*p
inoremap <M-v> <C-R><C-O>*
cnoremap <M-v> <C-R><C-R>*

" write " to specify register
function! SetRegister() range
    let char = getchar()
    if type(char) == type(0)
        let char = nr2char(char)
        if char =~# '^[0-9a-zA-Z/*+~]$'
            exe printf('let @%s = @" | echo "save unnamed register to %s"', char, char)
        endif
    endif
endfunction

nnoremap <silent> M :call SetRegister()<CR>



""}}}

if has('nvim') " nvim additional config
    lua require('config.keybinding').init()
end
