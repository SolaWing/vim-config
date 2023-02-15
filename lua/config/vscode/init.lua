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
  local function _1_()
    return VSCodeNotify("editor.action.revealDeclaration")
  end
  remap_key("<LocalLeader>gd", _1_)
  local function _2_()
    return VSCodeNotify("editor.action.revealDefinitionAside")
  end
  remap_key("<C-w><M-g>", _2_)
  remap_key("<C-w><LocalLeader>gg", "<C-w><M-g>")
  local function _3_()
    return VSCodeNotify("editor.action.quickFix")
  end
  remap_key("<LocalLeader>gf", _3_)
  local function _4_()
    return VSCodeNotify("outline.focus")
  end
  vim.keymap.set({"n"}, "<F3>", _4_)
  local function _5_()
    return VSCodeNotify("workbench.files.action.showActiveFileInExplorer")
  end
  vim.keymap.set({"n"}, "-", _5_)
  local function _6_()
    return VSCodeNotify("workbench.scm.focus")
  end
  vim.keymap.set({"n"}, "<Leader>gs", _6_)
  local function _7_()
    return VSCodeNotify("gitlens.toggleFileBlame")
  end
  vim.keymap.set({"n"}, "<Leader>gb", _7_)
  local function _8_()
    return VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")
  end
  vim.keymap.set({"n"}, "<Leader>bl", _8_)
  local function _9_(_241)
    return VSCodeNotify("workbench.action.quickOpen", ("@" .. (_241.args or "")))
  end
  vim.api.nvim_create_user_command("FZBTags", _9_, {nargs = "?"})
  local function _10_(_241)
    return VSCodeNotify("workbench.action.quickOpen", ("#" .. (_241.args or "")))
  end
  vim.api.nvim_create_user_command("FZTags", _10_, {nargs = "?"})
  local function _11_()
    return VSCodeNotify("workbench.action.switchWindow")
  end
  vim.api.nvim_create_user_command("FZWindows", _11_, {})
  local function _12_()
    return VSCodeNotify("workbench.action.openSettingsJson")
  end
  remap_key("<Leader>e,", _12_)
  local function _13_()
    return VSCodeNotify("workbench.action.openGlobalKeybindings")
  end
  remap_key("<Leader>ek", _13_)
  remap_key("<C-w>o", "<Cmd>only<CR>")
  return remap_key("<Leader>to", "<Cmd>tabonly<CR>")
end
_2amodule_locals_2a["keybinding"] = keybinding
local function plugins()
  local function Plug(...)
    return vim.fn["plug#"](...)
  end
  vim.fn["plug#begin"]("~/.vim/bundle")
  vim.cmd.source("~/.vim/bundle-config/easymotion.vim")
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
  do end (vim.opt.runtimepath):remove((os.getenv("HOME") .. "/.config/nvim"))
  do end (vim.opt.runtimepath):prepend((os.getenv("HOME") .. "/.config/nvim/vscode"))
  print("neovim in vscode", vim.o.runtimepath)
  require("config.vscode.bind")
  settings()
  plugins()
  return keybinding()
end
_2amodule_2a["init"] = init
return _2amodule_2a