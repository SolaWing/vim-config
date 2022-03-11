local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/function.fnl"
local _2amodule_name_2a = "config.function"
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
local nvim = autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["nvim"] = nvim
local function Bwipeout()
  local buf_in_wins
  do
    local tbl_12_auto = {}
    for k, v in ipairs(vim.api.nvim_list_wins()) do
      local _1_, _2_ = vim.api.nvim_win_get_buf(v), true
      if ((nil ~= _1_) and (nil ~= _2_)) then
        local k_13_auto = _1_
        local v_14_auto = _2_
        tbl_12_auto[k_13_auto] = v_14_auto
      else
      end
    end
    buf_in_wins = tbl_12_auto
  end
  local c = 0
  for i, v in ipairs(vim.api.nvim_list_bufs()) do
    if not table["key?"](buf_in_wins, v) then
      c = (c + 1)
      vim.api.nvim_buf_delete(v)
    else
    end
  end
  return print(("wipeout %d buffers"):format(c))
end
_2amodule_2a["Bwipeout"] = Bwipeout
return _2amodule_2a