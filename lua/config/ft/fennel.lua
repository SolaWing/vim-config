-- [nfnl] Compiled from fnl/config/ft/fennel.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("config.deps")
local fs = _local_1_["fs"]
local function module__3epath(mod, first)
  local mod_path = mod:gsub("%.", fs["path-sep"])
  local paths = {("fnl" .. fs["path-sep"] .. mod_path .. ".fnl"), ("fnl" .. fs["path-sep"] .. mod_path .. fs["path-sep"] .. "init.fnl"), ("lua" .. fs["path-sep"] .. mod_path .. ".lua"), ("lua" .. fs["path-sep"] .. mod_path .. fs["path-sep"] .. "init.lua")}
  local t = {}
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    for _0, rel_path in ipairs(paths) do
      local p = (path .. fs["path-sep"] .. rel_path)
      if (1 == vim.fn.filereadable(p)) then
        if first then
          return p
        else
        end
        table.insert(t, p)
      else
      end
    end
  end
  if first then
    return nil
  else
    return t
  end
end
local function goto_module(mod, first, open_cmd)
  local paths
  if mod:find(fs["path-sep"]) then
    if first then
      paths = mod
    else
      paths = {mod}
    end
  else
    paths = module__3epath(mod, first)
  end
  local function edit(p)
    return vim.cmd(table.concat({(open_cmd or "edit"), vim.fn.fnameescape(p)}, " "))
  end
  if first then
    if paths then
      return edit(paths)
    else
      return vim.notify("no match file found", vim.log.levels.WARN)
    end
  else
    local _8_ = #paths
    if (_8_ == 0) then
      return vim.notify("no match file found", vim.log.levels.WARN)
    elseif (_8_ == 1) then
      return edit(paths[1])
    elseif true then
      local _ = _8_
      local function _9_(_241)
        if (nil ~= _241) then
          return edit(_241)
        else
          return nil
        end
      end
      return vim.ui.select(paths, {prompt = "which file to choose? "}, _9_)
    else
      return nil
    end
  end
end
return {["goto-module"] = goto_module}
