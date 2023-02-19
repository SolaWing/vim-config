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
local function nvim5_common()
  Plug("nvim-lua/plenary.nvim")
  Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})
  Plug("andymass/vim-matchup")
  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_deferred_show_delay = 200
  Plug("nvim-treesitter/nvim-treesitter-textobjects")
  Plug("nvim-treesitter/playground", {on = {"TSPlaygroundToggle"}})
  vim.cmd("autocmd mine User plug#end ++once luafile ~/.vim/bundle-config/treesitter.lua")
  vim.g.no_ruby_maps = 1
  vim.g.ruby_no_expensive = 1
  return Plug("ThePrimeagen/harpoon")
end
_2amodule_locals_2a["nvim5-common"] = nvim5_common
local function init()
  vim.cmd("function! HasPlug(key)\n    return has_key(g:plugs, a:key)\n    endfunction")
  vim["plug?"] = function(name)
    return (1 == vim.fn.HasPlug(name))
  end
  return nvim5_common()
end
_2amodule_2a["init"] = init
return _2amodule_2a