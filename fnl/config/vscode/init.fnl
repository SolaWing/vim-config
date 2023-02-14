(module config.vscode.init)

(defn- settings []
  (set vim.g.mapleader " ")
  (set vim.g.maplocalleader ",")
  (set vim.g.is_bash 1))

(defn keybinding []
  ; navigation bindings
  (vim.keymap.set ["n" "x"] "<M-g>" "gd" {:remap true})
  (vim.keymap.set ["n" "x"] "©" "gd" {:remap true})
  (vim.keymap.set ["n" "x"] "<LocalLeader>gg" "gd" {:remap true})
  (vim.keymap.set ["n" "x"] "<LocalLeader>gr" "gH" {:remap true})
  (vim.keymap.set ["n" "x"] "<LocalLeader>gd" (fn [] (VSCodeNotify "editor.action.revealDeclaration"))))

(defn init []
  (vim.opt.runtimepath:remove (.. (os.getenv :HOME) "/.config/nvim"))
  (vim.opt.runtimepath:prepend (.. (os.getenv :HOME) "/.config/nvim/vscode"))
  (print "neovim in vscode" vim.o.runtimepath)

  (require :config.vscode.bind)
  (settings)
  (keybinding))

