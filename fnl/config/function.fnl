(local M {})
; (local M (require "config.function"))

;;; this module store the function used by user, just like Command

(fn M.Bwipeout [bang]
  "wipe out all buffer, except the used one in window"
  (local bang (or bang ""))
  (local has_bang? (vim.true? bang))
  (let [buf_in_wins (collect [_k v (ipairs (vim.api.nvim_list_wins))]
                      (vim.api.nvim_win_get_buf v) true)]
    (var c 0)
    (var m 0)
    (fn clear [buf] ;do clear and count
      (set c (+ c 1))
      (vim.ex (.. buf "bwipeout" bang)))
    (each [_i buf (ipairs (vim.api.nvim_list_bufs))]
      (when (not (table.key? buf_in_wins buf))
        (if (. vim.bo buf :modified)
          (do (set m (+ m 1))
            (if has_bang?
              (clear buf)))
          (clear buf))))
    (print (: "wipeout %d buffers, %s %d modified" :format
              c
              (if has_bang?
                :include
                :left)
              m))))
  
(fn M.CursorContext []
  "return current cursor context info"
  (if
    ((. (require "nvim-treesitter.parsers") :has_parser))
    (vim.fn.nvim_treesitter#statusline)

    (vim.true? (vim.fn.exists "*tagbar#currenttag"))
    (vim.fn.tagbar#currenttag "%s" "" "s")

    nil))

M
