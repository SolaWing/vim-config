" source ~/.vim/bundle-config/tagbar.vim
source ~/.vim/bundle-config/vista.vim
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_file_list_command = {
            \   'markers': {
            \   '.git': $'bash {expand("<sfile>:h")}/tagsfile.sh'
            \   },
            \ }
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
" let g:gutentags_trace = 1

" gtags
" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

if !has("nvim-0.9")
	" set cscopeprg=set cscopetag " 使用 cscope 作为 tags 命令
	set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
	"gtags.vim 设置项

	" let GtagsCscope_Auto_Load = 0
	" let CtagsCscope_Auto_Map = 0
	" let GtagsCscope_Quiet = 1
endif
