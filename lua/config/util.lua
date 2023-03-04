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
_G["hook-require"] = function(name, id, callback)
  assert(id, "id is required")
  if not _G["my-require-hook"] then
    local old = require
    local hooks = {}
    local function req(name0)
      local function _7_()
        local mod = old(name0)
        do
          local _8_ = hooks[name0]
          if (nil ~= _8_) then
            local hook_table = _8_
            for id0, callback0 in pairs(hook_table) do
              callback0(name0, mod, id0)
            end
          else
          end
        end
        return mod
      end
      return (package.loaded[name0] or _7_())
    end
    _G["my-require-hook"] = {hooks = hooks, hooked = true, old = old, req = req}
    _G.require = req
  else
  end
  local hook_table
  local function _11_()
    local d = {}
    _G["my-require-hook"].hooks[name] = d
    return d
  end
  hook_table = ((_G["my-require-hook"].hooks)[name] or _11_())
  local _12_ = package.loaded[name]
  if (nil ~= _12_) then
    local mod = _12_
    return callback(name, mod, id)
  else
    return nil
  end
end
return _2amodule_2a