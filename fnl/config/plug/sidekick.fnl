(fn setup []
  ((. (require "sidekick") :setup)
   {:nes {:enabled false}
    :cli {:tools {:coco {:cmd [:coco]
                         :title "Coco AI"}}}})
  (vim.keymap.set :n "<leader>at" #((. (require "sidekick.cli") :show) {:name "coco"}) {:desc "show sidekick"})
  (vim.keymap.set :n "<M-i>" "<leader>at" {:remap true})
  (vim.keymap.set :n "<leader>a<space>" "<leader>at" {:remap true})
  (vim.keymap.set :n "<C-.>" "<leader>at" {:remap true})
  (vim.keymap.set [:n :x] "<leader>a<CR>" #((. (require "sidekick.cli") :send) {:name "coco" :msg "{this}"}) {:desc "sidekick_send {this}"})
  (vim.keymap.set :n "<leader>af" #((. (require "sidekick.cli") :send) {:name "coco" :msg "{file}"}) {:desc "sidekick_send {file}"})
  (vim.keymap.set :x "<leader>av" #((. (require "sidekick.cli") :send) {:name "coco" :msg "{selection}"}) {:desc "sidekick_send {selection}"}))

{: setup}

