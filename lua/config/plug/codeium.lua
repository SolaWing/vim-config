-- [nfnl] Compiled from fnl/config/plug/codeium.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  vim.g.codeium_no_map_tab = 0
  vim.g.codeium_filetypes = {plantuml = true, dot = true, fennel = true, lua = true, vim = true, racket = true, ruby = true, rbs = true, crystal = true, python = true, sh = true, swift = true, go = true, rust = true, c = true, cpp = true, objc = true, make = true, markdown = false, text = false}
  local function _1_()
    return vim.cmd("imap <script><silent><nowait><expr> <C-e> codeium#Accept()\n                        let g:codeium_tab_fallback = \"\\<End>\"")
  end
  vim.api.nvim_create_autocmd("User", {group = "mine", pattern = "codeium.vim", once = true, desc = "config codeium", callback = _1_})
  local function _2_()
    vim.fn["plug#load"]("codeium.vim")
    vim.notify("codeium loaded")
    vim.keymap.set("i", "<M-Bslash>", "<Plug>(codeium-complete)", {remap = true})
    return vim.fn["codeium#Complete"]()
  end
  vim.keymap.set("i", "<M-Bslash>", _2_)
  return vim.api.nvim_create_user_command("CodeiumLoad", "call plug#load('codeium.vim') | echo 'Codeium loaded'", {})
end
return {setup = setup}
