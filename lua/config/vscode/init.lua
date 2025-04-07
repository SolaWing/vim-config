-- [nfnl] Compiled from fnl/config/vscode/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("config.plugs")
local Plug = _local_1_["Plug"]
local _function = _local_1_["function"]
local vscode = require("vscode")
local function settings()
  vim.cmd("augroup mine | augroup end")
  vim.g.mapleader = " "
  vim.g.maplocalleader = ","
  vim.g.is_bash = 1
  vim.cmd("\n           command! -nargs=1 KeepCursor call KeepCursor(<q-args>)\n           command! -nargs=1 -complete=mapping -bar Map nmap <args>| xmap <args>| omap <args>\n           command! -nargs=1 -complete=mapping -bar Noremap nnoremap <args>| xnoremap <args>| onoremap <args>\n           ")
  vim.g.hasCOC = false
  return nil
end
local function keybinding()
  vim.cmd.source("~/.vim/meta-keybinding.vim")
  vim.cmd.source("~/.vim/key-binding.vim")
  local function remap_key(from, to)
    return vim.keymap.set({"n", "x"}, from, to, {remap = true})
  end
  local function _2_()
    local function _3_()
      return vscode.action("editor.action.addSelectionToNextFindMatch")
    end
    return vscode.with_insert(_3_)
  end
  remap_key("<C-n>", _2_)
  remap_key("<M-g>", "<C-]>")
  remap_key("<LocalLeader>gg", "<C-]>")
  remap_key("<LocalLeader>gr", "gH")
  local function _4_()
    return vscode.action("editor.action.revealDeclaration")
  end
  remap_key("<LocalLeader>gd", _4_)
  local function _5_()
    return vscode.action("editor.action.revealDefinitionAside")
  end
  remap_key("<C-w><M-g>", _5_)
  remap_key("<C-w><LocalLeader>gg", "<C-w><M-g>")
  local function _6_()
    return vscode.action("editor.action.quickFix")
  end
  remap_key("<LocalLeader>gf", _6_)
  local function _7_()
    return vscode.action("outline.focus")
  end
  vim.keymap.set({"n"}, "<F3>", _7_)
  local function _8_()
    return vscode.action("workbench.files.action.showActiveFileInExplorer")
  end
  vim.keymap.set({"n"}, "-", _8_)
  local function _9_()
    return vscode.action("workbench.scm.focus")
  end
  vim.keymap.set({"n"}, "<Leader>gs", _9_)
  local function _10_()
    return vscode.action("gitlens.toggleFileBlame")
  end
  vim.keymap.set({"n"}, "<Leader>gb", _10_)
  local function _11_()
    return vscode.action("workbench.action.showAllEditorsByMostRecentlyUsed")
  end
  vim.keymap.set({"n"}, "<Leader>bl", _11_)
  local function _12_(_241)
    return vscode.action("workbench.action.quickOpen", ("@" .. (_241.args or "")))
  end
  vim.api.nvim_create_user_command("FZBTags", _12_, {nargs = "?"})
  local function _13_(_241)
    return vscode.action("workbench.action.quickOpen", ("#" .. (_241.args or "")))
  end
  vim.api.nvim_create_user_command("FZTags", _13_, {nargs = "?"})
  local function _14_()
    return vscode.action("workbench.action.switchWindow")
  end
  vim.api.nvim_create_user_command("FZWindows", _14_, {})
  local function _15_()
    return vscode.action("workbench.action.openSettingsJson")
  end
  remap_key("<Leader>e,", _15_)
  local function _16_()
    return vscode.action("workbench.action.openGlobalKeybindings")
  end
  remap_key("<Leader>ek", _16_)
  remap_key("<C-w>o", "<Cmd>Only<CR>")
  remap_key("<Leader>to", "<Cmd>Tabonly<CR>")
  return remap_key("<Leader>tc", "<Cmd>Tabclose<CR>")
end
local function plugins()
  vim.fn["plug#begin"]("~/.vim/bundle")
  Plug("ggandor/leap.nvim")
  vim.cmd.source("~/.vim/bundle-config/sneak.vim")
  vim.cmd.source("~/.vim/bundle-config/tpope.vim")
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
local function init()
  local config_path = vim.fn.stdpath("config")
  vim.opt.runtimepath:remove(config_path)
  vim.opt.runtimepath:prepend((config_path .. "/vscode-nvim"))
  print("neovim in vscode")
  require("config.vscode.bind")
  _function()
  settings()
  plugins()
  return keybinding()
end
return {init = init}
