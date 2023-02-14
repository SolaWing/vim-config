local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/vscode/init.fnl"
local _2amodule_name_2a = "config.vscode.init"
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
local function settings()
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","
  vim.g.is_bash = 1
  return nil
end
_2amodule_locals_2a["settings"] = settings
local function keybinding()
  vim.keymap.set({"n", "x"}, "<M-g>", "gd", {remap = true})
  vim.keymap.set({"n", "x"}, "\194\169", "gd", {remap = true})
  vim.keymap.set({"n", "x"}, "<LocalLeader>gg", "gd", {remap = true})
  vim.keymap.set({"n", "x"}, "<LocalLeader>gr", "gH", {remap = true})
  local function _1_()
    return VSCodeNotify("editor.action.revealDeclaration")
  end
  return vim.keymap.set({"n", "x"}, "<LocalLeader>gd", _1_)
end
_2amodule_2a["keybinding"] = keybinding
local function init()
  do end (vim.opt.runtimepath):remove((os.getenv("HOME") .. "/.config/nvim"))
  do end (vim.opt.runtimepath):prepend((os.getenv("HOME") .. "/.config/nvim/vscode"))
  print("neovim in vscode", vim.o.runtimepath)
  require("config.vscode.bind")
  settings()
  return keybinding()
end
_2amodule_2a["init"] = init
return _2amodule_2a