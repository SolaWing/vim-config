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
  local leader = "<Leader>/"
  local f = require("fzf-lua")
  require("config.fzf-lua-setup")
  local function nmap(f0, t)
    return vim.keymap.set("n", (leader .. f0), t, {remap = true})
  end
  local function xmap(f0, t)
    return vim.keymap.set("x", (leader .. f0), t, {remap = true})
  end
  vim.keymap.set({"n", "x"}, "//", leader, {remap = true})
  nmap("b", f.buffers)
  nmap("f", f.files)
  nmap("hf", f.oldfiles)
  nmap("q", f.quickfix)
  nmap("Q", f.quickfix_stack)
  nmap("l", f.loclist)
  nmap("L", f.loclist_stack)
  nmap("?", f.lines)
  nmap("/", f.blines)
  nmap("t", f.tabs)
  nmap("a", f.args)
  nmap("s", f.grep)
  nmap("S", f.grep_last)
  nmap("8", f.grep_cword)
  nmap("*", f.grep_cWORD)
  xmap("8", f.grep_visual)
  local function tags_wrap(f0)
    local function _2_()
      return f0({path_shorten = true, winopts = {preview = {hidden = "hidden"}}})
    end
    return _2_
  end
  nmap("T", tags_wrap(f.tags))
  local function _3_()
    return f.btags({ctags_autogen = true})
  end
  nmap("t", _3_)
  nmap("<C-t>", tags_wrap(f.tags_grep))
  xmap("t", tags_wrap(f.tags_grep_visual))
  nmap("gg", f.git_files)
  nmap("g<Space>", f.git_status)
  nmap("gb", f.git_branches)
  nmap("gz", f.git_stash)
  nmap("h;", f.command_history)
  nmap("h/", f.search_history)
  nmap("m", f.marks)
  nmap("j", f.jumps)
  nmap("c", f.changes)
  nmap("\"", f.registers)
  return "\n  | `tagstack`         | :tags                                      |\n  | `keymaps`          | key mappings                               |\n  | `filetypes`        | filetypes                                  |\n  | `menus`            | menus                                      |\n  | `spell_suggest`    | spelling suggestions                       |\n  | `packadd`          | :packadd <package>                         |T)\n  "
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