Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
function! _ConfigTreeSitter()
lua <<EOF
    require'nvim-treesitter.configs'.setup {
      highlight = { enable = true, },
      indent = { enable = true, },
      textobjects = { enable = true },
    }
EOF
endfunction
autocmd mine User plug#end ++once call _ConfigTreeSitter()
