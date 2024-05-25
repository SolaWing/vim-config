(local core (require :nfnl.core))
(local config (require :nfnl.config))
(core.merge
  (config.default {:rtp-patterns ["/nfnl$" "/conjure$"]})
  {:source-file-patterns ["fnl/**/*.fnl"]
   :compiler-options {:compilerEnv _G}
   :rtp-patterns ["/nfnl$" "/conjure$"]})
