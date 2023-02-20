(module config.keybinding)

(defn infomation []
  (vim.keymap.set :n ",." #(print ((. (require "config.function") :CursorContext)))))

(defn fzf-lua-bind []
  ; 大量加载fzf-lua后，大约消耗了6ms..
  ; 命令基本都是基于cwd的，而不是基于当前文件的...
  ; 虽然默认体验不够好，但是builtin的preview是杀手级特性.. fzf.vim还做不到..
  (local leader "<Leader>/")
  (fn f [...]
    (. (require :fzf-lua) ...))
  (require "config.fzf-lua-setup")

  (fn nmap [f t] (vim.keymap.set :n (.. leader f) t {:remap true}))
  (fn xmap [f t] (vim.keymap.set :x (.. leader f) t {:remap true}))

  (vim.keymap.set [:n :x] "//" leader {:remap true}) ; give another quick trigger

  ; Buffers And Files
  (nmap "b" #((f :buffers)))  ; open buffers
  (nmap "f" #((f :files)))  ; `find` or `fd` on a path
  (xmap "f" #((f :files) {:query ((f :utils :get_visual_selection))}))
  (nmap "hf" #((f :oldfiles)))  ; opened files history
  (nmap "q" #((f :quickfix)))  ; quickfix list
  (nmap "Q" #((f :quickfix_stack)))  ; quickfix stack
  (nmap "l" #((f :loclist)))  ; location list
  (nmap "L" #((f :loclist_stack)))  ; location stack
  (nmap "?" #((f :lines)))  ; open buffers lines
  (nmap "/" #((f :blines)))  ; current buffer lines
  (nmap "t" #((f :tabs)))  ; open tabs
  (nmap "a" #((f :args)))  ; argument list
  ; Search
  (nmap "s" #((f :grep))); search for a pattern with `grep` or `rg`
  (nmap "S" #((f :grep_last))); run search again with the last p
  (nmap "8" #((f :grep_cword))); search word under c
  (nmap "*" #((f :grep_cWORD))); search WORD under c
  (xmap "8" #((f :grep_visual))); search visual s
  (xmap "s" #((f :grep_visual)))
  ; (nmap "s" #((f :grep_project)); search all project lines, no files (fz#((f :vim's `:Rg`
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
    #((f type) {:path_shorten true :winopts {:preview {:hidden :hidden}}}))
  (nmap "T" (tags-wrap :tags)); search project tags
  (nmap "t" #((f :btags) {:ctags_autogen true})); search buffer tags
  (nmap "<C-t>" (tags-wrap :tags_grep)); grep project tags
  (xmap "t" (tags-wrap :tags_grep_visual)); `tags_grep` visual selection
  "
  | `tags_grep_cword`  | `tags_grep` word under cursor                |
  | `tags_grep_cWORD`  | `tags_grep` WORD under cursor                |
  | `tags_live_grep`   | live grep project tags                     |
  "
  ; GIT                                                              *fzf-lua-git*
  (nmap "gg" #((f :git_files))); `git ls-files`
  (xmap "gg" #((f :git_files) {:query ((f :utils :get_visual_selection))})); `git ls-files`
  (nmap "g<Space>" #((f :git_status))); `git status`
  ; action 需要适配一下
  ; (nmap "gC"   #((f :git_commits)); git commit log (project)                   )
  ; (nmap "gc"   #((f :git_bcommits)); git commit log (buffer)                    )
  (nmap "gb" #((f :git_branches))); git branches
  (nmap "gz" #((f :git_stash))); git stash

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
  (nmap "h;" #((f :command_history))); command history
  (nmap "h/" #((f :search_history))); search history
  (nmap "m" #((f :marks))); :marks
  (nmap "j" #((f :jumps))); :jumps
  (nmap "c" #((f :changes))); :changes
  (nmap "\"" #((f :registers))); :registers
  "
  | `tagstack`         | :tags                                      |
  | `keymaps`          | key mappings                               |
  | `filetypes`        | filetypes                                  |
  | `menus`            | menus                                      |
  | `spell_suggest`    | spelling suggestions                       |
  | `packadd`          | :packadd <package>                         |T)
  ")

(defn init []
  (infomation)
  (when (vim.plug? "fzf-lua") (fzf-lua-bind)))

