-- setup for fzf-lua
local function setup()
    -- print("hook setup!!" .. debug.traceback())
    -- print("after hook")
    local f = require("fzf-lua");
    local actions = require("fzf-lua.actions")

    local opts = {
        winopts = {
            -- Only valid when using a float window
            -- (i.e. when 'split' is not defined, default)
            height           = 0.95,            -- window height
            width            = 0.95,            -- window width
            row              = 0.2,            -- window row position (0=top, 1=bottom)
            col              = 0.5,            -- window col position (0=left, 1=right)
            preview = {
                vertical = 'up:50%'
            }
        },
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
        },
        keymap = {
            builtin = {
                ["<F1>"]     = "toggle-help",
                ["<F2>"]     = "toggle-fullscreen",
                -- Only valid with the 'builtin' previewer
                ["<F3>"]     = "toggle-preview-wrap",
                ["<F4>"]     = "toggle-preview",
                ["<F5>"]     = "toggle-preview-ccw",
                ["<F6>"]     = "toggle-preview-cw",
                ["<M-]>"] = "preview-page-down",
                ["<M-[>"] = "preview-page-up",
                ["<M-=>"] = "preview-page-reset",
            }
        },
        registers = {
          actions = {
            ["@"] = function (selected)
              local register = selected[1]:match("^%[(.)%]")
              vim.cmd("normal @" .. register)
            end
          }
        },
        lines = {
            actions = {
                ['alt-1']   = actions.buf_sel_to_ll,
                ['alt-l']   = false
            }
        },
        blines = {
            actions = {
                ['alt-1']   = actions.buf_sel_to_ll,
                ['alt-l']   = false
            }
        }
    }
    f.setup(opts)
end
return { setup = setup }
