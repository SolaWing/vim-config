(module config.plugs)

(def Plug (. vim.fn :plug#))

(defn nvim-lib []
  "libraries to be dependency by others"
  (Plug "nvim-lua/plenary.nvim")
  ; optional for icon support and nerd font may required, required by fzf-lua, barbar etc 
  (Plug "nvim-tree/nvim-web-devicons")
  (Plug "nvim-treesitter/nvim-treesitter" {:do ":TSUpdate"})) ; We recommend updating the parsers on update

(defn nvim-common []
  (Plug "andymass/vim-matchup" {:on []}) ; nvim-treesitter break % pair by syntax. use replacement
  ; disable original match, this delay may fast 5ms
  (set vim.g.loaded_matchparen 1)
  (set vim.g.loaded_matchit 1)
  (vim.defer_fn #(vim.fn.plug#load "vim-matchup") 1000)

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
  (nvim-lib)
  (nvim-common)

  ; buffer manager, 也许可以使用args列表代替(但是args不会保存)
  (Plug "ThePrimeagen/harpoon")
  (Plug "ThePrimeagen/refactoring.nvim")
  (Plug "ggandor/leap.nvim")
  (Plug "kevinhwang91/nvim-bqf")
  ; require gsed or rust build(broken), slow on large replace when update UI, and will stuck nvim
  (Plug "windwp/nvim-spectre" {:on ["Spectre"]})) ; :do "RUSTFLAGS='-Clink-arg=-undefined -Clink-arg=dynamic_lookup' ./build.sh"}))
  ; 生成方法文档的，先标记上，暂时用不上
  ; (Plug :danymat/neogen))
