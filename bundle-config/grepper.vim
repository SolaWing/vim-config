Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
let g:grepper = {
            \   'tools': ['rg', 'git'],
            \   }

