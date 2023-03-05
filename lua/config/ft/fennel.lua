local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/ft/fennel.fnl"
local _2amodule_name_2a = "config.ft.fennel"
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
local fs = autoload("aniseed.fs")
do end (_2amodule_locals_2a)["fs"] = fs
local function module__3epath(mod, first)
  local mod_path = mod:gsub("%.", fs["path-sep"])
  local paths = {("fnl" .. fs["path-sep"] .. mod_path .. ".fnl"), ("lua" .. fs["path-sep"] .. mod_path .. ".lua")}
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
_2amodule_2a["module->path"] = module__3epath
local function goto_module(mod, first)
  local paths = module__3epath(mod, first)
  local function edit(p)
    return vim.cmd.e(vim.fn.fnameescape(p))
  end
  if first then
    if paths then
      return edit(paths)
    else
      return vim.notify("no match file found", vim.log.levels.WARN)
    end
  else
    local _5_ = #paths
    if (_5_ == 0) then
      return vim.notify("no match file found", vim.log.levels.WARN)
    elseif (_5_ == 1) then
      return edit(paths[1])
    elseif true then
      local _ = _5_
      local function _6_(_241)
        if (nil ~= _241) then
          return vim.cmd.e(vim.fn.fnameescape(_241))
        else
          return nil
        end
      end
      return vim.ui.select(paths, {prompt = "which file to choose? "}, _6_)
    else
      return nil
    end
  end
end
_2amodule_2a["goto-module"] = goto_module
--[[ (var a (select 2 (unpack [1 2 3]))) (var paths ["/Users/wang/.config/nvim/fnl/config/ft/fennel.fnl" "/Users/wang/.config/nvim/lua/config/ft/fennel.lua"]) (module->path "config.ft.fennel" true) (module->path "config.ft.fennel" false) (goto-module "config.plugs" true) (goto-module "config.plugs2" true) (goto-module "config.plugs" false) (goto-module "config.macros" false) (goto-module "config.macros2" false) ]]
return _2amodule_2a