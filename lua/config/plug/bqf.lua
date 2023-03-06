local function setup()
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
            pscrollup = '<M-b>',
            pscrolldown = '<M-f>',
            pscrollorig = '<M-p>',
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

return {setup = setup}
