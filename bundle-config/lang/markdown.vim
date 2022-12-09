" 体验不够好
Plug 'godlygeek/tabular', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown'

" Plug 'euclio/vim-markdown-composer'
" Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
let g:vim_markdown_math = 1
let g:vim_markdown_folding_style_pythonic = 1
" fix ]c conflict with diff
map ]h <Plug>Markdown_MoveToCurHeader
" let g:vim_markdown_new_list_item_indent = 2
" Plug 'vim-pandoc/vim-pandoc'

" Plug 'vimwiki/vimwiki'
" let g:vimwiki_list = [{'path': '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/mine',
"             \ 'syntax': 'markdown', 'ext': '.md'}]
" let g:vimwiki_map_prefix = "<Space>."
