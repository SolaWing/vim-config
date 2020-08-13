Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
nmap g/  <plug>(GrepperOperator)
xmap g/  <plug>(GrepperOperator)
let g:grepper = {
            \   'tools': ['rg', 'git'],
            \   }

