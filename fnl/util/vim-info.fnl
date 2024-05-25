(fn registers->vimscript []
  (local registers "qwertyuiopasdfghjklzxcvbnm0*")

  (fcollect [i 1 (length registers) 1]
      (let
        [char    (registers:sub     i i)
         reginfo (vim.fn.getreginfo char)]
        (when (~= reginfo.regcontents nil)
          (string.format "call setreg('%s', [%s], '%s')"
                         char
                         (table.concat (let [lines []]
                                         ; vim line may contains newline, expand into array
                                         (each [_ c (ipairs reginfo.regcontents)]
                                           (each [v (vim.gsplit c "\n" true)]
                                            (table.insert lines (string.format "'%s'"
                                                                 (string.gsub v "'" "''")))))
                                         lines)
                                       ", ")
                         reginfo.regtype)))))

(comment
  (local char "g")
  (local i 2))

{: registers->vimscript}
