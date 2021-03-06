let g:ale_lint_delay = 5000
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ 'javascript' :[ 'eslint' ],
            \ 'swift' : ['swiftlint'],
            \ 'php': ['php'],
            \ 'python': ['flake8']
            \ }
            " \ 'sql': ['sqlint'],
let g:ale_fixers = {
            \ 'javascript': ['remove_trailing_lines', 'trim_whitespace', 'eslint'],
            \ 'python': ['yapf'],
            \ 'ruby': ['rubocop']
            \}
" let g:ale_completion_enabled = 1
" let g:ycm_filetype_specific_completion_to_disable = {
"             \ 'rust': 1
"             \}
if has_key(g:plugs, "coc.nvim")
    call remove(g:ale_linters, 'javascript')
    call remove(g:ale_fixers, 'javascript')
endif
Plug 'w0rp/ale'
