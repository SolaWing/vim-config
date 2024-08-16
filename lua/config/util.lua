-- [nfnl] Compiled from fnl/config/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("config.deps")
local a = _local_1_["core"]
table["key?"] = function(self, k)
  return (nil ~= self[k])
end
if _G.jit then
  local v = string.lower(_G.jit.os)
  if (v ~= "windows") then
    os["path-sep"] = "/"
  else
    os["path-sep"] = "\\"
  end
else
  os["path-sep"] = package.config:sub(1, 1)
end
do
  local function call_command(...)
    return vim.api.nvim_command(table.concat(vim.tbl_flatten({...}), " "))
  end
  local function _4_(...)
    return call_command(select(2, ...))
  end
  local function _5_(t, k)
    if a["string?"](k) then
      local command = k:gsub("_$", "!")
      local function _6_(...)
        return call_command(command, ...)
      end
      return _6_
    else
      return nil
    end
  end
  vim.ex = setmetatable({}, {__call = _4_, __index = _5_})
end
vim["true?"] = function(v)
  local _8_ = type(v)
  if (_8_ == "number") then
    return (0 ~= v)
  elseif (_8_ == "nil") then
    return false
  elseif (_8_ == "boolean") then
    return v
  elseif (_8_ == "string") then
    return vim["true?"](tonumber(v))
  else
    local _ = _8_
    return error(("invalid type for vim boolean check: " .. type(v)))
  end
end
_G["hook-require"] = function(name, id, callback)
  assert(id, "id is required")
  if not _G["my-require-hook"] then
    local old = require
    local hooks = {}
    local function req(name0)
      local or_10_ = package.loaded[name0]
      if not or_10_ then
        local mod = old(name0)
        do
          local _12_ = hooks[name0]
          if (nil ~= _12_) then
            local hook_table = _12_
            for id0, callback0 in pairs(hook_table) do
              callback0(name0, mod, id0)
            end
          else
          end
        end
        or_10_ = mod
      end
      return or_10_
    end
    _G["my-require-hook"] = {hooks = hooks, hooked = true, old = old, req = req}
    _G.require = req
  else
  end
  local hook_table
  local or_15_ = _G["my-require-hook"].hooks[name]
  if not or_15_ then
    local d = {}
    _G["my-require-hook"].hooks[name] = d
    or_15_ = d
  end
  hook_table = or_15_
  hook_table[id] = callback
  local _17_ = package.loaded[name]
  if (nil ~= _17_) then
    local mod = _17_
    return callback(name, mod, id)
  else
    return nil
  end
end
return _G["hook-require"]
