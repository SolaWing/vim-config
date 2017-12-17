""" vim: set sw=4 ts=4 sts=4 et foldlevel=1 foldmethod=marker:

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
cnoremap <C-o> <CR>:lvim//j % <bar>lwin<CR>
"}}}

" use a leader as group map. inspired by Spacemacs
" in insert mode, leader is <M-m>
" in other mode, leader is <Space>
imap <M-m> <C-o><Leader>

" NOTE: filetype reserved key <LocalLeader>
imap <M-CR> <C-o><LocalLeader>

""" tab keys "{{{
nmap <C-t> <Space>t
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
nnoremap <Space>tl :<C-U>silent exe "tabm +". v:count1<CR>
nnoremap <Space>tL :<C-U>silent tabm<CR>
nnoremap <Space>th :<C-U>silent exe "tabm -". v:count1<CR>
nnoremap <Space>tH :<C-U>silent tabm 0<CR>
nnoremap <Space>tt <C-W>T
" new tab
nnoremap <Space>ts <C-W>s<C-W>T
nnoremap <Space>tn :<C-U>silent tabnew<CR>
nnoremap <Space>te :<C-U>tabe<Space>
nnoremap <Space>t] :<C-U>tab tag <C-R><C-W><CR>
nmap <Space>t<C-]> <Space>t]
nnoremap <Space>tg] :<C-U>tab tjump <C-R><C-W><CR>
nnoremap <Space>t} :<C-U>tab tjump /.*<C-R><C-W>.*<CR>
xnoremap <Space>t] :<C-U>tab tag <C-R>=GetVisualString()<CR><CR>
xnoremap <Space>tg] :<C-U>tab tjump <C-R>=GetVisualString()<CR><CR>
" close tab
nnoremap <Space>tc :<C-U>confirm =v:count?v:count :""<CR>tabclose<CR>
nnoremap <Space>tC :<C-U>call misc#tabclose_right(v:count)<CR>
nnoremap <Space>to :<C-U>confirm =v:count?v:count :""<CR>tabonly<CR>
" tab do
nnoremap <Space>t: :<C-U>tabdo<Space>
"}}}
""" windows"{{{
Map <Space>w <C-W>
nnoremap <C-W>w :<C-U>FZWindows<CR>
nnoremap <C-W>e :<C-U>sp<Space>
nnoremap <C-W>o :<C-U>confirm =v:count?v:count :""<CR>only<CR>
nnoremap <C-W><C-O> :<C-U>confirm =v:count?v:count :""<CR>only<CR>
nnoremap <C-W>: :<C-U>windo<Space>

" window convenience control
nnoremap <Space>1 1<C-W><C-W>
nnoremap <Space>2 2<C-W><C-W>
nnoremap <Space>3 3<C-W><C-W>
nnoremap <Space>4 4<C-W><C-W>
nnoremap <Space>5 5<C-W><C-W>
" focus window
nnoremap <C-J>    <C-W>j<C-W>_
nnoremap <C-K>    <C-W>k<C-W>_
nnoremap <C-H>    <C-W>h<C-W>_
nnoremap <C-L>    <C-W>l<C-W>_
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
""" buffer"{{{
nnoremap <Space>bw :<C-U>confirm w<CR>
nnoremap <Space>bx :<C-U>confirm x<CR>

nnoremap <Space>bd :<C-U>confirm bdelete<CR>
nnoremap <Space>bb :<C-U>FZBuffers<CR>
nnoremap <Space>bs :<C-U>sb<Space>
nnoremap <Space>bv :<C-U>vert sb<Space>
nnoremap <Space>bt :<C-U>tab sb<Space>
nnoremap <Space>bl :<C-U>FZBuffers<CR>
nmap <M-tab> <Space>bl
" quit buffer and open previous buffer
nnoremap <Space>bq <C-^>:bd #<CR>
""}}}
""" file"{{{
nnoremap <Space>fd :!open '%:h'<CR>
nnoremap <Space>fs :<C-U>confirm w<CR>
nnoremap <Space>fS :<C-U>confirm wa<CR>
noremap <M-s> :<C-U>confirm w<CR>
inoremap <M-s> <C-o>:<C-U>confirm w<CR>
noremap <M-S> :<C-U>confirm wa<CR>
inoremap <C-c><C-c> <Esc>:confirm x<CR>
nnoremap Za :confirm qa<CR>
nnoremap ZA :qa!<CR>
nnoremap ZX :confirm xa<CR>

nnoremap <Space>et :<C-U>0tabe ~/.vim/ftplugin/<C-R>=&ft<CR>.vim<CR>
nnoremap <Space>ep :<C-U>0tabe ~/.vim/bundles.vim<CR>
nnoremap <Space>ek :<C-U>0tabe ~/.vim/key-binding.vim<CR>
nnoremap <Space>fr :<C-U>CtrlPMRUFiles<CR>
nnoremap <Space>ff :<C-U>CtrlP<CR>
"}}}
""" project keys"{{{
nnoremap <Space>pf :<C-U>FZGFiles<CR>
nnoremap <D-p> :<C-U>CtrlP<CR>
nnoremap <Space>pr :<C-U>FZHistory<CR>
nmap <F8> <Space>pr
nmap <F7> <Space>pf
nnoremap <Space>h  :<C-U>FZHistory<CR>
nnoremap <Space>h: :<C-U>FZHistory:<CR>
nnoremap <Space>h/ :<C-U>FZHistory/<CR>
nnoremap <Space>p/ :<C-U>Ack! '<C-R><C-W>'<Left>
xnoremap <Space>p/ :<C-U>Ack! '<C-R>=GetVisualString()<CR>'<Left>
nnoremap <LocalLeader>/ :<C-U>Ack! -t <C-R>=&ft<CR> '<C-R><C-W>'<Left>
xnoremap <LocalLeader>/ :<C-U>Ack! -t <C-R>=&ft<CR> '<C-R>=GetVisualString()<CR>'<Left>
" term in vim add additional quote, and will switch to term buffer. may need async run command and show in a preview buffer
nnoremap <Space>pt :<C-U>!ctags -R '=getcwd()<CR>'
""}}}
""" git version control"{{{
nnoremap <Space>gs :Gstatus<CR>z15<CR>
nnoremap <Space>gv :GV --since='3\ months'<CR>
xnoremap <Space>gV :GV<CR>
nnoremap <Space>gV :Gtabedit! log -p -- %<CR>
nnoremap <Space>gd :<C-U>Gdiff <C-R>=v:count == v:count1?"@~".v:count : ""<CR><CR>
nnoremap <Space>gD :<C-U>Gvdiff <C-R>=v:count == v:count1?"@~".v:count : ""<CR><CR>
nnoremap <Space>g<C-d> :<C-U>FZBCommits<CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gcd :Gcd<CR>
nnoremap <Space>gf :Gfetch<CR>
nnoremap <Space>gF :Gpedit! pull --rebase<CR>
nnoremap <Space>gp :Gpedit! push<CR>
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
nnoremap [<M-q> :<C-U>colder <C-R>=v:count1<CR><CR>:call repeat#set("[\<M-q>",1)<CR>
nnoremap ]<M-q> :<C-U>cnewer <C-R>=v:count1<CR><CR>:call repeat#set("]\<M-q>",1)<CR>
nnoremap [<M-l> :<C-U>lolder <C-R>=v:count1<CR><CR>:call repeat#set("[\<M-l>",1)<CR>
nnoremap ]<M-l> :<C-U>lnewer <C-R>=v:count1<CR><CR>:call repeat#set("]\<M-l>",1)<CR>
" use ack
nnoremap <Space>Q/ :<C-U>Ack!<Space>
nnoremap <Space>Q* :<C-U>Ack! <C-R><C-W><CR>
xnoremap <Space>Q* :<C-U>Ack! <C-R>=GetVisualString()<CR><CR>
nnoremap <Space>q/ :<C-U>LAck!<Space>
nnoremap <Space>q* :<C-U>LAck! <C-R><C-W><CR>
xnoremap <Space>q* :<C-U>LAck! <C-R>=GetVisualString()<CR><CR>
"}}}
""" navigate "{{{
nmap <Space>sp <Space>p/
xmap <Space>sp <Space>p/
nnoremap <Space>s* :<C-U>FZAg <C-R><C-W><CR>
xnoremap <Space>s* :<C-U>FZAg <C-R>=GetVisualString()<CR><CR>
nnoremap <Space>s8 :<C-U>FZAg <C-R><C-W><CR>
xnoremap <Space>s8 :<C-U>FZAg <C-R>=GetVisualString()<CR><CR>
nnoremap <Space>s] :<C-U>FZTags '<C-R><C-W><CR>
xnoremap <Space>s] :<C-U>FZTags '<C-R>=GetVisualString()<CR><CR>
nmap <Space>sm <LocalLeader>/
xmap <Space>sm <LocalLeader>/

nnoremap <Space><Tab> :<C-U>FZBLines<CR>
xnoremap <Space><Tab> :<C-U>FZBLines<CR>
nnoremap <Leader>* :<C-U>FZBLines '<C-R><C-W><CR>
xnoremap <Leader>* :<C-U>FZBLines '<C-R>=GetVisualString()<CR><CR>
nmap <Leader>8 <Leader>*
xmap <Leader>8 <Leader>*
nnoremap <C-W><Tab> :<C-U>FZLines<CR>

nnoremap <Leader><F3> :<C-U>FZBTags<CR>
nnoremap <LocalLeader>m :<C-U>FZBTags<CR>

nnoremap <F6> :<C-U>FZTags<CR>
nnoremap <Leader><F6> :<C-U>FZTags '<C-R><C-W><CR>
xnoremap <Leader><F6> :<C-U>FZTags '<C-R>=GetVisualString()<CR><CR>

" 取消搜索高亮
nnoremap z/    :noh<CR>

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
inoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-A> <home>
inoremap <C-E> <end>

" alt + f b, word move
map! <M-f> <S-Right>
map! <M-b> <S-Left>
map <M-H> <home>
map <M-L> <end>
noremap! <C-D> <Del>

" alt + d, del word
inoremap <M-d> <C-O>de
noremap! <M-BS> <C-W>

inoremap <C-k> <C-o>D

" easier horizontal scroll
Map zl zL
Map zh zH

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

" visual @ execute on multilines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
xnoremap @<esc> <Nop>

nnoremap Q @q
xmap Q @q

" make Q to quick replay macro



function! ExecuteMacroOverVisualRange()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

nnoremap <Space>xw :TrimWhiteSpace<CR>
xnoremap <Space>xw :TrimWhiteSpace<CR>
nnoremap <Space>xl :TrimMultiEmptyLine<CR>
xnoremap <Space>xl :TrimMultiEmptyLine<CR>

nnoremap <Space>xs :sno/\<<C-R><C-W>\>/<C-R><C-W>/gc<Left><Left><Left>
xnoremap <Space>xs :<C-U><C-R>=v:count > 1? ".,.+".(v:count-1) : ""<CR>sno/<C-R>=GetVisualString()<CR>/<C-R>=GetVisualString()<CR>/gc<Left><Left><Left>
xnoremap g& :s//~/&<CR>

nnoremap <Space>xS :s/ /\r/g<CR>
xnoremap <Space>xS :s/ /\r/g<CR>

nnoremap <Space>xc :s/\V\<<C-R><C-W>\>/<C-R>=misc#ToggleCamelOrUnderline("<C-R><C-W>")<CR>/gc
xnoremap <Space>xc :<C-U>let g:count = v:count <bar> let tmp = GetVisualString()<CR>:<C-R>=g:count > 1? ".,.+".(g:count-1) : ""<CR>s/\V<C-R>=tmp<CR>/<C-R>=misc#ToggleCamelOrUnderline(tmp)<CR>/gc

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
nnoremap <LocalLeader><Space>s :<C-U>Scratch<Space>
nnoremap <LocalLeader><Space>sp :<C-U>Scratch<Space>tmp.py<CR>
nnoremap <LocalLeader><Space>ss :<C-U>Scratch<Space>tmp.sh<CR>

nnoremap <Space><C-]> :<C-U>tjump /.*<C-R><C-W>.*<CR>
nnoremap <Space><C-W>] :<C-U>stjump /.*<C-R><C-W>.*<CR>
nnoremap <Space><C-W>} :<C-U>ptjump /.*<C-R><C-W>.*<CR>
" }}}
""" textobject "{{{
xnoremap ig ggoG$
omap ig :silent norm Vig<CR>
""" }}}
""" misc"{{{

" <M-x> cmdline window
nnoremap <M-x> q:i
xnoremap <M-x> q:i
" repeat cmd
inoremap <M-1> <esc>1
inoremap <M-2> <esc>2
inoremap <M-3> <esc>3
inoremap <M-4> <esc>4
inoremap <M-5> <esc>5
inoremap <M-6> <esc>6
inoremap <M-7> <esc>7
inoremap <M-8> <esc>8
inoremap <M-9> <esc>9
inoremap <M-q> <esc>q

" format
nmap gqq gqig
" fold
nnoremap z% v%zf

" map K use help and can back
nnoremap <silent> K      :<C-r>=&keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s",expand('<cword>')) : printf("!%s %s <bar> less", &keywordprg, expand('<cword>')) <CR><CR>
xnoremap <silent> K      <esc>:<C-r>=line("'<") == line("'>") ? &keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s", getline("'<")[col("'<")-1:col("'>")-1] ) : printf("!%s %s <bar> less", &keywordprg, getline("'<")[col("'<")-1:col("'>")-1]) : "norm! gv" <cr><CR><CR>

" insert visual mode
" inoremap <M-v> <C-O>v
" inoremap <M-V> <C-O>V
" inoremap <M-C-v> <C-O><C-v>

" ii,jf,fj,jk 退出插入模式
" left hand have too many work. here use right hand
noremap! jk <ESC>

" make Y consistent with D, C, yank line can use yy
nnoremap Y y$

noremap <M-a> <C-\><C-N>ggVG
noremap <M-c> "*y
noremap <M-v> "*p
inoremap <M-v> <C-R><C-O>*
cnoremap <M-v> <C-R><C-R>*

nnoremap <Leader>j    :let b:prevmore=&more <bar> set nomore <bar> jumps <bar> let &more=b:prevmore<CR>
" Map <Leader><CR> <Plug>(easymotion-bd-jk)


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
