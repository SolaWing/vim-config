(module config.plugs)

(local Plug (. vim.fn :plug#))

(defn- nvim5-common []
  ; nvim5 common plug
  (Plug "nvim-lua/plenary.nvim") ; this seems as a basic lib by many lua plugin; so put it here;
  
  (Plug "nvim-treesitter/nvim-treesitter" {:do ":TSUpdate"})  ; We recommend updating the parsers on update
  (Plug "andymass/vim-matchup") ; nvim-treesitter break % pair by syntax. use replacement

  (set vim.g.matchup_matchparen_deferred 1)
  (set vim.g.matchup_matchparen_deferred_show_delay 200)
  
  ; 这个感觉好像没什么用，而且支持的语言也不全
  (Plug "nvim-treesitter/nvim-treesitter-textobjects")
  (Plug "nvim-treesitter/playground" {:on ["TSPlaygroundToggle"]})
  
  ; 和vim-plug有兼容性问题，vim-plug 结束时会调用filetype, 且忽略did_load_filetypes
  ; Plug "nathom/filetype.nvim"
  
  (vim.cmd "autocmd mine User plug#end ++once luafile ~/.vim/bundle-config/treesitter.lua")
  
  (set vim.g.no_ruby_maps 1) ; ruby map depend on syntax. no work when treesitter enable
  (set vim.g.ruby_no_expensive 1)) ; ruby default synatx make it very slow, though treesitter should disable it

(defn function []
  ; plug相关辅助函数
  (vim.cmd "function! HasPlug(key)
           return has_key(g:plugs, a:key)
           endfunction")
  (fn vim.plug? [name]
    "get big nest may have convert issue.., so define it here"
    (= 1 (vim.fn.HasPlug name))))

(defn init []
  ; 迁移耗时好像没有明显变化。是因为主要耗时在vim调用上吗?

  (function)
  (nvim5-common)

  ; buffer manager, 也许可以使用args列表代替(但是args不会保存)
  (Plug "ThePrimeagen/harpoon")
  (Plug "ThePrimeagen/refactoring.nvim"))
