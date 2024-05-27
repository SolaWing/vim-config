(fn gv#parent [count]
  (local sha ((. vim.fn "gv#sha")))
  (case (length sha)
    0 (vim.notify "no sha found" vim.log.levels.WARN)
    _ (let [parent (vim.trim (vim.fn.system (vim.fn.FugitiveShellCommand [:rev-parse :--short (.. sha :^ count)])))]
        (if (and (~= 0 (length parent))
                 (~= 0 (vim.fn.search parent :s))) ; jump
            nil ; jump ok
            (vim.notify "no parent sha found" vim.log.levels.WARN)))))
(comment
  (tset (require :config.ft.git) :gv#parent gv#parent))

{: gv#parent}
