" =============================================================================
" Filename: autoload/lightline/colorscheme/16color.vim
" Author: itchyny
" License: MIT License
" Last Change: 2014/01/02 10:04:03.
" =============================================================================

if exists("*lightline#colorscheme#base16_solarized_custom#gen")
  finish
endif

function! lightline#colorscheme#base16_solarized_custom#gen()

let s:base03  = [ '#002b36', 8 ]
let s:base02  = [ '#073642', 0 ]
let s:base01  = [ '#586e75', 10 ]
let s:base00  = [ '#657b83', 11  ]
let s:base0   = [ '#839496', 12 ]
let s:base1   = [ '#93a1a1', 14 ]
let s:base2   = [ '#eee8d5', 7 ]
let s:base3   = [ '#fdf6e3', 15 ]
let s:yellow  = [ '#b58900', 3 ]
let s:orange  = [ '#cb4b16', 9 ]
let s:red     = [ '#dc322f', 1 ]
let s:magenta = [ '#d33682', 5 ]
let s:violet  = [ '#6c71c4', 13 ]
let s:blue    = [ '#268bd2', 4 ]
let s:cyan    = [ '#2aa198', 6 ]
let s:green   = [ '#859900', 2 ]

if &background ==# 'light'
  let [s:base03, s:base3] = [s:base3, s:base03]
  let [s:base02, s:base2] = [s:base2, s:base02]
  let [s:base01, s:base1] = [s:base1, s:base01]
  let [s:base00, s:base0] = [s:base0, s:base00]
endif

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:base3, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base0 ], [ s:base1, s:base01 ] ]
let s:p.insert.left = [ [ s:base3, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base3, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base3, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]

let s:p.inactive.right = [ [ s:base02, s:base01 ], [ s:base00, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base02, s:base01 ], [ s:base00, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]

let s:p.tabline.left = [ [ s:base2, s:base01 ] ]
let s:p.tabline.tabsel = [ [ s:base2, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base2 ] ]
let s:p.tabline.right = copy(s:p.normal.right)

let s:p.normal.error = [ [ s:base2, s:red ] ]
let s:p.normal.warning = [ [ s:base02, s:yellow ] ]

" echom 'load script base16'
let g:lightline#colorscheme#base16_solarized_custom#palette = lightline#colorscheme#flatten(s:p)

endfunction

call lightline#colorscheme#base16_solarized_custom#gen()

augroup lightline_base16
    au!
    autocmd ColorScheme * call lightline#colorscheme#base16_solarized_custom#gen() | call lightline#colorscheme()
augroup END
