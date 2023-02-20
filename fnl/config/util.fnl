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

(fn _G.hook-require [name callback id]
  ; lazy hook
  (when (not _G.my-require-hook) ; runtime hack shouldn't eval twice!!
    (let [old require
          hooks {}]
      (fn req [name]
        (or (. package.loaded name) ; avoid re-enter
            (do (local mod (old name))
              (match (. hooks name)
                hook-table (each [id callback (pairs hook-table)]
                             (callback name mod id)))
              mod)))
      (set _G.my-require-hook {: hooks ; {name => {id => callback(name mod id)}}
                               :hooked true
                               : old : req})

      (set _G.require req))) ; hook effect)

  ; add hook callback, reload can also trigger hooks. id can be use to overwrite
  (local hook-table (or (. _G.my-require-hook.hooks name)
                        (let [d {}] (tset _G.my-require-hook.hooks name d) d)))
  (if id (tset hook-table id callback)
    (table.insert hook-table callback))

  ; if loaded, invoke directly
  (match (. package.loaded name)
    mod (callback name mod id)))
