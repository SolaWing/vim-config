Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'andymass/vim-matchup' " nvim-treesitter break % pair by syntax. use replacement
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200

" 这个感觉好像没什么用，而且支持的语言也不全
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground', {'on': ['TSPlaygroundToggle']}

" 和vim-plug有兼容性问题，vim-plug 结束时会调用filetype, 且忽略did_load_filetypes
" Plug 'nathom/filetype.nvim'

autocmd mine User plug#end ++once luafile ~/.vim/bundle-config/nvim5.lua

let g:no_ruby_maps = 1 " ruby map depend on syntax. no work when treesitter enable
let g:ruby_no_expensive = 1 " ruby default synatx make it very slow, though treesitter should disable it

function! CursorContext()
    if luaeval('require "nvim-treesitter.parsers".has_parser()')
        return nvim_treesitter#statusline()
    elseif exists("*tagbar#currenttag")
        return tagbar#currenttag("%s", "", "s")
    end
    return v:null
endfunction
