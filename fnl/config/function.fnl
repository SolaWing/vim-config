(module config.function
  {autoload {nvim aniseed.nvim
             f deps.fun}})

(defn Bwipeout []
  "wipe out all buffer, except the used one in window"
  (let [wins [(unpack (vim.api.nvim_list_wins))]
        buf_in_wins nil]
    nil)
  (select 2  (unpack [1 2 3] 2 2))
  (f.flatmap #([1]) [1 2 3 4])
    
  (each [i v (ipairs vim.api.nvim_list_bufs)]
    (vim.api.nvim_buf_delete v)))
  

