-- [nfnl] Compiled from fnl/config/ft/git.fnl by https://github.com/Olical/nfnl, do not edit.
local function gv_23parent(count)
  local sha = vim.fn["gv#sha"]()
  local _1_ = #sha
  if (_1_ == 0) then
    return vim.notify("no sha found", vim.log.levels.WARN)
  else
    local _ = _1_
    local parent = vim.trim(vim.fn.system(vim.fn.FugitiveShellCommand({"rev-parse", "--short", (sha .. "^" .. count)})))
    if ((0 ~= #parent) and (0 ~= vim.fn.search(parent, "s"))) then
      return nil
    else
      return vim.notify("no parent sha found", vim.log.levels.WARN)
    end
  end
end
--[[ (tset (require "config.ft.git") "gv#parent" gv#parent) ]]
return {["gv#parent"] = gv_23parent}
