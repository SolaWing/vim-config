local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/plug/refactoring.fnl"
local function setup()
  return (require("refactoring")).setup()
end
return {setup = setup}