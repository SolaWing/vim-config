
autocmd mine BufEnter,FileChangedShellPost * call CacheClear("fugitive#head")
function! CachedFugitiveHead()
    return CacheWrap("FugitiveHead")
endfunction
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline = {
            \   'colorscheme' : 'gruvbox_custom',
            \   'active': {
            \     'left': [ [ 'mode', 'paste' ], ['readonly', 'relativepath', 'modified' ], [ 'gitbranch',  'cocstatus', 'ycmstatus' ] ],
            \     'right': [ [ 'percent' ],
            \                [ 'lineinfo' ],
            \                ['linter_errors', 'linter_warnings',
            \                 'fileformat', 'fileencoding', 'filetype' ] ]
            \   },
            \   'inactive': {
            \     'left': [ [ 'filename', 'modified' ] ],
            \     'right': [ [ 'percent' ], [ 'lineinfo' ] ]
            \   },
            \   'component_function': {
            \     'gitbranch': 'CachedFugitiveHead',
            \     'cocstatus': 'coc#status',
            \     'ycmstatus': 'youcompleteme#Status'
            \   },
            \   'component_expand': {
            \     'linter_warnings': 'LightlineLinterWarnings',
            \     'linter_errors':   'LightlineLinterErrors',
            \   },
            \   'component_type': {
            \     'linter_warnings': 'warning',
            \     'linter_errors':   'error',
            \   },
            \ }
Plug 'itchyny/lightline.vim'

function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:all_non_errors == 0 ? '' : printf('W%d', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    " let l:all_non_errors = l:counts.total - l:all_errors
    return l:all_errors == 0 ? '' : printf('E%d', all_errors)
endfunction

autocmd mine User ALELint call lightline#update()
