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
local autoload = (require("aniseed.autoload")).autoload
local fzf_lua = autoload("fzf-lua")
do end (_2amodule_locals_2a)["fzf-lua"] = fzf_lua
local function common()
  local function _1_()
    return print((require("config.function")).CursorContext())
  end
  vim.keymap.set("n", ",.", _1_)
  vim.keymap.set("n", "<Leader>eI", "<Cmd>0tab drop ~/.vim/fnl/config/init.fnl<CR>")
  vim.keymap.set("n", "<Leader>eP", "<Cmd>0tab drop ~/.vim/fnl/config/plugs.fnl<CR>")
  return vim.keymap.set("n", "<Leader>eK", "<Cmd>0tab drop ~/.vim/fnl/config/keybinding.fnl<CR>")
end
_2amodule_2a["common"] = common
local function fzf_lua_bind()
  local leader = "<Leader>/"
  local function nmap(f, t)
    return vim.keymap.set("n", (leader .. f), t, {remap = true})
  end
  local function xmap(f, t)
    return vim.keymap.set("x", (leader .. f), t, {remap = true})
  end
  vim.keymap.set({"n"}, "<M-Tab>", (leader .. "b"), {remap = true})
  local function _2_()
    return fzf_lua.buffers({winopts = {preview = {layout = "vertical"}}})
  end
  nmap("b", _2_)
  local function _3_()
    return fzf_lua.files()
  end
  nmap("f", _3_)
  local function _4_()
    return fzf_lua.files({query = fzf_lua.utils.get_visual_selection()})
  end
  xmap("f", _4_)
  local function _5_()
    return fzf_lua.oldfiles()
  end
  nmap("hf", _5_)
  local function _6_()
    return fzf_lua.quickfix()
  end
  nmap("q", _6_)
  local function _7_()
    return fzf_lua.quickfix_stack()
  end
  nmap("Q", _7_)
  local function _8_()
    return fzf_lua.loclist()
  end
  nmap("l", _8_)
  local function _9_()
    return fzf_lua.loclist_stack()
  end
  nmap("L", _9_)
  local function _10_()
    return fzf_lua.lines({fzf_opts = {["--layout"] = "reverse-list"}})
  end
  nmap("?", _10_)
  local function _11_()
    return fzf_lua.lines({fzf_opts = {["--layout"] = "reverse-list"}, query = fzf_lua.utils.get_visual_selection()})
  end
  xmap("?", _11_)
  local function _12_()
    return fzf_lua.blines({fzf_opts = {["--layout"] = "reverse-list"}})
  end
  nmap("/", _12_)
  local function _13_()
    return fzf_lua.blines({fzf_opts = {["--layout"] = "reverse-list"}, query = fzf_lua.utils.get_visual_selection()})
  end
  xmap("/", _13_)
  local function _14_()
    return fzf_lua.tabs()
  end
  nmap("t", _14_)
  local function _15_()
    return fzf_lua.args()
  end
  nmap("a", _15_)
  local function _16_()
    return fzf_lua.grep()
  end
  nmap("s", _16_)
  local function _17_()
    return fzf_lua.grep_last()
  end
  nmap("S", _17_)
  local function _18_()
    return fzf_lua.grep_cword()
  end
  nmap("8", _18_)
  local function _19_()
    return fzf_lua.grep_cWORD()
  end
  nmap("*", _19_)
  local function _20_()
    return fzf_lua.grep_visual()
  end
  xmap("8", _20_)
  local function _21_()
    return fzf_lua.grep_visual()
  end
  xmap("s", _21_)
  local function tags_wrap(type)
    local function _22_()
      return fzf_lua[type]({path_shorten = true, winopts = {preview = {hidden = "hidden"}}})
    end
    return _22_
  end
  nmap("<C-]>", tags_wrap("tags"))
  local function _23_()
    return fzf_lua.btags({ctags_autogen = true})
  end
  nmap("]", _23_)
  xmap("<C-]>", tags_wrap("tags_grep_visual"))
  local function _24_()
    return fzf_lua.git_files()
  end
  nmap("gg", _24_)
  local function _25_()
    return fzf_lua.git_files({query = fzf_lua.utils.get_visual_selection()})
  end
  xmap("gg", _25_)
  local function _26_()
    return fzf_lua.git_status()
  end
  nmap("g<Space>", _26_)
  local function _27_()
    return fzf_lua.git_branches()
  end
  nmap("gb", _27_)
  local function _28_()
    return fzf_lua.git_stash()
  end
  nmap("gz", _28_)
  local function _29_()
    return fzf_lua.command_history()
  end
  nmap("h;", _29_)
  local function _30_()
    return fzf_lua.search_history()
  end
  nmap("h/", _30_)
  local function _31_()
    return fzf_lua.marks()
  end
  nmap("m", _31_)
  local function _32_()
    return fzf_lua.jumps()
  end
  nmap("j", _32_)
  local function _33_()
    return fzf_lua.changes()
  end
  nmap("c", _33_)
  local function _34_()
    return fzf_lua.registers()
  end
  nmap("\"", _34_)
  return "\n  | `tagstack`         | :tags                                      |\n  | `keymaps`          | key mappings                               |\n  | `filetypes`        | filetypes                                  |\n  | `menus`            | menus                                      |\n  | `spell_suggest`    | spelling suggestions                       |\n  | `packadd`          | :packadd <package>                         |T)\n  "
end
_2amodule_2a["fzf-lua-bind"] = fzf_lua_bind
local function harpoon_bind()
  local function _35_()
    return (require("harpoon.mark")).add_file()
  end
  vim.keymap.set("n", "<Leader>p<Space>", _35_, {desc = "harpoon.mark"})
  local function _36_()
    return (require("harpoon.ui")).toggle_quick_menu()
  end
  return vim.keymap.set("n", "<Leader>p<Tab>", _36_, {desc = "harpoon.ui"})
end
_2amodule_2a["harpoon-bind"] = harpoon_bind
local function refactoring_bind()
  local function _37_()
    return (require("refactoring")).select_refactor()
  end
  return vim.keymap.set({"x", "n"}, "<Leader>xr", _37_, {desc = "refactoring"})
end
_2amodule_2a["refactoring-bind"] = refactoring_bind
local function leap_bind()
  local function _38_()
    return (require("config.plug.leap")).leap_to_line()
  end
  vim.keymap.set({"n", "x"}, "<Space><CR>", _38_, {desc = "leap_to_line"})
  vim.keymap.set({"o"}, "<Space><CR>", "V<Cmd>lua require('config.plug.leap').leap_to_line()<CR>", {desc = "leap_to_line"})
  return (require("leap")).add_default_mappings()
end
_2amodule_2a["leap-bind"] = leap_bind
local function init()
  common()
  if vim["plug?"]("fzf-lua") then
    fzf_lua_bind()
  else
  end
  if vim["plug?"]("harpoon") then
    harpoon_bind()
  else
  end
  if vim["plug?"]("refactoring.nvim") then
    refactoring_bind()
  else
  end
  if vim["plug?"]("leap.nvim") then
    leap_bind()
  else
  end
  if vim["plug?"]("nvim-spectre") then
    return (require("config/plug/spectre")).setup()
  else
    return nil
  end
end
_2amodule_2a["init"] = init
return _2amodule_2a