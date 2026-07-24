(import-macros S :config.macros)

(fn setup []
  ((. (require "sidekick") :setup)
   {:nes {:enabled false}
    :cli {:tools {:coco {:cmd [:coco] :title "Coco AI"}
                  :traex {:cmd [:traex] :title "traex AI"}}
          :win {:keys {:buffers (S.MT ["<c-b>" "buffers"] {:mode "n" :desc "open buffer picker"})
                       :files (S.MT ["<c-f>" "files"] {:mode "n" :desc "open file picker"})}}}})
  (vim.keymap.set :n "<leader>at" #((. (require "sidekick.cli") :show) {:name "traex"}) {:desc "show sidekick"})
  (vim.keymap.set :n "<M-i>" "<leader>at" {:remap true})
  (vim.keymap.set :n "<leader>a<space>" "<leader>at" {:remap true})
  (vim.keymap.set :n "<C-.>" "<leader>at" {:remap true})
  (vim.keymap.set [:n :x] "<leader>a<CR>" #((. (require "sidekick.cli") :send) {:name "traex" :msg "{this}"}) {:desc "sidekick_send {this}"})
  (vim.keymap.set :n "<leader>af" #((. (require "sidekick.cli") :send) {:name "traex" :msg "{file}"}) {:desc "sidekick_send {file}"})
  (vim.keymap.set :x "<leader>av" #((. (require "sidekick.cli") :send) {:name "traex" :msg "{selection}"}) {:desc "sidekick_send {selection}"}))

{: setup}

