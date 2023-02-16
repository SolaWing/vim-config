local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/init.fnl"
local _2amodule_name_2a = "config.init"
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
_G.fun = require("deps.fun")
require("config.util")
local function colorfgbg()
  local _1_ = vim.env.COLORFGBG
  if (nil ~= _1_) then
    local _2_ = vim.split(_1_, ";")
    if (nil ~= _2_) then
      local _3_
      do
        local _4_ = _2_
        if (nil ~= _4_) then
          local t = _4_
          _3_ = t[#t]
        else
          _3_ = nil
        end
      end
      if (nil ~= _3_) then
        return tonumber(_3_)
      else
        return _3_
      end
    else
      return _2_
    end
  else
    return _1_
  end
end
local function init()
  local _10_
  do
    local _9_ = vim.env.COLORTERM
    if (nil ~= _9_) then
      _10_ = vim.stricmp(_9_, "truecolor")
    else
      _10_ = _9_
    end
  end
  if (_10_ == 0) then
    vim.o.termguicolors = true
  else
  end
  do
    local _13_ = colorfgbg()
    if (nil ~= _13_) then
      local color = _13_
      if (color > 8) then
        vim.o.background = "light"
      else
        vim.o.background = "dark"
      end
    else
    end
  end
  vim.o.timeout = false
  vim.o.inccommand = "nosplit"
  vim.o.viewdir = "~/.vim/view"
  vim.o.shada = "!,'999,<50,s10,h,f0"
  vim.g.python_host_prog = "/usr/bin/python"
  vim.g.python3_host_prog = "/usr/local/bin/python3"
  if (1 == vim.fn.has("gui_vimr")) then
    vim.env.LANG = "zh_CN.UTF-8"
  else
  end
  if vim.g.vscode then
    return (require("config.vscode.init")).init()
  else
    vim.ex("source ~/.vimrc")
    return vim.cmd("command! Fish sp | terminal /usr/local/bin/fish -l\n        command! -bang Bwipeout lua require('config.function').Bwipeout('<bang>')")
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a