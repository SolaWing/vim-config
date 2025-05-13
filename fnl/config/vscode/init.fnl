(local {: Plug : function} (require :config.plugs))
(global vscode (require :vscode))

(fn settings []
  (vim.cmd "augroup mine | augroup end") ; create mine group so can be used directly
  (set vim.g.mapleader " ")
  (set vim.g.maplocalleader ",")
  (set vim.g.is_bash 1)
  (vim.cmd "
           command! -nargs=1 KeepCursor call KeepCursor(<q-args>)
           command! -nargs=1 -complete=mapping -bar Map nmap <args>| xmap <args>| omap <args>
           command! -nargs=1 -complete=mapping -bar Noremap nnoremap <args>| xnoremap <args>| onoremap <args>
           ")
  ; compatible
  (set vim.g.hasCOC false))

(fn keybinding []
  "NOTE: 原生的一些功能需要remap，绑定会失效"
  (vim.cmd.source "~/.vim/meta-keybinding.vim")
  (vim.cmd.source "~/.vim/key-binding.vim")

  (fn remap-key [from to]
    (vim.keymap.set ["n" "x"] from to {:remap true}))

  (remap-key "<C-n>" #(vscode.with_insert #(vscode.action "editor.action.addSelectionToNextFindMatch")))
                       
  ;; navigation bindings
  (remap-key "<M-g>" "<C-]>")
  (remap-key "<LocalLeader>gg" "<C-]>")
  (remap-key "<LocalLeader>gr" "gH")
  (remap-key "<LocalLeader>gd" #(vscode.action "editor.action.revealDeclaration"))
  (remap-key "<C-w><M-g>" #(vscode.action "editor.action.revealDefinitionAside"))
  (remap-key "<C-w><LocalLeader>gg" "<C-w><M-g>")
  (remap-key "<LocalLeader>gf" #(vscode.action "editor.action.quickFix"))
  (vim.keymap.set ["n"] "<Leader>ee" "<Cmd>0tab drop ~/.vim/fnl/config/vscode/init.fnl<CR>" {:desc "vscode init file"})

  ;; various view jump
  (vim.keymap.set ["n"] "<F3>" #(vscode.action "outline.focus"))
  (vim.keymap.set ["n"] "<LocalLeader>m" #(vscode.action "workbench.action.gotoSymbol"))
  (vim.keymap.set ["n"] "-" #(vscode.action "workbench.files.action.showActiveFileInExplorer"))
  (vim.keymap.set ["n"] "<Leader>gs" #(vscode.action "workbench.scm.focus"))
  (vim.keymap.set ["n"] "<Leader>gb" #(vscode.action "gitlens.toggleFileBlame"))
  (vim.keymap.set ["n"] "<Leader>bl" #(vscode.action "workbench.action.showAllEditorsByMostRecentlyUsed"))

  (vim.api.nvim_create_user_command "FZBTags"
      #(vscode.action "workbench.action.quickOpen" (.. "@" (or $1.args "")))
      {:nargs :?})
  (vim.api.nvim_create_user_command "FZTags"
      #(vscode.action "workbench.action.quickOpen" (.. "#" (or $1.args "")))
      {:nargs :?})
  (vim.api.nvim_create_user_command "FZWindows" #(vscode.action "workbench.action.switchWindow") {})
  (remap-key "<Leader>e," #(vscode.action "workbench.action.openSettingsJson"))
  (remap-key "<Leader>ek" #(vscode.action "workbench.action.openGlobalKeybindings"))

  ;; windows, tabs, buffers
  (remap-key "<C-w>o" "<Cmd>Only<CR>")
  (remap-key "<Leader>to" "<Cmd>Tabonly<CR>")
  (remap-key "<Leader>tc" "<Cmd>Tabclose<CR>"))
  

(fn plugins []
  "NOTE: notworking function:
  quickfix terminal filepath-dep
  "

  (vim.fn.plug#begin "~/.vim/bundle")

  ; (vim.cmd.source "~/.vim/bundle-config/easymotion.vim")
  (Plug "ggandor/leap.nvim")
  (vim.cmd.source "~/.vim/bundle-config/sneak.vim")
  (vim.cmd.source "~/.vim/bundle-config/tpope.vim")
  ; (Plug "tpope/vim-fugitive" {:on []}) ; disabled for not working
  ; (Plug "tpope/vim-rhubarb" {:on []}) ; disabled for not working
  ; (Plug "junegunn/gv.vim" {:on []}) ; disabled for not working
  ; fzf not work
  ; (vim.cmd.source "~/.vim/bundle-config/junegunn.vim")

  ; vim-searchindex
  (Plug "google/vim-searchindex")
  (set vim.g.searchindex_line_limit 20000)

  ; vim-signature
  (Plug "kshenoy/vim-signature")
  (set vim.g.SignaturePeriodicRefresh 0)
  ; (set vim.g.SignatureEnabledAtStartup 0)
  (set vim.g.SignatureUnconditionallyRecycleMarks 1)

  ; vim-dirvish, not usable
  (vim.cmd.source "~/.vim/bundle-config/devdocs.io.vim")
  ; (vim.cmd.source "~/.vim/bundle-config/grepper.vim")
  ; submode 导航不好用，vscode覆盖的原始语义
  ; (vim.cmd.source "~/.vim/bundle-config/submode.vim")
  ; 这个能用，但是不好用
  ; (vim.cmd.source "~/.vim/bundle-config/vim-visual-multi.vim")

  ; langs
  (Plug "tpope/vim-bundler" {:for :ruby})
  (Plug "tpope/vim-rake" {:for :ruby})

  (vim.cmd.source "~/.vim/bundle-config/conjure.vim")
  ; 体验很差，不开启lisp编辑
  ; (vim.cmd.source "~/.vim/bundle-config/lang/lisp.vim")

  (Plug "bakpakin/fennel.vim")

  ((. vim.fn :plug#end))
  (vim.cmd "silent doautocmd <nomodeline> User plug#end"))

(fn init []
  (local config-path (vim.fn.stdpath :config))
  ; replace default usable plugin and path
  (vim.opt.runtimepath:remove config-path)
  (vim.opt.runtimepath:prepend (.. config-path "/vscode-nvim"))
  ; print case deadlock？
  (print "neovim in vscode") ;vim.o.runtimepath))

  (require :config.vscode.bind)

  (function)
  (settings)
  (plugins)
  (keybinding))

{: init}
