local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/plug/wilder.fnl"
local function setup()
    local wilder = require("wilder")
    wilder.setup({ modes = { ":", "/", "?" } })

    wilder.set_option('pipeline', {
        wilder.branch(
            wilder.cmdline_pipeline({
                fuzzy = 1,
                set_pcre2_pattern = 1,
            }),
            wilder.python_search_pipeline({
                pattern = 'fuzzy',
            })
        ),
    })

    local highlighters = {
        wilder.pcre2_highlighter(),
        wilder.basic_highlighter(),
    }

    wilder.set_option('renderer', wilder.renderer_mux({
        -- [':'] = wilder.popupmenu_renderer({
        [':'] = wilder.wildmenu_renderer({
            highlighter = highlighters,
        }),
        ['/'] = wilder.wildmenu_renderer({
            highlighter = highlighters,
        }),
    }))
    -- vim.keymap.set({"c"}, "<C-n>", "<Tab>", {remap = true})
    -- vim.keymap.set({"c"}, "<C-p>", "<S-Tab>", {remap = true})
end
return { setup = setup }

