local _2afile_2a = "/Users/wang/.config/nvim/fnl/config/plug/codeverse.fnl"
local function setup()
  vim.g.codeverse_no_map_tab = true
  vim.g.codeverse_disable_bindings = true
  vim.g.codeverse_filetypes = {plantuml = true, dot = true, fennel = true, lua = true, vim = true, racket = true, ruby = true, rbs = true, crystal = true, python = true, sh = true, swift = true, go = true, rust = true, c = true, cpp = true, objc = true, make = true, ["*"] = false, text = false, markdown = false}
  local function _1_()
    return vim.cmd("\n      imap <script><silent><nowait><expr> <C-e> codeverse#Accept()\n      let g:codeverse_tab_fallback = \"\\<End>\"\n      imap <silent><script><nowait><expr> <C-]> codeverse#Clear() . \"\\<C-]>\"\n      imap <M-]> <Plug>(codeverse-next-or-complete)\n      imap <M-[> <Plug>(codeverse-previous)\n      imap <C-k> <Plug>(codeverse-accept-word)\n      imap <C-j> <Plug>(codeverse-accept-line)\n    ")
  end
  vim.api.nvim_create_autocmd("User", {group = "mine", pattern = "codeverse.vim", once = true, desc = "config codeverse", callback = _1_})
  local function _2_()
    vim.fn["plug#load"]("codeverse.vim")
    vim.notify("codeverse loaded")
    vim.keymap.set("i", "<M-Bslash>", "<Cmd>call codeverse#Complete()<CR>", {remap = true})
    return vim.fn["codeverse#Complete"]()
  end
  vim.keymap.set("i", "<M-Bslash>", _2_)
  return vim.api.nvim_create_user_command("CodeverseLoad", "call plug#load('codeverse.vim') | echo 'Codeverse loaded'", {})
end
return {setup = setup}