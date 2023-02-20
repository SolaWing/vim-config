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
local function fzf_lua_bind()
  local leader = "<Leader>/"
  local function f(...)
    return (require("fzf-lua"))[...]
  end
  require("config.fzf-lua-setup")
  local function nmap(f0, t)
    return vim.keymap.set("n", (leader .. f0), t, {remap = true})
  end
  local function xmap(f0, t)
    return vim.keymap.set("x", (leader .. f0), t, {remap = true})
  end
  vim.keymap.set({"n", "x"}, "//", leader, {remap = true})
  local function _2_()
    return f("buffers")()
  end
  nmap("b", _2_)
  local function _3_()
    return f("files")()
  end
  nmap("f", _3_)
  local function _4_()
    return f("files")({query = f("utils", "get_visual_selection")()})
  end
  xmap("f", _4_)
  local function _5_()
    return f("oldfiles")()
  end
  nmap("hf", _5_)
  local function _6_()
    return f("quickfix")()
  end
  nmap("q", _6_)
  local function _7_()
    return f("quickfix_stack")()
  end
  nmap("Q", _7_)
  local function _8_()
    return f("loclist")()
  end
  nmap("l", _8_)
  local function _9_()
    return f("loclist_stack")()
  end
  nmap("L", _9_)
  local function _10_()
    return f("lines")()
  end
  nmap("?", _10_)
  local function _11_()
    return f("blines")()
  end
  nmap("/", _11_)
  local function _12_()
    return f("tabs")()
  end
  nmap("t", _12_)
  local function _13_()
    return f("args")()
  end
  nmap("a", _13_)
  local function _14_()
    return f("grep")()
  end
  nmap("s", _14_)
  local function _15_()
    return f("grep_last")()
  end
  nmap("S", _15_)
  local function _16_()
    return f("grep_cword")()
  end
  nmap("8", _16_)
  local function _17_()
    return f("grep_cWORD")()
  end
  nmap("*", _17_)
  local function _18_()
    return f("grep_visual")()
  end
  xmap("8", _18_)
  local function _19_()
    return f("grep_visual")()
  end
  xmap("s", _19_)
  local function tags_wrap(type)
    local function _20_()
      return f(type)({path_shorten = true, winopts = {preview = {hidden = "hidden"}}})
    end
    return _20_
  end
  nmap("T", tags_wrap("tags"))
  local function _21_()
    return f("btags")({ctags_autogen = true})
  end
  nmap("t", _21_)
  nmap("<C-t>", tags_wrap("tags_grep"))
  xmap("t", tags_wrap("tags_grep_visual"))
  local function _22_()
    return f("git_files")()
  end
  nmap("gg", _22_)
  local function _23_()
    return f("git_files")({query = f("utils", "get_visual_selection")()})
  end
  xmap("gg", _23_)
  local function _24_()
    return f("git_status")()
  end
  nmap("g<Space>", _24_)
  local function _25_()
    return f("git_branches")()
  end
  nmap("gb", _25_)
  local function _26_()
    return f("git_stash")()
  end
  nmap("gz", _26_)
  local function _27_()
    return f("command_history")()
  end
  nmap("h;", _27_)
  local function _28_()
    return f("search_history")()
  end
  nmap("h/", _28_)
  local function _29_()
    return f("marks")()
  end
  nmap("m", _29_)
  local function _30_()
    return f("jumps")()
  end
  nmap("j", _30_)
  local function _31_()
    return f("changes")()
  end
  nmap("c", _31_)
  local function _32_()
    return f("registers")()
  end
  nmap("\"", _32_)
  return "\n  | `tagstack`         | :tags                                      |\n  | `keymaps`          | key mappings                               |\n  | `filetypes`        | filetypes                                  |\n  | `menus`            | menus                                      |\n  | `spell_suggest`    | spelling suggestions                       |\n  | `packadd`          | :packadd <package>                         |T)\n  "
end
_2amodule_2a["fzf-lua-bind"] = fzf_lua_bind
local function harpoon_bind()
  local function _33_()
    return (require("harpoon.mark")).add_file()
  end
  vim.keymap.set("n", "<Leader>p<Space>", _33_)
  local function _34_()
    return (require("harpoon.ui")).toggle_quick_menu()
  end
  return vim.keymap.set("n", "<Leader>p<Tab>", _34_)
end
_2amodule_2a["harpoon-bind"] = harpoon_bind
local function init()
  infomation()
  if vim["plug?"]("fzf-lua") then
    fzf_lua_bind()
  else
  end
  if vim["plug?"]("harpoon") then
    return harpoon_bind()
  else
    return nil
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a