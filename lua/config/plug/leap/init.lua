local function get_line_starts(winid)
  local wininfo =  vim.fn.getwininfo(winid)[1]
  local cur_line = vim.fn.line('.')
  local cur_virtcol = vim.fn.virtcol('.')
  -- Skip lines close to the cursor.
  local skip_range = 2

  -- Get targets.
  local targets = {}
  local lnum = wininfo.topline
  while lnum <= wininfo.botline do
    local fold_end = vim.fn.foldclosedend(lnum)
    -- Skip folded ranges.
    if fold_end ~= -1 then
      lnum = fold_end + 1
    else
      if (lnum < cur_line - skip_range) or (lnum > cur_line + skip_range) then
        local col = vim.fn.virtcol2col(0, lnum, cur_virtcol)
        if col < 1 then col = 1 end
        local max_col = vim.fn.col{lnum, '$'}
        if col > max_col then
          col = max_col
        end
        -- print("col is " .. col .. " max_col is " .. max_col)
         -- 中文注释 = vim.fn.getline(lnum, col)
        table.insert(targets, { pos = { lnum, col } })
      end
      lnum = lnum + 1
    end
  end
  -- Sort them by vertical screen distance from cursor.
  local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)['row']
  local function screen_rows_from_cur(t)
    local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])['row']
    return math.abs(cur_screen_row - t_screen_row)
  end
  table.sort(targets, function (t1, t2)
    return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
  end)

  if #targets >= 1 then
    return targets
  end
end

local function get_word_starts(winid)
  -- TODO:  <29-06-23, yourname> --
end

-- Usage:
local function leap_to_line()
  winid = vim.api.nvim_get_current_win()
  require('leap').leap {
    target_windows = { winid },
    targets = get_line_starts(winid),
  }
end

local function leap_to_word()
  winid = vim.api.nvim_get_current_win()
  require("leap").leap {
    targets = get_word_starts(winid)
  }
end

return {
  leap_to_line = leap_to_line,
}

--[[
vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
vim.keymap.set({'n', "x"}, '<Space><CR>', leap_to_line)
vim.keymap.set({'o'}, '<Space><CR>', "V<Cmd>lua leap_to_line()<CR>")
_G.leap_to_line = leap_to_line -- test
]]
