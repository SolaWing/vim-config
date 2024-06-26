(fn module->path [mod first]
  "nofirst: return a array of match paths. or []
   first: only return the first match. nil if no match"
  (local path-sep os.path-sep)
  (local mod-path (mod:gsub "%." path-sep))
  (local paths [(.. :fnl path-sep mod-path :.fnl)
                (.. :fnl path-sep mod-path path-sep :init.fnl)
                (.. :lua path-sep mod-path :.lua)
                (.. :lua path-sep mod-path path-sep :init.lua)])
  (local t [])
  (each [_ path (ipairs (vim.api.nvim_list_runtime_paths))]
    (each [_ rel-path (ipairs paths)]
      (local p (.. path path-sep rel-path))
      (if (= 1 (vim.fn.filereadable p))
        (do (when first (lua "return p"))
            (table.insert t p)))))
  (if first nil t)) ; first should early return

(fn goto-module [mod first open-cmd]
  (local paths (if (mod:find os.path-sep)
                (if first mod [mod]) ; normal file path with /, goto directly
                (module->path mod first)))
  (fn edit [p] (vim.cmd (-> [(or open-cmd "edit") (vim.fn.fnameescape p)]
                            (table.concat " "))))
  (if first
    (if paths (edit paths)
              (vim.notify "no match file found" vim.log.levels.WARN))

    (case (length paths)
      0 (vim.notify "no match file found" vim.log.levels.WARN)
      1 (edit (. paths 1))
      _ (vim.ui.select paths {:prompt "which file to choose? "}
                       #(when (not= nil $1) (edit $1))))))

;;; test
; (var a (select 2 (unpack [1 2 3])))
; (var paths ["/Users/wang/.config/nvim/fnl/config/ft/fennel.fnl" "/Users/wang/.config/nvim/lua/config/ft/fennel.lua"])
; (module->path "config.ft.fennel" true)
; (module->path "config.ft.fennel" false)
; (goto-module "config.plugs" true)
; (goto-module "config.plugs" true "tab drop")
; (goto-module "config.plugs2" true)
; (goto-module "config.plugs" false)
; (goto-module "config.macros" false)
; (goto-module "config.macros2" false)
; (goto-module "~/.vim/init.vim" false)

{: goto-module}
