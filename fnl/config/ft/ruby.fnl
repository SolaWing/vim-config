(local M {})
; (local M (require :config.ft.ruby)))

(fn M.test_cmd [ty]
  "use b:test to run test, generate path and line by ty"
  (local ty (or ty :all))
  (local cmd (or vim.b.test vim.g.rubytest "bundle exec rake spec"))
  (fn rake_spec []
    (if (string.find cmd :rake) "SPEC=" ""))

  (local full_cmd
    (case ty
      :line (string.format "%s '%s%s:%d'" cmd (rake_spec) (vim.fn.expand "%:p") (vim.fn.line :.))
      :file (string.format "%s '%s%s'" cmd (rake_spec) (vim.fn.expand "%:p"))
      _ (string.format "%s" cmd)))
  full_cmd)

M
