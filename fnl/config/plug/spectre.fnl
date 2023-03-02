(fn setup []
  ; config default in spectre directly
  ; (_G.hook-require :spectre
  ;  #($2.setup {:default {:replace {:cmd "oxi"}}
  ;              :replace_vim_cmd "cfdo"})
  ;  "spectre-setup")
  (fn spectre []
    (vim.fn.plug#load :nvim-spectre)
    (require :spectre))

  (fn search_input []
    (vim.ui.input {:prompt "Search: "}
                  #(when $1 ((. (spectre) :open)
                             {:search_text $1}))))
  (vim.keymap.set :n "<Leader>sr" search_input)
  (vim.keymap.set :x "<Leader>sr" #((. (spectre) :open_visual)))
  (vim.keymap.set [:n :x] "<Leader>x/" "<Leader>sr" {:remap true}))

{: setup}
