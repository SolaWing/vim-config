local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/plugs.fnl"
local _2amodule_name_2a = "config.plugs"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local Plug = vim.fn["plug#"]
_2amodule_2a["Plug"] = Plug
local function nvim5_common()
  Plug("nvim-lua/plenary.nvim")
  Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})
  Plug("andymass/vim-matchup", {on = {}})
  vim.g.loaded_matchparen = 1
  vim.g.loaded_matchit = 1
  local function _1_()
    return vim.fn["plug#load"]("vim-matchup")
  end
  vim.defer_fn(_1_, 1000)
  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_deferred_show_delay = 200
  Plug("nvim-treesitter/nvim-treesitter-textobjects")
  Plug("nvim-treesitter/playground", {on = {"TSPlaygroundToggle"}})
  vim.cmd("autocmd mine User plug#end ++once luafile ~/.vim/bundle-config/treesitter.lua")
  vim.g.no_ruby_maps = 1
  vim.g.ruby_no_expensive = 1
  return nil
end
_2amodule_2a["nvim5-common"] = nvim5_common
local function _function()
  vim.cmd("function! HasPlug(key)\n           return has_key(g:plugs, a:key)\n           endfunction")
  vim["plug?"] = function(name)
    return (1 == vim.fn.HasPlug(name))
  end
  return vim["plug?"]
end
_2amodule_2a["function"] = _function
local function init()
  _function()
  nvim5_common()
  Plug("ThePrimeagen/harpoon")
  Plug("ThePrimeagen/refactoring.nvim")
  return Plug("ggandor/leap.nvim")
end
_2amodule_2a["init"] = init
return _2amodule_2a