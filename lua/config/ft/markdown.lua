-- [nfnl] Compiled from fnl/config/ft/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
local function toggle_list_item(kind)
  local line = vim.fn.getline(".")
  local patterns = {all = "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)=", no = "^\\s*\\zs"}
  local start, _end = vim.regex(patterns.all):match_str(line)
  if not start then
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
  elseif ((_end - start) <= 2) then
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
--[[ (-> "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)=" vim.regex (: "match_str" "  - []abc")) (: (vim.regex "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)=") "match_str" "  - []abc") ]]
return {["toggle-list-item"] = toggle_list_item}
