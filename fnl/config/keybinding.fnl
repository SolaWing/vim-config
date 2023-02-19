(module config.keybinding)

(defn infomation []
  (vim.keymap.set :n ",." #(print ((. (require "config.function") :CursorContext)))))

(defn fzf-lua [])

(defn init []
  (infomation)
  (when (vim.plug? "fzf-lua") (fzf-lua)))

