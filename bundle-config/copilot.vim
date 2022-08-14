Plug 'github/copilot.vim', {'on': ['Copilot']}
command! -nargs=* CopilotLoad call plug#load('copilot.vim') | echo "Copilot loaded"

let g:copilot_filetypes = {
            \ 'markdown': v:false,
            \ 'text': v:false,
            \ 'python': v:true,
            \ 'ruby': v:true,
            \ 'rust': v:true,
            \ 'typescript': v:true,
            \ 'javascript': v:true,
            \ 'sh': v:true,
            \ 'swift': v:true,
            \ 'c': v:true,
            \ 'cpp': v:true,
            \ 'objc': v:true,
            \ }

imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
" let g:copilot_ignore_node_version = v:true
let g:copilot_node_command = "~/.nodenv/versions/17.9.1/bin/node"
