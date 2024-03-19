(fn setup []
  (set vim.g.codeverse_no_map_tab true)
  (set vim.g.codeverse_disable_bindings true)
  (set vim.g.codeverse_filetypes
         {:* false :markdown false :text false
          :plantuml true :dot true
          :fennel true :lua true :vim true
          :racket true
          :ruby true :rbs true :crystal true
          :python true :sh true
          :swift true :go true :rust true
          :c true :cpp true :objc true :make true})

  (vim.api.nvim_create_autocmd :User
   {:group :mine :pattern "codeverse.vim" :once true
    :desc "config codeverse"
    ; special key need to translate in vim language
    ; currently <C-e> mapped to <End>
    :callback #(vim.cmd "
      imap <script><silent><nowait><expr> <C-e> codeverse#Accept()
      let g:codeverse_tab_fallback = \"\\<End>\"
      imap <silent><script><nowait><expr> <C-]> codeverse#Clear() . \"\\<C-]>\"
      imap <M-]> <Plug>(codeverse-next-or-complete)
      imap <M-[> <Plug>(codeverse-previous)
      imap <C-k> <Plug>(codeverse-accept-word)
      imap <C-j> <Plug>(codeverse-accept-line)
    ")})

  (vim.keymap.set :i "<M-Bslash>"
   #(do (vim.fn.plug#load "codeverse.vim")
      (vim.notify "codeverse loaded")
      (vim.keymap.set :i "<M-Bslash>" "<Cmd>call codeverse#Complete()<CR>" {:remap true})
      (vim.fn.codeverse#Complete)))
  (vim.api.nvim_create_user_command "CodeverseLoad"
   "call plug#load('codeverse.vim') | echo 'Codeverse loaded'"
   {}))

{: setup}
  
