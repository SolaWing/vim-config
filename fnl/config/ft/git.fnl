(module config.ft.git {})

(defn gv#parent [count]
  (local sha ((. vim.fn "gv#sha")))
  (case (length sha)
    0 (vim.notify "no sha found" vim.log.levels.WARN)
    _ (let [parent (vim.trim (vim.fn.system (vim.fn.FugitiveShellCommand [:rev-parse :--short (.. sha :^ count)])))
            pos (and (~= 0 (length parent)) (vim.fn.searchpos parent))]
        (if (and pos (~= 0 (. pos 1)))
          (vim.api.nvim_win_set_cursor 0 [(. pos 1) (- (. pos 2) 1)])
          (vim.notify "no parent sha found" vim.log.levels.WARN)))))
