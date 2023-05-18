(fn setup []
  (set vim.g.codeium_no_map_tab 0)
  ; (set vim.g.codeium_enabled 0) ; internal only allow black list.. so change the repo directly
  (set vim.g.codeium_filetypes
       {:markdown false :text false
        :plantuml true
        :fennel true :lua true :vim true
        :ruby true :python true :sh true
        :swift true})

  (vim.api.nvim_create_autocmd :User
   {:group :mine :pattern "codeium.vim" :once true
    :desc "config codeium"
    ; special key need to translate in vim language
    ; currently <C-e> mapped to <End>
    :callback #(vim.cmd "imap <script><silent><nowait><expr> <C-e> codeium#Accept()
                        let g:codeium_tab_fallback = \"\\<End>\"")})

  (vim.keymap.set :i "<M-Bslash>"
   #(do (vim.fn.plug#load "codeium.vim")
      (vim.notify "codeium loaded")
      (vim.keymap.set :i "<M-Bslash>" "<Plug>(codeium-complete)" {:remap true})
      (vim.fn.codeium#Complete)))
  (vim.api.nvim_create_user_command "CodeiumLoad"
   "call plug#load('codeium.vim') | echo 'Codeium loaded'"
   {}))

{: setup}
