(fn setup []
  (set vim.g.marscode_no_map_tab true)
  (set vim.g.marscode_disable_bindings true)
  (set vim.g.marscode_filetypes
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
    :desc "config marscode"
    ; special key need to translate in vim language
    ; currently <C-e> mapped to <End>
    :callback #(vim.cmd "
      imap <script><silent><nowait><expr> <C-e> marscode#Accept()
      let g:marscode_tab_fallback = \"\\<End>\"
      imap <silent><script><nowait><expr> <C-]> marscode#Clear() . \"\\<C-]>\"
      imap <M-]> <Plug>(marscode-next-or-complete)
      imap <M-[> <Plug>(marscode-previous)
      imap <C-k> <Plug>(marscode-accept-word)
      imap <C-j> <Plug>(marscode-accept-line)
    ")})

  (vim.keymap.set :i "<M-Bslash>"
   #(do (vim.fn.plug#load "codeverse.vim")
      (vim.notify "marscode loaded")
      (vim.keymap.set :i "<M-Bslash>" "<Cmd>call marscode#Complete()<CR>" {:remap true})
      (vim.fn.marscode#Complete)))
  (vim.api.nvim_create_user_command "MarscodeLoad"
   "call plug#load('codeverse.vim') | echo 'Marscode loaded'"
   {}))

{: setup}
  
