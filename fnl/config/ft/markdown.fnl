(fn toggle-list-item [kind]
  "kind: 0 cycle toggle. 1 remove. 2 normal item. 3 todo item"
  (local line (vim.fn.getline "."))
  (local patterns {:all "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)="
                   :no "^\\s*\\zs"})
  (local (start end) (-> (vim.regex patterns.all) (: :match_str line)))
  ; (print line kind start)
  (if (not start)
      ; no list item
      (match kind
        (where (or 0 2)) (vim.fn.setline "." (vim.fn.substitute line patterns.no "- " ""))
        1 (print "already no list item")
        3 (vim.fn.setline "." (vim.fn.substitute line patterns.no "- [ ] " "")))

      (<= (- end start) 2)
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

(comment
  (-> "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)="
      vim.regex
      (: :match_str "  - []abc"))
  (: (vim.regex "^\\v\\s*\\zs[-*] %(\\[[ xX]=\\] =)=") :match_str "  - []abc"))

{: toggle-list-item}
