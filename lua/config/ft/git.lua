local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/ft/git.fnl"
local _2amodule_name_2a = "config.ft.git"
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
_2amodule_2a["gv#parent"] = gv_23parent
return _2amodule_2a