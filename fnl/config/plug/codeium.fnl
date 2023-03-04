(fn setup []
  (set vim.g.codeium_no_map_tab 0)
  ; (set vim.g.codeium_enabled 0) ; internal only allow black list.. so change the repo directly
  (set vim.g.codeium_filetypes
       {:markdown false :text false
        :fennel true :lua true :vim true
        :ruby true :python true :sh true
        :swift true})
        
  (vim.cmd "imap <script><silent><nowait><expr> <C-l> codeium#Accept()")
  (vim.keymap.set :i "<M-Bslash>" #(do (vim.fn.plug#load "codeium.vim")
                                     (vim.keymap.set :i "<M-Bslash>" "<Plug>(codeium-complete)" {:remap true})
                                     (vim.fn.codeium#Complete)))
  (vim.api.nvim_create_user_command "CodeiumLoad"
   "call plug#load('codeium.vim') | echo 'Codeium loaded'"
   {}))

{: setup}
