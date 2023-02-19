(module config.function)
;;; this module store the function used by user

(defn Bwipeout [bang]
  "wipe out all buffer, except the used one in window"
  (var bang (or bang ""))
  (local has_bang? (not (a.empty? bang)))
  (let [buf_in_wins (collect [k v (ipairs (vim.api.nvim_list_wins))]
                      (vim.api.nvim_win_get_buf v) true)]
    (var c 0)
    (var m 0)
    (fn clear [buf] ;do clear and count
      (set c (+ c 1))
      (vim.ex (.. buf "bwipeout" bang)))
    (each [i buf (ipairs (vim.api.nvim_list_bufs))]
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
  
(defn CursorContext []
  (if
    ((. (require "nvim-treesitter.parsers") :has_parser))
    (vim.fn.nvim_treesitter#statusline)

    (vim.true? (vim.fn.exists "*tagbar#currenttag"))
    (vim.fn.tagbar#currenttag "%s" "" "s")

    nil))
