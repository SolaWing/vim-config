-- [nfnl] fnl/config/keybinding.fnl
local _local_1_ = require("config.deps")
local autoload = _local_1_["autoload"]
local fzf_lua = autoload("fzf-lua")
local function common()
  local function _2_()
    return print(require("config.function").CursorContext())
  end
  vim.keymap.set("n", ",.", _2_, {desc = "CursorContext"})
  vim.keymap.set("n", "<Leader>eI", "<Cmd>0tab drop ~/.vim/fnl/config/init.fnl<CR>", {desc = "tab init.fnl"})
  vim.keymap.set("n", "<Leader>eP", "<Cmd>0tab drop ~/.vim/fnl/config/plugs.fnl<CR>", {desc = "tab plugs.fnl"})
  vim.keymap.set("n", "<Leader>eK", "<Cmd>0tab drop ~/.vim/fnl/config/keybinding.fnl<CR>", {desc = "tab keybinding.fnl"})
  vim.keymap.set("x", "[?", ":lua require('util.secret').encodeR()<CR>", {desc = "encode selected line"})
  vim.keymap.set("x", "]?", ":lua require('util.secret').decodeR()<CR>", {desc = "decode selected line"})
  if vim.g.neovide then
    vim.keymap.set({"n", "v"}, "<D-s>", "<M-s>", {remap = true})
    vim.keymap.set("i", "<D-s>", "<M-s>", {remap = true})
    return vim.keymap.set({"n", "v"}, "<D-M-s>", "<M-S>", {remap = true})
  else
    return nil
  end
end
local function fzf_lua_bind()
  local leader = "<Leader>/"
  local function nmap(f, t, desc)
    return vim.keymap.set("n", (leader .. f), t, {remap = true, desc = desc})
  end
  local function xmap(f, t, desc)
    return vim.keymap.set("x", (leader .. f), t, {remap = true, desc = desc})
  end
  local function quote_visual()
    return ("'" .. vim.fn.escape(fzf_lua.utils.get_visual_selection(), " \9'\\") .. " ")
  end
  vim.keymap.set({"n"}, "<M-Tab>", (leader .. "b"), {remap = true})
  local function _4_()
    return fzf_lua.buffers({winopts = {preview = {layout = "vertical"}}})
  end
  nmap("b", _4_, "fzf-lua.buffers")
  local function _5_()
    return fzf_lua.files()
  end
  nmap("f", _5_, "fzf-lua.files")
  local function _6_()
    return fzf_lua.files({query = quote_visual()})
  end
  xmap("f", _6_, "fzf-lua.files")
  local function _7_()
    return fzf_lua.oldfiles()
  end
  nmap("hf", _7_, "fzf-lua.oldfiles")
  local function _8_()
    return fzf_lua.quickfix()
  end
  nmap("q", _8_, "fzf-lua.quickfix")
  local function _9_()
    return fzf_lua.quickfix_stack()
  end
  nmap("Q", _9_, "fzf-lua.quickfix_stack")
  local function _10_()
    return fzf_lua.loclist()
  end
  nmap("l", _10_, "fzf-lua.loclist")
  local function _11_()
    return fzf_lua.loclist_stack()
  end
  nmap("L", _11_, "fzf-lua.loclist_stack")
  local function _12_()
    return fzf_lua.lines({fzf_opts = {["--layout"] = "reverse-list"}})
  end
  nmap("?", _12_, "fzf-lua.lines")
  local function _13_()
    return fzf_lua.lines({fzf_opts = {["--layout"] = "reverse-list"}, query = quote_visual()})
  end
  xmap("?", _13_, "fzf-lua.lines")
  local function _14_()
    return fzf_lua.blines({fzf_opts = {["--layout"] = "reverse-list"}})
  end
  nmap("/", _14_, "fzf-lua.blines")
  local function _15_()
    return fzf_lua.blines({fzf_opts = {["--layout"] = "reverse-list"}, query = quote_visual()})
  end
  xmap("/", _15_, "fzf-lua.blines")
  local function _16_()
    return fzf_lua.tabs()
  end
  nmap("t", _16_, "fzf-lua.tabs")
  local function _17_()
    return fzf_lua.args()
  end
  nmap("a", _17_, "fzf-lua.args")
  local function _18_()
    return fzf_lua.grep()
  end
  nmap("s", _18_, "fzf-lua.grep")
  local function _19_()
    return fzf_lua.grep_last()
  end
  nmap("S", _19_, "fzf-lua.grep_last")
  local function _20_()
    return fzf_lua.grep_cword()
  end
  nmap("8", _20_, "fzf-lua.grep_cword")
  local function _21_()
    return fzf_lua.grep_cWORD()
  end
  nmap("*", _21_, "fzf-lua.grep_cWORD")
  local function _22_()
    return fzf_lua.grep_visual()
  end
  xmap("8", _22_, "fzf-lua.grep_visual")
  local function _23_()
    return fzf_lua.grep_visual()
  end
  xmap("s", _23_, "fzf-lua.grep_visual")
  local function tags_wrap(type)
    local function _24_()
      return fzf_lua[type]({path_shorten = true, winopts = {preview = {hidden = "hidden"}}})
    end
    return _24_
  end
  nmap("<C-]>", tags_wrap("tags"), "fzf-lua.tags")
  local function _25_()
    return fzf_lua.btags({ctags_autogen = true})
  end
  nmap("]", _25_, "fzf-lua.btags")
  xmap("<C-]>", tags_wrap("tags_grep_visual"), "fzf-lua.tags_grep_visual")
  local function with_git_opts(opts)
    opts["git_icons"] = false
    local _26_ = vim.b.git_dir
    if true then
      local _git_dir = _26_
      opts["cwd"] = vim.fn.FugitiveWorkTree()
      return opts
    else
      local _ = _26_
      return opts
    end
  end
  local function _28_()
    return fzf_lua.git_files(with_git_opts({}))
  end
  nmap("gg", _28_, "fzf-lua.git_files")
  local function _29_()
    return fzf_lua.git_files(with_git_opts({query = quote_visual()}))
  end
  xmap("gg", _29_, "fzf-lua.git_files")
  local function _30_()
    return fzf_lua.git_status()
  end
  nmap("g<Space>", _30_, "fzf-lua.git_status")
  local function _31_()
    return fzf_lua.git_branches()
  end
  nmap("gb", _31_, "fzf-lua.git_branches")
  local function _32_()
    return fzf_lua.git_stash()
  end
  nmap("gz", _32_, "fzf-lua.git_stash")
  local function _33_()
    return fzf_lua.command_history()
  end
  nmap("h;", _33_, "fzf-lua.command_history")
  local function _34_()
    return fzf_lua.search_history()
  end
  nmap("h/", _34_, "fzf-lua.search_history")
  local function _35_()
    return fzf_lua.marks()
  end
  nmap("m", _35_, "fzf-lua.marks")
  local function _36_()
    return fzf_lua.marks()
  end
  nmap("'", _36_, "fzf-lua.marks")
  local function _37_()
    return fzf_lua.jumps()
  end
  nmap("j", _37_, "fzf-lua.jumps")
  local function _38_()
    return fzf_lua.changes()
  end
  nmap("c", _38_, "fzf-lua.changes")
  local function _39_()
    return fzf_lua.registers()
  end
  nmap("\"", _39_, "fzf-lua.registers")
  if vim["plug?"]("nvim-neoclip.lua") then
    local function _40_()
      return require("neoclip.fzf")()
    end
    nmap("h\"", _40_)
    local function _41_()
      return require("neoclip.fzf")("q")
    end
    nmap("hq", _41_)
  else
  end
  return "\n  | `tagstack`         | :tags                                      |\n  | `keymaps`          | key mappings                               |\n  | `filetypes`        | filetypes                                  |\n  | `menus`            | menus                                      |\n  | `spell_suggest`    | spelling suggestions                       |\n  | `packadd`          | :packadd <package>                         |T)\n  "
end
local function harpoon_bind()
  local function _43_()
    return require("harpoon.mark").add_file()
  end
  vim.keymap.set("n", "<Leader>p<Space>", _43_, {desc = "harpoon.mark"})
  local function _44_()
    return require("harpoon.ui").toggle_quick_menu()
  end
  return vim.keymap.set("n", "<Leader>p<Tab>", _44_, {desc = "harpoon.ui"})
end
local function refactoring_bind()
  local function _45_()
    return require("refactoring").select_refactor()
  end
  return vim.keymap.set({"x", "n"}, "<Leader>xr", _45_, {desc = "refactoring"})
end
local function leap_bind()
  local function _46_()
    return require("config.plug.leap").leap_to_line()
  end
  vim.keymap.set({"n", "x"}, "<Space><CR>", _46_, {desc = "leap_to_line"})
  vim.keymap.set({"o"}, "<Space><CR>", "V<Cmd>lua require('config.plug.leap').leap_to_line()<CR>", {desc = "leap_to_line"})
  return require("leap").add_default_mappings()
end
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
    return require("config/plug/spectre").setup()
  else
    return nil
  end
end
return {init = init}
