(module config.init)
; TODO: replace with aniseed fun for duplicate ;
(set _G.fun (require :deps.fun))
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
  (set vim.o.viewdir "~/.vim/view")
  ; disable File mark store(it will not clean and restore on each vim load)
  (set vim.o.shada "!,'999,<50,s10,h,f0")

  (set vim.g.python_host_prog "/usr/bin/python")
  (set vim.g.python3_host_prog "/usr/local/bin/python3")
  (when (= 1 (vim.fn.has :gui_vimr))
    (set vim.env.LANG "zh_CN.UTF-8"))
  
  (if
    ; todo: vscode neovim integration, change root and manual choose config file
    vim.g.vscode ((. (require :config.vscode.init) :init))
    (do
      (set vim.env.FZF_LUA_NVIM_BIN "nvim") ; fix vimr issue
      (vim.cmd "source ~/.vimrc
        command! Fish sp | terminal /usr/local/bin/fish -l
        command! -bang Bwipeout lua require('config.function').Bwipeout('<bang>')"))))
  
; (vim.fn.api_info)
; (. vim.g :conjure)
