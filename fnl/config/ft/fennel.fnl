(module config.ft.fennel
  {autoload {fs aniseed.fs}})

(defn module->path [mod first]
  "return a array of match paths. or []
   first: only return the first match. nil if no match"
  (local mod-path (mod:gsub "%." fs.path-sep))
  (local paths [(.. :fnl fs.path-sep mod-path :.fnl)
                (.. :fnl fs.path-sep mod-path fs.path-sep :init.fnl)
                (.. :lua fs.path-sep mod-path :.lua)
                (.. :lua fs.path-sep mod-path fs.path-sep :init.lua)])
  (local t [])
  (each [_ path (ipairs (vim.api.nvim_list_runtime_paths))]
    (each [_ rel-path (ipairs paths)]
      (local p (.. path fs.path-sep rel-path))
      (if (= 1 (vim.fn.filereadable p))
        (do (when first (lua "return p"))
            (table.insert t p)))))
  (if first nil t)) ; first should early return

(defn goto-module [mod first]
  (local paths (module->path mod first))
  (fn edit [p] (vim.cmd.e (vim.fn.fnameescape p)))
  (if first
    (if paths (edit paths)
              (vim.notify "no match file found" vim.log.levels.WARN))

    (case (length paths)
      0 (vim.notify "no match file found" vim.log.levels.WARN)
      1 (edit (. paths 1))
      _ (vim.ui.select paths {:prompt "which file to choose? "}
                       #(when (not= nil $1) (vim.cmd.e (vim.fn.fnameescape $1)))))))

(comment
  (var a (select 2 (unpack [1 2 3])))
  (var paths ["/Users/wang/.config/nvim/fnl/config/ft/fennel.fnl" "/Users/wang/.config/nvim/lua/config/ft/fennel.lua"])
  (module->path "config.ft.fennel" true)
  (module->path "config.ft.fennel" false)
  (goto-module "config.plugs" true)
  (goto-module "config.plugs2" true)
  (goto-module "config.plugs" false)
  (goto-module "config.macros" false)
  (goto-module "config.macros2" false))
  
