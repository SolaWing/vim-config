(module config.init)
(global f (require :deps.fun))
(require :config.util)

(fn colorfgbg []
  (-?> vim.env.COLORFGBG
       (vim.split ";")
       (match t (. t (length t)))
       (tonumber)))

(defn init []
  (when (= (-?> vim.env.COLORTERM
                (vim.stricmp :truecolor))
           0)
    (set vim.o.termguicolors true))

  (match (colorfgbg)
    color (set vim.o.background
               (if (> color 8)
                :light :dark)))
  
  (set vim.o.timeout false) ; avoid esc delay
  (set vim.o.inccommand :nosplit) ; substitute 预览
  (set vim.o.vdir "~/.vim/view")

  (set vim.g.python_host_prog "/usr/bin/python")
  (set vim.g.python3_host_prog "/usr/local/bin/python3")
  (when (= 1 (vim.fn.has :gui_vimr))
    (set vim.env.LANG "zh_CN.UTF-8"))
  
  (vim.ex "source ~/.vimrc")
  (vim.cmd
    "command! Fish sp | terminal /usr/local/bin/fish -l
     command! -bang Bwipeout lua require('config.function').Bwipeout('<bang>')"))
