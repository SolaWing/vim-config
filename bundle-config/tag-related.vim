source ~/.vim/bundle-config/tagbar.vim

" gtags
" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

" set cscopeprg=set cscopetag " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
"gtags.vim 设置项

" let GtagsCscope_Auto_Load = 0
" let CtagsCscope_Auto_Map = 0
" let GtagsCscope_Quiet = 1
