Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'andymass/vim-matchup' " nvim-treesitter break % pair by syntax. use replacement
" 这个感觉好像没什么用，而且支持的语言也不全
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground', {'on': ['TSPlaygroundToggle']}
function! _ConfigTreeSitter()
    luafile ~/.vim/bundle-config/nvim5.lua
endfunction
autocmd mine User plug#end ++once call _ConfigTreeSitter()

let g:no_ruby_maps = 1 " ruby map depend on syntax. no work when treesitter enable
let g:ruby_no_expensive = 1 " ruby default synatx make it very slow, though treesitter should disable it
