-- setup for fzf-lua
local f = require("fzf-lua");
local actions = require("fzf-lua.actions")

local opts = {
    fzf_opts = {
        ['--layout'] = 'default'
    },
    actions       = {
        files = {
            ['default'] = actions.file_edit_or_qf,
            ['ctrl-s']  = actions.file_split,
            ['ctrl-v']  = actions.file_vsplit,
            ['ctrl-t']  = actions.file_tabedit,
            ['alt-q']   = actions.file_sel_to_qf,
            ['alt-1']   = actions.file_sel_to_ll,
        },
        buffers = {
            ['default'] = actions.buf_edit,
            ['ctrl-s']  = actions.buf_split,
            ['ctrl-v']  = actions.buf_vsplit,
            ['ctrl-t']  = actions.buf_tabedit,
        }
    }
}
f.setup(opts)
local special_opts = {
    lines = {
        actions = {
            ['default'] = actions.buf_edit_or_qf,
            ['alt-q']   = actions.buf_sel_to_qf,
            ['alt-1']   = actions.buf_sel_to_ll
        }
    },
    blines = {
        actions = {
            ['default'] = actions.buf_edit_or_qf,
            ['alt-q']   = actions.buf_sel_to_qf,
            ['alt-1']   = actions.buf_sel_to_ll
        }
    }
}
local globals = require("fzf-lua.config").globals
for t, v in pairs({
    ["lines"]  = { "actions" },
    ["blines"] = { "actions" },
}) do
    for _, k in ipairs(v) do
        globals[t][k] = special_opts[t][k]
    end
end
