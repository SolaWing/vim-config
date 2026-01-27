(local M {})
; (local M (require :config.ft.ruby)))

(fn M.test_cmd [ty]
  "use b:test to run test, generate path and line by ty"
  (local ty (or ty :all))
  (local cmd (or vim.b.test vim.g.rubytest "bundle exec rspec"))
  (fn rake_spec []
    (if (string.find cmd :rake) "SPEC=" ""))

  (local full_cmd
    (case ty
      :line (string.format "%s '%s%s:%d'" cmd (rake_spec) (vim.fn.expand "%:p") (vim.fn.line :.))
      :file (string.format "%s '%s%s'" cmd (rake_spec) (vim.fn.expand "%:p"))
      _ (string.format "%s" cmd)))
  full_cmd)

(fn M.rspec_dir []
  "return rspec_dir or nil"
  (local buf (vim.api.nvim_buf_get_name 0))
  ; (local dir "/Users/bytedance/Workspace/Repositories/MainProduct/ios-client/.w2/bin/lib/lark-project")
  ; (icollect [dir _ (vim.fs.parents buf)] dir)
  (each [dir _ (vim.fs.parents buf)]
    (local helper-path (vim.fs.joinpath dir "spec" "spec_helper.rb"))
    (when (vim.uv.fs_stat helper-path)
      (lua "return dir")))
  ;; 未找到返回 nil
  (vim.fs.dirname buf))
  
M
