(fn encode [text]
  "对输入内容进行加密，返回加密后的base64. 注意换行是加密的一部分"
  (var output nil)
  (fn run [pass]
    (when pass
      (set output (vim.fn.system (.. "openssl aes-256-cbc -e -a -pbkdf2 -pass 'pass:" pass "'")
                                 text))))

  (vim.ui.input {:prompt "Enter the phrase: "} run)
  output)

(fn decode [text]
  "对输入内容进行加密，返回加密后的text"
  (var output nil)
  (fn run [pass]
    (when pass
      (set output (vim.fn.system (.. "openssl aes-256-cbc -d -a -pbkdf2 -pass 'pass:" pass "'")
                                 text))))

  (vim.ui.input {:prompt "Enter the phrase: "} run)
  output)

(fn encodeR []
  (case (encode (vim.fn.GetVisualString))
    text (do
           (set _G.V text)
           (vim.api.nvim_feedkeys (vim.keycode "gv\"=luaeval('V')<CR>p")
                                  "nx" false))))

(fn decodeR []
  (case (decode (vim.fn.GetVisualString))
    text (do
           (set _G.V text)
           (vim.api.nvim_feedkeys (vim.keycode "gv\"=luaeval('V')<CR>p")
                                  "nx" false))))

(local t {: encode : decode : encodeR : decodeR})
; (tset package.loaded :util.secret t)
t
