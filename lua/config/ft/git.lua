-- [nfnl] Compiled from fnl/config/ft/git.fnl by https://github.com/Olical/nfnl, do not edit.
local function gv_23parent(count)
  local sha = vim.fn["gv#sha"]()
  local _1_ = #sha
  if (_1_ == 0) then
    return vim.notify("no sha found", vim.log.levels.WARN)
  elseif true then
    local _ = _1_
    local parent = vim.trim(vim.fn.system(vim.fn.FugitiveShellCommand({"rev-parse", "--short", (sha .. "^" .. count)})))
    local pos = ((0 ~= #parent) and vim.fn.searchpos(parent))
    if (pos and (0 ~= pos[1])) then
      return vim.api.nvim_win_set_cursor(0, {pos[1], (pos[2] - 1)})
    else
      return vim.notify("no parent sha found", vim.log.levels.WARN)
    end
  else
    return nil
  end
end
return {["gv#parent"] = gv_23parent}
