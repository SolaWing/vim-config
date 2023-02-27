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
local _local_1_ = require("config.plugs")
local _local_2_ = _local_1_
local Plug = _local_2_["Plug"]
local _function = _local_2_["function"]
_2amodule_locals_2a["Plug"] = Plug
_2amodule_locals_2a["function"] = _function
local function settings()
  vim.cmd("augroup mine | augroup end")
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","
  vim.g.is_bash = 1
  vim.cmd("\n           command! -nargs=1 KeepCursor call KeepCursor(<q-args>)\n           command! -nargs=1 -complete=mapping -bar Map nmap <args>| xmap <args>| omap <args>\n           command! -nargs=1 -complete=mapping -bar Noremap nnoremap <args>| xnoremap <args>| onoremap <args>\n           ")
  vim.g.hasCOC = false
  return nil
end
_2amodule_locals_2a["settings"] = settings
local function keybinding()
  vim.cmd.source("~/.vim/meta-keybinding.vim")
  vim.cmd.source("~/.vim/key-binding.vim")
  local function remap_key(from, to)
    return vim.keymap.set({"n", "x"}, from, to, {remap = true})
  end
  remap_key("<M-g>", "<C-]>")
  remap_key("<LocalLeader>gg", "<C-]>")
  remap_key("<LocalLeader>gr", "gH")
  local function _3_()
    return VSCodeNotify("editor.action.revealDeclaration")
  end
  remap_key("<LocalLeader>gd", _3_)
  local function _4_()
    return VSCodeNotify("editor.action.revealDefinitionAside")
  end
  remap_key("<C-w><M-g>", _4_)
  remap_key("<C-w><LocalLeader>gg", "<C-w><M-g>")
  local function _5_()
    return VSCodeNotify("editor.action.quickFix")
  end
  remap_key("<LocalLeader>gf", _5_)
  local function _6_()
    return VSCodeNotify("outline.focus")
  end
  vim.keymap.set({"n"}, "<F3>", _6_)
  local function _7_()
    return VSCodeNotify("workbench.files.action.showActiveFileInExplorer")
  end
  vim.keymap.set({"n"}, "-", _7_)
  local function _8_()
    return VSCodeNotify("workbench.scm.focus")
  end
  vim.keymap.set({"n"}, "<Leader>gs", _8_)
  local function _9_()
    return VSCodeNotify("gitlens.toggleFileBlame")
  end
  vim.keymap.set({"n"}, "<Leader>gb", _9_)
  local function _10_()
    return VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")
  end
  vim.keymap.set({"n"}, "<Leader>bl", _10_)
  local function _11_(_241)
    return VSCodeNotify("workbench.action.quickOpen", ("@" .. (_241.args or "")))
  end
  vim.api.nvim_create_user_command("FZBTags", _11_, {nargs = "?"})
  local function _12_(_241)
    return VSCodeNotify("workbench.action.quickOpen", ("#" .. (_241.args or "")))
  end
  vim.api.nvim_create_user_command("FZTags", _12_, {nargs = "?"})
  local function _13_()
    return VSCodeNotify("workbench.action.switchWindow")
  end
  vim.api.nvim_create_user_command("FZWindows", _13_, {})
  local function _14_()
    return VSCodeNotify("workbench.action.openSettingsJson")
  end
  remap_key("<Leader>e,", _14_)
  local function _15_()
    return VSCodeNotify("workbench.action.openGlobalKeybindings")
  end
  remap_key("<Leader>ek", _15_)
  remap_key("<C-w>o", "<Cmd>Only<CR>")
  return remap_key("<Leader>to", "<Cmd>Tabonly<CR>")
end
_2amodule_locals_2a["keybinding"] = keybinding
local function plugins()
  vim.fn["plug#begin"]("~/.vim/bundle")
  vim.cmd.source("~/.vim/bundle-config/easymotion.vim")
  Plug("ggandor/leap.nvim")
  vim.cmd.source("~/.vim/bundle-config/sneak.vim")
  vim.cmd.source("~/.vim/bundle-config/tpope.vim")
  Plug("tpope/vim-fugitive", {on = {}})
  Plug("tpope/vim-rhubarb", {on = {}})
  Plug("junegunn/gv.vim", {on = {}})
  Plug("google/vim-searchindex")
  vim.g.searchindex_line_limit = 20000
  Plug("kshenoy/vim-signature")
  vim.g.SignaturePeriodicRefresh = 0
  vim.g.SignatureUnconditionallyRecycleMarks = 1
  vim.cmd.source("~/.vim/bundle-config/devdocs.io.vim")
  Plug("tpope/vim-bundler", {["for"] = "ruby"})
  Plug("tpope/vim-rake", {["for"] = "ruby"})
  vim.fn["plug#end"]()
  return vim.cmd("silent doautocmd <nomodeline> User plug#end")
end
_2amodule_locals_2a["plugins"] = plugins
local function init()
  local config_path = vim.fn.stdpath("config")
  do end (vim.opt.runtimepath):remove(config_path)
  do end (vim.opt.runtimepath):prepend((config_path .. "/vscode"))
  print("neovim in vscode", vim.o.runtimepath)
  require("config.vscode.bind")
  _function()
  settings()
  plugins()
  return keybinding()
end
_2amodule_2a["init"] = init
return _2amodule_2a