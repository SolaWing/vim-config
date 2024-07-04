(local {: autoload} (require :config.deps))
(local fzf-lua (autoload :fzf-lua))

(fn common []
  (vim.keymap.set :n ",." #(print ((. (require "config.function") :CursorContext))) {:desc "CursorContext"})
  ; edit fnl file quickly
  (vim.keymap.set :n "<Leader>eI" "<Cmd>0tab drop ~/.vim/fnl/config/init.fnl<CR>" {:desc "tab init.fnl"})
  (vim.keymap.set :n "<Leader>eP" "<Cmd>0tab drop ~/.vim/fnl/config/plugs.fnl<CR>" {:desc "tab plugs.fnl"})
  (vim.keymap.set :n "<Leader>eK" "<Cmd>0tab drop ~/.vim/fnl/config/keybinding.fnl<CR>" {:desc "tab keybinding.fnl"})

  (vim.keymap.set :x "[?" ":lua require('util.secret').encodeR()<CR>" {:desc "encode selected line"})
  (vim.keymap.set :x "]?" ":lua require('util.secret').decodeR()<CR>" {:desc "decode selected line"}))


(fn fzf-lua-bind []
  ; 大量加载fzf-lua后，大约消耗了6ms..
  ; 命令基本都是基于cwd的，而不是基于当前文件的...
  ; 虽然默认体验不够好，但是builtin的preview是杀手级特性.. fzf.vim还做不到..

  (local leader "<Leader>/")

  (fn nmap [f t desc] (vim.keymap.set :n (.. leader f) t {:remap true :desc desc}))
  (fn xmap [f t desc] (vim.keymap.set :x (.. leader f) t {:remap true :desc desc}))
  (fn quote-visual [] (.. "'" (vim.fn.escape (fzf-lua.utils.get_visual_selection) " \t'\\") " "))

  ; special key map
  ; (vim.keymap.set [:n :x] "//" leader {:remap true}) ; give another quick trigger
  (vim.keymap.set [:n] "<M-Tab>" (.. leader "b") {:remap true})

  ; Buffers And Files
  (nmap "b"  #(fzf-lua.buffers {:winopts {:preview {:layout :vertical}}}) "fzf-lua.buffers")  ; open buffers
  (nmap "f"  #(fzf-lua.files) "fzf-lua.files")  ; `find` or `fd` on a path
  (xmap "f"  #(fzf-lua.files {:query (quote-visual)}) "fzf-lua.files")
  (nmap "hf" #(fzf-lua.oldfiles) "fzf-lua.oldfiles")  ; opened files history
  (nmap "q"  #(fzf-lua.quickfix) "fzf-lua.quickfix")  ; quickfix list
  (nmap "Q"  #(fzf-lua.quickfix_stack) "fzf-lua.quickfix_stack")  ; quickfix stack
  (nmap "l"  #(fzf-lua.loclist) "fzf-lua.loclist")  ; location list
  (nmap "L"  #(fzf-lua.loclist_stack) "fzf-lua.loclist_stack")  ; location stack
  (nmap "?"  #(fzf-lua.lines {:fzf_opts {:--layout :reverse-list}}) "fzf-lua.lines")  ; open buffers lines
  (xmap "?"  #(fzf-lua.lines {:fzf_opts {:--layout :reverse-list} :query (quote-visual)}) "fzf-lua.lines")  ; open buffers lines
  (nmap "/"  #(fzf-lua.blines {:fzf_opts {:--layout :reverse-list}}) "fzf-lua.blines")  ; current buffer lines
  (xmap "/"  #(fzf-lua.blines {:fzf_opts {:--layout :reverse-list} :query (quote-visual)}) "fzf-lua.blines")  ; current buffer lines
  (nmap "t"  #(fzf-lua.tabs) "fzf-lua.tabs")  ; open tabs
  (nmap "a"  #(fzf-lua.args) "fzf-lua.args")  ; argument list
  ; Search
  (nmap "s" #(fzf-lua.grep) "fzf-lua.grep"); search for a pattern with `grep` or `rg`
  (nmap "S" #(fzf-lua.grep_last) "fzf-lua.grep_last"); run search again with the last p
  (nmap "8" #(fzf-lua.grep_cword) "fzf-lua.grep_cword"); search word under c
  (nmap "*" #(fzf-lua.grep_cWORD) "fzf-lua.grep_cWORD"); search WORD under c
  (xmap "8" #(fzf-lua.grep_visual) "fzf-lua.grep_visual"); search visual s
  (xmap "s" #(fzf-lua.grep_visual) "fzf-lua.grep_visual")
  ; (nmap "s" #(fzf-lua.grep_project) search all project lines, no files (fz#(fm's `:Rg`
  "))
  | `grep_curbuf`      | search current buffer lines                |
  | `lgrep_curbuf`     | live grep current buffer                   |
  | `live_grep`        | live grep current project                  |
  | `live_grep_resume` | live grep continue last search             |
  | `live_grep_glob`   | live_grep with `rg --glob` support           |
  | `live_grep_native` | performant version of `live_grep`            |
  "
    ; tags
    ; 实现原理是pwd搜索tags文件，路径匹配上有些问题.., 路径也有些问题不够聚焦..
    ; 需要用下面的参数优化体验
    ; path_shorten 好像会影响到path的匹配..
  (fn tags-wrap [type]
    #((. fzf-lua type) {:path_shorten true :winopts {:preview {:hidden :hidden}}}))
  (nmap "<C-]>"     (tags-wrap :tags) "fzf-lua.tags")              ; search project tags
  (nmap "]" #(fzf-lua.btags {:ctags_autogen true}) "fzf-lua.btags") ; search buffer tags
  ; (nmap "<C-]>" (tags-wrap :tags_grep))         ; grep project tags
  (xmap "<C-]>" (tags-wrap :tags_grep_visual) "fzf-lua.tags_grep_visual")  ; `tags_grep` visual selection
  "
  | `tags_grep_cword`  | `tags_grep` word under cursor                |
  | `tags_grep_cWORD`  | `tags_grep` WORD under cursor                |
  | `tags_live_grep`   | live grep project tags                     |
  "
  ; GIT                                                              *fzf-lua-git*
  (nmap "gg"       #(fzf-lua.git_files) "fzf-lua.git_files"); `git ls-files`
  (xmap "gg"       #(fzf-lua.git_files {:query (quote-visual)}) "fzf-lua.git_files"); `git ls-files`
  (nmap "g<Space>" #(fzf-lua.git_status) "fzf-lua.git_status"); `git status`
  ; action 需要适配一下
  ; (nmap "gC"   #(fzf-lua.git_commits git commit log (project)                   )
  ; (nmap "gc"   #(fzf-lua.git_bcommits git commit log (buffer)                    )
  (nmap "gb" #(fzf-lua.git_branches) "fzf-lua.git_branches"); git branches
  (nmap "gz" #(fzf-lua.git_stash) "fzf-lua.git_stash"); git stash

  "
  LSP/DIAGNOSTICS                                      *fzf-lua-lsp/diagnostics*

  | Command          | List                                       |
  | ---------------- | ------------------------------------------ |
  | `lsp_references`             | References                       |
  | `lsp_definitions`            | Definitions                      |
  | `lsp_declarations`           | Declarations                     |
  | `lsp_typedefs`               | Type Definitions                 |
  | `lsp_implementations`        | Implementations                  |
  | `lsp_document_symbols`       | Document Symbols                 |
  | `lsp_workspace_symbols`      | Workspace Symbols                |
  | `lsp_live_workspace_symbols` | Workspace Symbols (live query)   |
  | `lsp_code_actions`           | Code Actions                     |
  | `lsp_incoming_calls`         | Incoming Calls                   |
  | `lsp_outgoing_calls`         | Outgoing Calls                   |
  | `diagnostics_document`       | Document Diagnostics             |
  | `diagnostics_workspace`      | Workspace Diagnostics            |
  | `lsp_document_diagnostics`   | alias to `diagnostics_document`    |
  | `lsp_workspace_diagnostics`  | alias to `diagnostics_workspace`   |
  "

  ; MISC                                                            *fzf-lua-misc*
  ; | `resume`           | resume last command/query                  |
  ; | `builtin`          | fzf-lua builtin commands                   |
  ; | `profiles`         | fzf-lua configuration profiles             |
  ; | `help_tags`        | help tags                                  |
  ; | `man_pages`        | man pages                                  |
  ; | `colorschemes`     | color schemes                              |
  ; | `highlights`       | highlight groups                           |
  ; | `commands`         | neovim commands                            |
  (nmap "h;" #(fzf-lua.command_history) "fzf-lua.command_history"); command history
  (nmap "h/" #(fzf-lua.search_history) "fzf-lua.search_history"); search history
  (nmap "m"  #(fzf-lua.marks) "fzf-lua.marks"); :marks
  (nmap "'"  #(fzf-lua.marks) "fzf-lua.marks"); :marks
  (nmap "j"  #(fzf-lua.jumps) "fzf-lua.jumps"); :jumps
  (nmap "c"  #(fzf-lua.changes) "fzf-lua.changes"); :changes
  (nmap "\"" #(fzf-lua.registers) "fzf-lua.registers"); :registers
  (when (vim.plug? "nvim-neoclip.lua")
      (nmap "h\"" #((require :neoclip.fzf)))
      (nmap "hq" #((require :neoclip.fzf) :q)))
  "
  | `tagstack`         | :tags                                      |
  | `keymaps`          | key mappings                               |
  | `filetypes`        | filetypes                                  |
  | `menus`            | menus                                      |
  | `spell_suggest`    | spelling suggestions                       |
  | `packadd`          | :packadd <package>                         |T)
  ")
  

  

(fn harpoon-bind []
  (vim.keymap.set :n "<Leader>p<Space>" #((. (require "harpoon.mark") :add_file)) {:desc "harpoon.mark"})
  (vim.keymap.set :n "<Leader>p<Tab>"   #((. (require "harpoon.ui")   :toggle_quick_menu)) {:desc "harpoon.ui"}))

(fn refactoring-bind []
  (vim.keymap.set [:x :n] "<Leader>xr" #((. (require "refactoring") :select_refactor)) {:desc "refactoring"}))

(fn leap-bind []
  (vim.keymap.set ["n" "x"] "<Space><CR>" #((. (require "config.plug.leap") :leap_to_line)) {:desc "leap_to_line"})
  (vim.keymap.set ["o"] "<Space><CR>" "V<Cmd>lua require('config.plug.leap').leap_to_line()<CR>" {:desc "leap_to_line"})
  ; TODO: unify surround and leap mapping ;
  ((. (require "leap") :add_default_mappings)))
  ; ((. (require "leap") :add_repeat_mappings) ";" "," {:relative_directions true
  ;                                                     :modes [:n :x :o]}))

(fn init []
  (common)
  (when (vim.plug? "fzf-lua") (fzf-lua-bind))
  (when (vim.plug? "harpoon") (harpoon-bind))
  (when (vim.plug? "refactoring.nvim") (refactoring-bind))
  (when (vim.plug? "leap.nvim") (leap-bind))
  (when (vim.plug? "nvim-spectre") ((. (require :config/plug/spectre) :setup))))

{: init}
