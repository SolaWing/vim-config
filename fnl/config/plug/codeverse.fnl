(fn setup []
  (set vim.g.trae_no_map_tab true)
  (set vim.g.trae_disable_bindings true)
  (set vim.g.trae_filetypes
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
    :desc "config trae"
    ; special key need to translate in vim language
    ; currently <C-e> mapped to <End>
    :callback #(vim.cmd "
      imap <script><silent><nowait><expr> <C-e> trae#Accept()
      let g:trae_tab_fallback = \"\\<End>\"
      imap <silent><script><nowait><expr> <C-]> trae#Clear() . \"\\<C-]>\"
      imap <M-]> <Plug>(trae-next-or-complete)
      imap <M-[> <Plug>(trae-previous)
      imap <C-k> <Plug>(trae-accept-word)
      imap <C-j> <Plug>(trae-accept-line)
    ")})

  (vim.keymap.set :i "<M-Bslash>"
   #(do (vim.fn.plug#load "codeverse.vim")
      (vim.notify "trae loaded")
      (vim.keymap.set :i "<M-Bslash>" "<Cmd>call trae#Complete()<CR>" {:remap true})
      (vim.fn.trae#Complete)))
  (vim.api.nvim_create_user_command "TraeLoad"
   "call plug#load('codeverse.vim') | echo 'Trae loaded'"
   {}))

{: setup}
  
