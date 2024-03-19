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
local function nvim_lib()
  Plug("nvim-lua/plenary.nvim")
  Plug("nvim-tree/nvim-web-devicons")
  return Plug("nvim-treesitter/nvim-treesitter", {["do"] = ":TSUpdate"})
end
_2amodule_2a["nvim-lib"] = nvim_lib
local function nvim_common()
  Plug("andymass/vim-matchup")
  vim.g.loaded_matchparen = 1
  vim.g.loaded_matchit = 1
  vim.g.matchup_matchparen_deferred = 1
  vim.g.matchup_matchparen_deferred_show_delay = 200
  Plug("nvim-treesitter/nvim-treesitter-textobjects")
  Plug("nvim-treesitter/playground", {on = {"TSPlaygroundToggle"}})
  vim.g.no_ruby_maps = 1
  vim.g.ruby_no_expensive = 1
  return nil
end
_2amodule_2a["nvim-common"] = nvim_common
local function _function()
  vim.cmd("function! HasPlug(key)\n           return has_key(g:plugs, a:key)\n           endfunction")
  vim["plug?"] = function(name)
    return (1 == vim.fn.HasPlug(name))
  end
  _G.luafile = function(path)
    local _1_, _2_ = loadfile(vim.fs.normalize(path))
    if (true and (nil ~= _2_)) then
      local _ = _1_
      local err = _2_
      return error(err)
    elseif ((nil ~= _1_) and (_2_ == nil)) then
      local f = _1_
      return f()
    else
      return nil
    end
  end
  return _G.luafile
end
_2amodule_2a["function"] = _function
local function init()
  _function()
  nvim_lib()
  nvim_common()
  Plug("git@code.byted.org:chenjiaqi.cposture/codeverse.vim.git", {on = {"Codeverse"}})
  Plug("ThePrimeagen/harpoon")
  Plug("ThePrimeagen/refactoring.nvim")
  Plug("ggandor/leap.nvim")
  Plug("windwp/nvim-spectre", {on = {"Spectre"}})
  return vim.cmd("autocmd mine User plug#end ++once lua require('config.plugs').after()")
end
_2amodule_2a["init"] = init
local function after()
  luafile("~/.vim/lua/config/plug/treesitter.lua")
  do end (require("config.plug.codeverse")).setup()
  local function _4_()
    return (require("config.plug.fzf-lua")).setup()
  end
  _G["hook-require"]("fzf-lua", "setup", _4_)
  local function _5_()
    return (require("config.plug.bqf")).setup()
  end
  _G["hook-require"]("bqf", "setup", _5_)
  local function _6_()
    return (require("config.plug.refactoring")).setup()
  end
  return _G["hook-require"]("refactoring", "setup", _6_)
end
_2amodule_2a["after"] = after
return _2amodule_2a