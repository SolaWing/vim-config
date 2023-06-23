local _2afile_2a = "/Users/wang/.config/nvim/fnl/util/vim-info.fnl"
local _2amodule_name_2a = "util.vim-info"
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
local function registers__3evimscript()
  local registers = "qwertyuiopasdfghjklzxcvbnm0*"
  local _1_
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for i = 1, #registers, 1 do
      local val_19_auto
      do
        local char = registers:sub(i, i)
        local reginfo = vim.fn.getreginfo(char)
        if (reginfo.regcontents ~= nil) then
          local _2_
          do
            local tbl_17_auto0 = {}
            local i_18_auto0 = #tbl_17_auto0
            for i0, v in ipairs(reginfo.regcontents) do
              local val_19_auto0 = string.format("'%s'", string.gsub(v, "'", "''"))
              if (nil ~= val_19_auto0) then
                i_18_auto0 = (i_18_auto0 + 1)
                do end (tbl_17_auto0)[i_18_auto0] = val_19_auto0
              else
              end
            end
            _2_ = tbl_17_auto0
          end
          val_19_auto = string.format("call setreg('%s', [%s], '%s')", char, table.concat(_2_, ", "), reginfo.regtype)
        else
          val_19_auto = nil
        end
      end
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    _1_ = tbl_17_auto
  end
  return table.concat(_1_, "\n")
end
_2amodule_2a["registers->vimscript"] = registers__3evimscript
--[[ (local char "g") (local i 2) ]]
return _2amodule_2a