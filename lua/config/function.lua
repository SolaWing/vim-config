local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/function.fnl"
local _2amodule_name_2a = "config.function"
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
local function Bwipeout(bang)
  local bang0 = (bang or "")
  local has_bang_3f = not a["empty?"](bang0)
  local buf_in_wins
  do
    local tbl_14_auto = {}
    for k, v in ipairs(vim.api.nvim_list_wins()) do
      local _1_, _2_ = vim.api.nvim_win_get_buf(v), true
      if ((nil ~= _1_) and (nil ~= _2_)) then
        local k_15_auto = _1_
        local v_16_auto = _2_
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
  for i, buf in ipairs(vim.api.nvim_list_bufs()) do
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
  local _7_
  if has_bang_3f then
    _7_ = "include"
  else
    _7_ = "left"
  end
  return print(("wipeout %d buffers, %s %d modified"):format(c, _7_, m))
end
_2amodule_2a["Bwipeout"] = Bwipeout
local function CursorContext()
  if (require("nvim-treesitter.parsers")).has_parser() then
    return vim.fn["nvim_treesitter#statusline"]()
  elseif vim["true?"](vim.fn.exists("*tagbar#currenttag")) then
    return vim.fn["tagbar#currenttag"]("%s", "", "s")
  else
    return nil
  end
end
_2amodule_2a["CursorContext"] = CursorContext
return _2amodule_2a