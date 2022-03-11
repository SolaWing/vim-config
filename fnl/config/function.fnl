(module config.function)

(defn Bwipeout []
  "wipe out all buffer, except the used one in window"
  (let [buf_in_wins (collect [k v (ipairs (vim.api.nvim_list_wins))]
                      (vim.api.nvim_win_get_buf v) true)]
    (var c 0)
    (var m 0)
    (each [i buf (ipairs (vim.api.nvim_list_bufs))]
      (when (not (table.key? buf_in_wins buf))
        (if (. vim.bo buf :modified)
            (set m (+ m 1))
          (set c (+ c 1))
          (vim.api.nvim_command (.. buf "bwipeout")))))
    (print (: "wipeout %d buffers, left %d modified" :format c m))))
