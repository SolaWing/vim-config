local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/util.fnl"
local _2amodule_name_2a = "config.util"
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
local a, _ = autoload("aniseed.core"), nil
_2amodule_locals_2a["a"] = a
_2amodule_locals_2a["_"] = _
table["key?"] = function(self, k)
  return (nil ~= self[k])
end
do
  local function call_command(...)
    return vim.api.nvim_command(table.concat(vim.tbl_flatten({...}), " "))
  end
  local function _1_(...)
    return call_command(select(2, ...))
  end
  local function _2_(t, k)
    if a["string?"](k) then
      local command = k:gsub("_$", "!")
      local function _3_(...)
        return call_command(command, ...)
      end
      return _3_
    else
      return nil
    end
  end
  vim.ex = setmetatable({}, {__call = _1_, __index = _2_})
end
vim["true?"] = function(v)
  local _5_ = type(v)
  if (_5_ == "number") then
    return (0 ~= v)
  elseif (_5_ == "nil") then
    return false
  elseif (_5_ == "boolean") then
    return v
  elseif (_5_ == "string") then
    return vim["true?"](tonumber(v))
  elseif true then
    local _0 = _5_
    return error(("invalid type for vim boolean check: " .. type(v)))
  else
    return nil
  end
end
return _2amodule_2a