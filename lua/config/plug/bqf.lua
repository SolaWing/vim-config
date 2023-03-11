local function setup()
  -- use loc instead of CocList
  -- if vim.g.hasCOC then
  --   vim.g.coc_enable_locationlist = 0
  --   local function jumpToLoc(locs)
  --     locs = locs or vim.g.coc_jump_locations
  --     vim.fn.setloclist(0, {}, ' ', {title = 'CocLocationList', items = locs})
  --     local winid = vim.fn.getloclist(0, {winid = 0}).winid
  --     if winid == 0 then
  --       vim.cmd.lwindow()
  --     else
  --       vim.api.nvim_set_current_win(winid)
  --     end
  --   end
  --   vim.api.nvim_create_autocmd("User", {
  --     group = "mine", pattern = "CocLocationsChange",
  --     desc = "bqf jumpToLoc",
  --     callback = jumpToLoc
  --   })
  -- end

  require('bqf').setup({
    -- auto_enable = true,
    -- auto_resize_height = true, -- highly recommended enable
    -- preview = {
    --     win_height = 12,
    --     win_vheight = 12,
    --     delay_syntax = 80,
    --     border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'},
    --     show_title = false,
    --     should_preview_cb = function(bufnr, qwinid)
    --         local ret = true
    --         local bufname = vim.api.nvim_buf_get_name(bufnr)
    --         local fsize = vim.fn.getfsize(bufname)
    --         if fsize > 100 * 1024 then
    --             -- skip file size greater than 100k
    --             ret = false
    --         elseif bufname:match('^fugitive://') then
    --             -- skip fugitive buffer
    --             ret = false
    --         end
    --         return ret
    --     end
    -- },
    -- make `drop` and `tab drop` to become preferred
    func_map = {
      split = '<C-s>',
      tabdrop = '<C-t>',
      -- set to empty string to disable
      tabc = '',
      pscrollup = '<M-[>',
      pscrolldown = '<M-]>',
      pscrollorig = '<M-=>',
    },
    filter = {
      fzf = {
        action_for = {
              ['ctrl-t'] = 'tab drop',
              ['ctrl-v'] = 'vsplit',
              ['ctrl-s'] = 'split',
              ['ctrl-q'] = 'signtoggle',
              ['ctrl-c'] = 'closeall'
        },
      }
    }
  })
end

return { setup = setup }
