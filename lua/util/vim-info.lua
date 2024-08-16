-- [nfnl] Compiled from fnl/util/vim-info.fnl by https://github.com/Olical/nfnl, do not edit.
local function registers__3evimscript()
  local registers = "qwertyuiopasdfghjklzxcvbnm0*"
  local tbl_21_auto = {}
  local i_22_auto = 0
  for i = 1, #registers, 1 do
    local val_23_auto
    do
      local char = registers:sub(i, i)
      local reginfo = vim.fn.getreginfo(char)
      if (reginfo.regcontents ~= nil) then
        local _1_
        do
          local lines = {}
          for _, c in ipairs(reginfo.regcontents) do
            for v in vim.gsplit(c, "\n", true) do
              table.insert(lines, string.format("'%s'", string.gsub(v, "'", "''")))
            end
          end
          _1_ = lines
        end
        val_23_auto = string.format("call setreg('%s', [%s], '%s')", char, table.concat(_1_, ", "), reginfo.regtype)
      else
        val_23_auto = nil
      end
    end
    if (nil ~= val_23_auto) then
      i_22_auto = (i_22_auto + 1)
      tbl_21_auto[i_22_auto] = val_23_auto
    else
    end
  end
  return tbl_21_auto
end
--[[ (local char "g") (local i 2) ]]
return {["registers->vimscript"] = registers__3evimscript}
