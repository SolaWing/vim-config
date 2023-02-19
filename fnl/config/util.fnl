(module config.util
  {autoload {a aniseed.core}
   require-macros [config.macros]})

; TODO: 稳定后, 设置换成once, 预防意外修改 ;

;;; table extension
(fn table.key? [self k] (~= nil (. self k)))

;;; vim extension
;; eg:
;;  (vim.ex "edit" filepath)
;;  (vim.ex.edit filepath)
(set vim.ex (do (fn call_command [...] (-> [...]
                                           vim.tbl_flatten
                                           (table.concat " ")
                                           (vim.api.nvim_command)))
              (setmetatable
                {}
                {:__call #(call_command (select 2 $...))
                 :__index (fn [t k] (if (a.string? k) ; 防止异常数据，比如aniseed会尝试读[1]
                                      (do
                                        (local command (k:gsub "_$" "!")) ; call from lua no ! support
                                        #(call_command command $...))))})))

(fn vim.true? [v]
  "vim boolean check as lua boolean"
  (match (type v)
    "number" (~= 0 v)
    "nil" false
    "boolean" v
    "string" (vim.true? (tonumber v)) ; not same as vim string to number
    _ (error (.. "invalid type for vim boolean check: " (type v)))))
  
