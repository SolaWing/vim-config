-- [nfnl] Compiled from fnl/config/function.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.Bwipeout = function(bang)
  local bang0 = (bang or "")
  local has_bang_3f = vim["true?"](bang0)
  local buf_in_wins
  do
    local tbl_14_auto = {}
    for _k, v in ipairs(vim.api.nvim_list_wins()) do
      local k_15_auto, v_16_auto = vim.api.nvim_win_get_buf(v), true
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    buf_in_wins = tbl_14_auto
  end
  local c = 0
  local m = 0
  local function clear(buf)
    c = (c + 1)
    return vim.ex((buf .. "bwipeout" .. bang0))
  end
  for _i, buf in ipairs(vim.api.nvim_list_bufs()) do
    if not table["key?"](buf_in_wins, buf) then
      if vim.bo[buf].modified then
        m = (m + 1)
        if has_bang_3f then
          clear(buf)
        else
        end
      else
        clear(buf)
      end
    else
    end
  end
  local _5_
  if has_bang_3f then
    _5_ = "include"
  else
    _5_ = "left"
  end
  return print(("wipeout %d buffers, %s %d modified"):format(c, _5_, m))
end
M.CursorContext = function()
  if (require("nvim-treesitter.parsers")).has_parser() then
    return vim.fn["nvim_treesitter#statusline"]()
  elseif vim["true?"](vim.fn.exists("*tagbar#currenttag")) then
    return vim.fn["tagbar#currenttag"]("%s", "", "s")
  else
    return nil
  end
end
return M
