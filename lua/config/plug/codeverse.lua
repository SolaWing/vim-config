-- [nfnl] fnl/config/plug/codeverse.fnl
local function setup()
  vim.g.trae_no_map_tab = true
  vim.g.trae_disable_bindings = true
  vim.g.trae_filetypes = {plantuml = true, dot = true, fennel = true, lua = true, vim = true, racket = true, ruby = true, rbs = true, crystal = true, python = true, sh = true, swift = true, go = true, rust = true, c = true, cpp = true, objc = true, make = true, ["*"] = false, markdown = false, text = false}
  local function _1_()
    return vim.cmd("\n      imap <script><silent><nowait><expr> <C-e> trae#Accept()\n      let g:trae_tab_fallback = \"\\<End>\"\n      imap <silent><script><nowait><expr> <C-]> trae#Clear() . \"\\<C-]>\"\n      imap <M-]> <Plug>(trae-next-or-complete)\n      imap <M-[> <Plug>(trae-previous)\n      imap <C-k> <Plug>(trae-accept-word)\n      imap <C-j> <Plug>(trae-accept-line)\n    ")
  end
  vim.api.nvim_create_autocmd("User", {group = "mine", pattern = "codeverse.vim", once = true, desc = "config trae", callback = _1_})
  local function _2_()
    vim.fn["plug#load"]("codeverse.vim")
    vim.notify("trae loaded")
    vim.keymap.set("i", "<M-Bslash>", "<Cmd>call trae#Complete()<CR>", {remap = true})
    return vim.fn["trae#Complete"]()
  end
  vim.keymap.set("i", "<M-Bslash>", _2_)
  return vim.api.nvim_create_user_command("TraeLoad", "call plug#load('codeverse.vim') | echo 'Trae loaded'", {})
end
return {setup = setup}
