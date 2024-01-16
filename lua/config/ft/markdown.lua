local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/ft/markdown.fnl"
local _2amodule_name_2a = "config.ft.markdown"
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
local function toggle_list_item(kind)
  local line = vim.fn.getline(".")
  local patterns = {all = "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)=", no = "^\\s*\\zs"}
  local matches = vim.fn.matchstrpos(line, patterns.all)
  print(line, kind, matches[2])
  if (-1 == matches[2]) then
    local _1_ = kind
    if ((_1_ == 0) or (_1_ == 2)) then
      return vim.fn.setline(".", vim.fn.substitute(line, patterns.no, "- ", ""))
    elseif (_1_ == 1) then
      return print("already no list item")
    elseif (_1_ == 3) then
      return vim.fn.setline(".", vim.fn.substitute(line, patterns.no, "- [ ] ", ""))
    else
      return nil
    end
  elseif ((matches[3] - matches[2]) <= 2) then
    local _3_ = kind
    if ((_3_ == 0) or (_3_ == 3)) then
      return vim.fn.setline(".", vim.fn.substitute(line, patterns.all, "- [ ] ", ""))
    elseif (_3_ == 1) then
      return vim.fn.setline(".", vim.fn.substitute(line, patterns.all, "", ""))
    elseif (_3_ == 2) then
      return print("already normal item")
    else
      return nil
    end
  else
    local _5_ = kind
    if ((_5_ == 0) or (_5_ == 1)) then
      return vim.fn.setline(".", vim.fn.substitute(line, patterns.all, "", ""))
    elseif (_5_ == 2) then
      return vim.fn.setline(".", vim.fn.substitute(line, patterns.all, "- ", ""))
    elseif (_5_ == 3) then
      return print("already todo item")
    else
      return nil
    end
  end
end
_2amodule_2a["toggle-list-item"] = toggle_list_item
--[[ (let [line "完成初步的代码生成(silgen)"] (vim.fn.substitute line "^\\s*s" "- " "")) ]]
return _2amodule_2a