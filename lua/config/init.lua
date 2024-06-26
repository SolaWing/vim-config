-- [nfnl] Compiled from fnl/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("config.util")
_G.fun = require("deps.fun")
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
  _G.F = {}
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
  vim.g.python3_host_prog = "/usr/bin/python3"
  if (1 == vim.fn.has("gui_vimr")) then
    vim.env.LANG = "zh_CN.UTF-8"
  else
  end
  if vim.g.neovide then
    vim.g.neovide_input_macos_option_key_is_meta = "only_left"
    vim.g.neovide_cursor_animation_length = 0.02
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_cursor_animate_command_line = false
    vim.o.guifont = "FiraCode Nerd Font Mono:h14"
    vim.o.linespace = 5
  else
  end
  if vim.g.vscode then
    return (require("config.vscode.init")).init()
  else
    vim.env.FZF_LUA_NVIM_BIN = "nvim"
    return vim.cmd("source ~/.vimrc\n                source ~/.vim/nvimafterinit.vim")
  end
end
return {init = init}
