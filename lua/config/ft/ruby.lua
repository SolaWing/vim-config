-- [nfnl] fnl/config/ft/ruby.fnl
local M = {}
M.test_cmd = function(ty)
  local ty0 = (ty or "all")
  local cmd = (vim.b.test or vim.g.rubytest or "bundle exec rspec")
  local function rake_spec()
    if string.find(cmd, "rake") then
      return "SPEC="
    else
      return ""
    end
  end
  local full_cmd
  if (ty0 == "line") then
    full_cmd = string.format("%s '%s%s:%d'", cmd, rake_spec(), vim.fn.expand("%:p"), vim.fn.line("."))
  elseif (ty0 == "file") then
    full_cmd = string.format("%s '%s%s'", cmd, rake_spec(), vim.fn.expand("%:p"))
  else
    local _ = ty0
    full_cmd = string.format("%s", cmd)
  end
  return full_cmd
end
M.rspec_dir = function()
  local buf = vim.api.nvim_buf_get_name(0)
  for dir, _ in vim.fs.parents(buf) do
    local helper_path = vim.fs.joinpath(dir, "spec", "spec_helper.rb")
    if vim.uv.fs_stat(helper_path) then
      return dir
    else
    end
  end
  return vim.fs.dirname(buf)
end
return M
