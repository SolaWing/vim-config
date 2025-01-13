-- [nfnl] Compiled from fnl/config/plug/codeverse.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  vim.g.marscode_no_map_tab = true
  vim.g.marscode_disable_bindings = true
  vim.g.marscode_filetypes = {plantuml = true, dot = true, fennel = true, lua = true, vim = true, racket = true, ruby = true, rbs = true, crystal = true, python = true, sh = true, swift = true, go = true, rust = true, c = true, cpp = true, objc = true, make = true, ["*"] = false, markdown = false, text = false}
  local function _1_()
    return vim.cmd("\n      imap <script><silent><nowait><expr> <C-e> marscode#Accept()\n      let g:marscode_tab_fallback = \"\\<End>\"\n      imap <silent><script><nowait><expr> <C-]> marscode#Clear() . \"\\<C-]>\"\n      imap <M-]> <Plug>(marscode-next-or-complete)\n      imap <M-[> <Plug>(marscode-previous)\n      imap <C-k> <Plug>(marscode-accept-word)\n      imap <C-j> <Plug>(marscode-accept-line)\n    ")
  end
  vim.api.nvim_create_autocmd("User", {group = "mine", pattern = "codeverse.vim", once = true, desc = "config marscode", callback = _1_})
  local function _2_()
    vim.fn["plug#load"]("codeverse.vim")
    vim.notify("marscode loaded")
    vim.keymap.set("i", "<M-Bslash>", "<Cmd>call marscode#Complete()<CR>", {remap = true})
    return vim.fn["marscode#Complete"]()
  end
  vim.keymap.set("i", "<M-Bslash>", _2_)
  return vim.api.nvim_create_user_command("MarscodeLoad", "call plug#load('codeverse.vim') | echo 'Marscode loaded'", {})
end
return {setup = setup}
