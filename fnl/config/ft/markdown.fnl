(module config.ft.markdown {})

; (require "config.ft.markdown")
  
(defn toggle-list-item [kind]
  "kind: 0 cycle toggle. 1 remove. 2 normal item. 3 todo item"
  (local line (vim.fn.getline "."))
  (local patterns {:all "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)="
                   :no "^\\s*\\zs"})
  (local matches (vim.fn.matchstrpos line patterns.all))
  ; (print line kind (. matches 2))
  (if (= -1 (. matches 2))
      ; no list item
      (match kind
        (where (or 0 2)) (vim.fn.setline "." (vim.fn.substitute line patterns.no "- " ""))
        1 (print "already no list item")
        3 (vim.fn.setline "." (vim.fn.substitute line patterns.no "- [ ] " "")))

      (<= (- (. matches 3) (. matches 2))
         2)
      ; normal item
      (match kind
        (where (or 0 3)) (vim.fn.setline "." (vim.fn.substitute line patterns.all "- [ ] " ""))
        1 (vim.fn.setline "." (vim.fn.substitute line patterns.all "" ""))
        2 (print "already normal item"))

      ; todo item
      (match kind
        (where (or 0 1)) (vim.fn.setline "." (vim.fn.substitute line patterns.all "" ""))
        2 (vim.fn.setline "." (vim.fn.substitute line patterns.all "- " ""))
        3 (print "already todo item"))))
