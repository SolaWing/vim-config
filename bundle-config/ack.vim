Plug 'mileszs/ack.vim', { 'on': 'Ack'}
let g:ackhighlight = 1
let g:ackprg = 'rg --vimgrep --smart-case -g "!*.xcodeproj"'
let g:ack_apply_qmappings = 0
let g:ack_apply_lmappings = 0
" this seems to only set fcl = all, will affect other buffer
let g:ack_autofold_results = 1
