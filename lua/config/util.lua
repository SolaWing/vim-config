-- [nfnl] Compiled from fnl/config/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("config.deps")
local a = _local_1_["core"]
table["key?"] = function(self, k)
  return (nil ~= self[k])
end
do
  local function call_command(...)
    return vim.api.nvim_command(table.concat(vim.tbl_flatten({...}), " "))
  end
  local function _2_(...)
    return call_command(select(2, ...))
  end
  local function _3_(t, k)
    if a["string?"](k) then
      local command = k:gsub("_$", "!")
      local function _4_(...)
        return call_command(command, ...)
      end
      return _4_
    else
      return nil
    end
  end
  vim.ex = setmetatable({}, {__call = _2_, __index = _3_})
end
vim["true?"] = function(v)
  local _6_ = type(v)
  if (_6_ == "number") then
    return (0 ~= v)
  elseif (_6_ == "nil") then
    return false
  elseif (_6_ == "boolean") then
    return v
  elseif (_6_ == "string") then
    return vim["true?"](tonumber(v))
  elseif true then
    local _ = _6_
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
      local function _8_()
        local mod = old(name0)
        do
          local _9_ = hooks[name0]
          if (nil ~= _9_) then
            local hook_table = _9_
            for id0, callback0 in pairs(hook_table) do
              callback0(name0, mod, id0)
            end
          else
          end
        end
        return mod
      end
      return (package.loaded[name0] or _8_())
    end
    _G["my-require-hook"] = {hooks = hooks, hooked = true, old = old, req = req}
    _G.require = req
  else
  end
  local hook_table
  local function _12_()
    local d = {}
    _G["my-require-hook"].hooks[name] = d
    return d
  end
  hook_table = ((_G["my-require-hook"].hooks)[name] or _12_())
  do end (hook_table)[id] = callback
  local _13_ = package.loaded[name]
  if (nil ~= _13_) then
    local mod = _13_
    return callback(name, mod, id)
  else
    return nil
  end
end
return _G["hook-require"]
