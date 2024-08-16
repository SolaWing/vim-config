-- [nfnl] Compiled from fnl/config/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("config.util")
_G.fun = require("deps.fun")
local function colorfgbg()
  local tmp_3_auto = vim.env.COLORFGBG
  if (nil ~= tmp_3_auto) then
    local tmp_3_auto0 = vim.split(tmp_3_auto, ";")
    if (nil ~= tmp_3_auto0) then
      local tmp_3_auto1
      if (nil ~= tmp_3_auto0) then
        local t = tmp_3_auto0
        tmp_3_auto1 = t[#t]
      else
        tmp_3_auto1 = nil
      end
      if (nil ~= tmp_3_auto1) then
        return tonumber(tmp_3_auto1)
      else
        return nil
      end
    else
      return nil
    end
  else
    return nil
  end
end
local function init()
  _G.F = {}
  local _5_
  do
    local tmp_3_auto = vim.env.COLORTERM
    if (nil ~= tmp_3_auto) then
      _5_ = vim.stricmp(tmp_3_auto, "truecolor")
    else
      _5_ = nil
    end
  end
  if (_5_ == 0) then
    vim.o.termguicolors = true
  else
  end
  do
    local _8_ = colorfgbg()
    if (nil ~= _8_) then
      local color = _8_
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
    return require("config.vscode.init").init()
  else
    vim.env.FZF_LUA_NVIM_BIN = "nvim"
    return vim.cmd("source ~/.vimrc\n                source ~/.vim/nvimafterinit.vim")
  end
end
return {init = init}
