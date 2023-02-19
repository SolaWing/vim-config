local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/keybinding.fnl"
local _2amodule_name_2a = "config.keybinding"
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
local function infomation()
  local function _1_()
    return print((require("config.function")).CursorContext())
  end
  return vim.keymap.set("n", ",.", _1_)
end
_2amodule_2a["infomation"] = infomation
local function fzf_lua()
end
_2amodule_2a["fzf-lua"] = fzf_lua
local function init()
  infomation()
  if vim["plug?"]("fzf-lua") then
    return fzf_lua()
  else
    return nil
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a