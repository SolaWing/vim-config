""" vim: set sw=4 ts=4 sts=4 et foldlevel=1 foldmethod=marker:

""""""""" normal map {{{

nnoremap Za :confirm qa<CR>
nnoremap ZA :qa!<CR>
nnoremap ZX :confirm xa<CR>
"z/ 取消搜索高亮
nnoremap z/    :noh<CR>
" <leader>j  showjumplistToEnd
nnoremap <leader>j    :let b:prevmore=&more <bar> set nomore <bar>
            \jumps <bar> let &more=b:prevmore<CR>
" window convenience control
" focus window
nnoremap <C-J>    <C-W>j<C-W>_
nnoremap <C-K>    <C-W>k<C-W>_
nnoremap <C-H>    <C-W>h<C-W>_
nnoremap <C-L>    <C-W>l<C-W>_
nnoremap <C-=>    <C-W>=

" map K use help and can back
nnoremap <silent> K      :<C-r>=&keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s",expand('<cword>')) : printf("!%s %s <bar> less", &keywordprg, expand('<cword>')) <CR><CR>
vnoremap <silent> K      <esc>:<C-r>=line("'<") == line("'>") ? &keywordprg==':help' <bar><bar> &keywordprg=='' ? printf("help %s", getline("'<")[col("'<")-1:col("'>")-1] ) : printf("!%s %s <bar> less", &keywordprg, getline("'<")[col("'<")-1:col("'>")-1]) : "norm! gv" <cr><CR><CR>

" move line up or down. may add zv to prevent auto refold to level
" ( test only in vim buffer, marker fold, and level )
nnoremap <M-J> :m .+1<CR>
vnoremap <M-J> :m '>+1<CR>gv
vnoremap <M-K> :m '<-2<CR>gv
nnoremap <M-K> :m .-2<CR>
" use F5 to open quick-fix list
nnoremap <F5> :cwin<cr>
nnoremap <S-F5> :lwin<cr>
nmap <F17> <S-F5>
nmap <Leader><F5> <S-F5>
noremap <M-a> <C-\><C-N>ggVG
noremap <M-c> "*y
noremap <M-s> :<C-U>confirm w<CR>
inoremap <M-s> <C-o>:<C-U>confirm w<CR>
noremap <M-S> :<C-U>confirm wa<CR>
inoremap <C-c><C-c> <C-o>:confirm x<CR>
"}}}

""""""""""" visual map {{{
" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
"}}}

""""""""" insert map {{{
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

" easier horizontal scroll
map zl zL
map zh zH

" alt + f b, word move
map! <M-f> <S-Right>
map! <M-b> <S-Left>
map <M-H> <home>
map <M-L> <end>
noremap! <C-D> <Del>

" alt + d, del word
inoremap <M-d> <C-O>de
cnoremap <M-d> <C-\>eForwordDeleteWordInCmd()<CR>
cnoremap <C-L> <C-D>
" insert visual mode
inoremap <M-v> <C-O>v
inoremap <M-V> <C-O>V
inoremap <M-C-v> <C-O><C-v>
" insert yank
inoremap <M-y> <C-O>y
inoremap <M-Y> <C-O>Y

" ii,jf,fj,jk 退出插入模式
" left hand have too many work. here use right hand
inoremap jk <ESC>
" :: 执行命令行
" inoremap :: <C-O>:

" command+return 插入新行
inoremap <D-CR> <End><CR>
inoremap <S-CR> <End><CR>
inoremap <D-S-CR> <C-O>^<CR><UP>
" alt + oO
inoremap <M-o> <C-O>o
inoremap <M-O> <C-O>O
" map some EX completion
inoremap <C-]> <C-X><C-]>
" map tab to show completion

"}}}

""""""""""" command map {{{
cnoremap <C-X><C-L> <C-L>
cnoremap <C-X><C-A> <C-A>
" use ctrl-A to move to begin, according to term
cnoremap <C-A> <C-B>
cnoremap <C-]> <C-\>eSearchCharInCmd(1,1)<CR>
" ctrl-K kill line
cnoremap <C-K> <C-\>egetcmdpos()==1?"" :getcmdline()[:getcmdpos()-2]<CR>
cnoremap <C-X><C-K> <C-K>
" <M-]> to search backword
cnoremap <M-]> <C-\>eSearchCharInCmd(0,0)<CR>
" sudo
cabbrev w!! w !sudo tee % >/dev/null
" search occur
" cnoremap <C-o> <CR>:lvim//j % <bar>lwin<CR>
"}}}


" my-keybinding space category {{{
" use a leader as group map. inspired by Spacemacs
" in insert mode, leader is <M-m>
" in other mode, leader is <Space>
imap <M-m> <C-o><Space>
" mode reserved key <Space>m
imap <M-CR> <C-o><Space>m
map <M-CR> <Space>m
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
" new tab
nnoremap <Space>ts <C-W>s<C-W>T
nnoremap <Space>tn :<C-U>silent tabnew<CR>
nnoremap <Space>te :<C-U>tabe<Space>
nnoremap <Space>t] :<C-U>tab tag <C-R><C-W><CR>
nnoremap <Space>tg] :<C-U>tab tjump <C-R><C-W><CR>
nnoremap <Space>t} :<C-U>tab tjump /.*<C-R><C-W>.*<CR>
vnoremap <Space>t] :<C-U>tab tag <C-R>=GetVisualString()<CR><CR>
vnoremap <Space>tg] :<C-U>tab tjump <C-R>=GetVisualString()<CR><CR>
" close tab
nnoremap <Space>tc :<C-U>confirm =v:count?v:count :""tabclose<CR>
nnoremap <Space>tC :<C-U>silent windo quit!<CR>
nnoremap <Space>to :<C-U>confirm =v:count?v:count :""tabonly<CR>
" tab do
nnoremap <Space>t: :<C-U>tabdo<Space>
"}}}
""" windows"{{{
nnoremap <C-W>e :<C-U>sp<Space>
nnoremap <C-W>o :<C-U>confirm =v:count?v:count :""only<CR>
nnoremap <C-W><C-O> :<C-U>confirm =v:count?v:count :""only<CR>
nnoremap <M-Left> <C-W>h
nnoremap <M-Right> <C-W>l
nnoremap <M-Up> <C-W>k
nnoremap <M-Down> <C-W>j
"}}}
""" project keys"{{{
nnoremap <Space>pf :<C-U>Unite -start-insert file_rec/git<CR>
nnoremap <D-p> :<C-U>CtrlP<CR>
nnoremap <Space>pr :<C-U>CtrlPMRUFiles<CR>
nnoremap <Space>p/ :<C-U>Ack! '<C-R><C-W>'<Left>
vnoremap <Space>p/ :<C-U>Ack! '<C-R>=GetVisualString()<CR>'<Left>
nnoremap <Space>m/ :<C-U>Ack! --<C-R>=&ft<CR> '<C-R><C-W>'<Left>
vnoremap <Space>m/ :<C-U>Ack! --<C-R>=&ft<CR> '<C-R>=GetVisualString()<CR>'<Left>
"  git version control
nnoremap <Space>gs :Gstatus<CR>z15<CR>
nnoremap <Space>gd :<C-U>Gdiff <C-R>=v:count == v:count1?"@~".v:count : ""<CR><CR>
nnoremap <Space>gD :<C-U>Gvdiff <C-R>=v:count == v:count1?"@~".v:count : ""<CR><CR>
nnoremap <Space>gb :Gblame<CR>
nnoremap <Space>gcd :Gcd<CR>
nnoremap <Space>gf :Gfetch<CR>
nnoremap <Space>gF :Gpull --rebase<CR>
nnoremap <Space>gp :Git push<CR>
nnoremap <Space>gw :Gwrite<CR>
nnoremap <Space>gr :<C-U>Gread <C-R>=v:count?"@~".v:count : ""<CR><CR>
vnoremap <Space>gr :Gread <C-R>=v:count?"@~".v:count : ""<CR><CR>
nnoremap <Space>gl :Glog -n 30<CR>
vnoremap <Space>gl :Glog -n 30<CR>
""}}}
""" quickFix"{{{
nnoremap <Space>Q :<C-U>cwin<CR>
nnoremap <Space>q :<C-U>lwin<CR>
nnoremap <Space>qs :<C-U>lvim/<C-R><C-W>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(6)<CR><BS>
nnoremap <Space>qgs :<C-U>lvimgrepadd/<C-R><C-W>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(13)<CR><BS>
vnoremap <Space>qs :<C-U>lvim/<C-R>=GetVisualString()<CR>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(6)<CR><BS>
vnoremap <Space>qgs :<C-U>lvimgrepadd/<C-R>=GetVisualString()<CR>/j<Space><C-R>%<bar>lwin<C-R>=setcmdpos(13)<CR><BS>
" navigate at item
nnoremap <Space>qn :<C-U><C-R>=v:count1<CR>lnext<CR>
nnoremap <Space>Qn :<C-U><C-R>=v:count1<CR>cnext<CR>
nnoremap <Space>qp :<C-U><C-R>=v:count1<CR>lNext<CR>
nnoremap <Space>Qp :<C-U><C-R>=v:count1<CR>cNext<CR>
nnoremap <Space>qq :<C-U>ll<C-R>=v:count1<CR><CR>
nnoremap <Space>QQ :<C-U>cc<C-R>=v:count1<CR><CR>
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
vnoremap <Space>Q* :<C-U>Ack! <C-R>=GetVisualString()<CR><CR>
nnoremap <Space>q/ :<C-U>LAck!<Space>
nnoremap <Space>q* :<C-U>LAck! <C-R><C-W><CR>
vnoremap <Space>q* :<C-U>LAck! <C-R>=GetVisualString()<CR><CR>
"}}}
""" search "{{{
nmap <Space>sp <Space>p/
vmap <Space>sp <Space>p/
nmap <Space>sm <Space>m/
vmap <Space>sm <Space>m/
"}}}
""" buffer"{{{
nnoremap <Space>bw :<C-U>confirm w<CR>
nnoremap <Space>bx :<C-U>confirm x<CR>
nnoremap <Space>bd :<C-U>confirm bdelete<CR>
nnoremap <Space>bb :<C-U>Unite buffer<CR>
nnoremap <Space>bs :<C-U>sb<Space>
nnoremap <Space>bv :<C-U>vert sb<Space>
nnoremap <Space>bt :<C-U>tab sb<Space>
nnoremap <Space>bl :<C-U>Unite -start-insert buffer<CR>
nmap <M-tab> <Space>bl
" quit buffer and open previous buffer
nnoremap <Space>bq <C-^>:bd #<CR>
""}}}
""" file"{{{
nnoremap <Space>fs :<C-U>confirm w<CR>
nnoremap <Space>fS :<C-U>confirm wa<CR>
nnoremap <Space>ft :<C-U>sp ~/.vim/ftplugin/<C-R>=&ft<CR>.vim<CR>
nnoremap <Space>fr :<C-U>CtrlPMRUFiles<CR>
nnoremap <Space>ff :<C-U>CtrlP<CR>
"}}}
""" text"{{{
nnoremap <Space>xw :TrimWhiteSpace<CR>
vnoremap <Space>xw :TrimWhiteSpace<CR>
nnoremap <Space>xl :TrimMultiEmptyLine<CR>
vnoremap <Space>xl :TrimMultiEmptyLine<CR>

nnoremap <Space>xs :s/\V\<<C-R><C-W>\>//gc<Left><Left><Left><C-F>i
vnoremap <Space>xs :<C-U><C-R>=v:count > 1? ".,.+".(v:count-1) : ""<CR>s/\V<C-R>=GetVisualString()<CR>//gc<Left><Left><Left><C-F>i
vnoremap g& :s//~/&<CR>

nnoremap <Space>xS :s/ /\r/g<CR>
vnoremap <Space>xS :s/ /\r/g<CR>

nnoremap <Space>x( :call SurroundSpaceBetweenPairs('(',')')<CR>
nnoremap <Space>x) :call SurroundSpaceBetweenPairs('(',')')<CR>
nnoremap <Space>x[ :call SurroundSpaceBetweenPairs('\[','\]')<CR>
nnoremap <Space>x] :call SurroundSpaceBetweenPairs('\[','\]')<CR>
vnoremap <Space>x( :call SurroundSpaceBetweenPairs('(',')')<CR>
vnoremap <Space>x) :call SurroundSpaceBetweenPairs('(',')')<CR>
vnoremap <Space>x[ :call SurroundSpaceBetweenPairs('\[','\]')<CR>
vnoremap <Space>x] :call SurroundSpaceBetweenPairs('\[','\]')<CR>
"}}}
""" misc"{{{
nnoremap <leader><Space>s :<C-U>Scratch<Space>
nnoremap <leader><Space>sp :<C-U>Scratch<Space>tmp.py<CR>
nnoremap <leader><Space>ss :<C-U>Scratch<Space>tmp.sh<CR>

nnoremap <Space><C-]> :<C-U>tjump /.*<C-R><C-W>.*<CR>
nnoremap <Space><C-W>] :<C-U>stjump /.*<C-R><C-W>.*<CR>
nnoremap <Space><C-W>} :<C-U>ptjump /.*<C-R><C-W>.*<CR>

nnoremap <Space><Tab> [I:let n = input("Which one: ")<Bar>if n > 0 <BAR>exe "normal" n."[\t" <BAR>endif<CR>
vnoremap <Space><Tab> :<C-U>let pat=GetVisualString()<CR>:ilist /<C-R>=pat<CR>/<CR>:let n = input("Which one: ")<BAR>if n > 0<BAR>exe "ijump" n "/".pat."/"<BAR>endif<CR>

" <M-x> cmdline window
nnoremap <M-x> q:i
vnoremap <M-x> q:i
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
" fold
nnoremap z% v%zf
""}}}
" }}}
