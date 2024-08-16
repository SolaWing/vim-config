-- [nfnl] Compiled from fnl/config/ft/ruby.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.test_cmd = function(ty)
  local ty0 = (ty or "all")
  local cmd = (vim.b.test or vim.g.rubytest or "bundle exec rake spec")
  local function rake_spec()
    if string.find(cmd, "rake") then
      return "SPEC="
    else
      return ""
    end
  end
  local full_cmd
  if (ty0 == "line") then
    full_cmd = string.format("%s '%s%s:%d'", cmd, rake_spec(), vim.fn.expand("%:p"), vim.fn.line("."))
  elseif (ty0 == "file") then
    full_cmd = string.format("%s '%s%s'", cmd, rake_spec(), vim.fn.expand("%:p"))
  else
    local _ = ty0
    full_cmd = string.format("%s", cmd)
  end
  return full_cmd
end
return M
