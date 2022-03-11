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
local f, nvim = autoload("plenary.functional"), autoload("aniseed.nvim")
do end (_2amodule_locals_2a)["f"] = f
_2amodule_locals_2a["nvim"] = nvim
local function Bwipeout()
  do
    local wins = vim.api.nvim_list_wins()
    local buf_in_wins = nil
  end
  for i, v in ipairs(vim.api.nvim_list_bufs) do
    vim.api.nvim_buf_delete(v)
  end
  return nil
end
_2amodule_2a["Bwipeout"] = Bwipeout
return _2amodule_2a