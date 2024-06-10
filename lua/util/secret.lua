-- [nfnl] Compiled from fnl/util/secret.fnl by https://github.com/Olical/nfnl, do not edit.
local function encode(text)
  local output = nil
  local function run(pass)
    if pass then
      output = vim.fn.system(("openssl aes-256-cbc -e -a -pbkdf2 -pass 'pass:" .. pass .. "'"), text)
      return nil
    else
      return nil
    end
  end
  vim.ui.input({prompt = "Enter the phrase: "}, run)
  return output
end
local function decode(text)
  local output = nil
  local function run(pass)
    if pass then
      output = vim.fn.system(("openssl aes-256-cbc -d -a -pbkdf2 -pass 'pass:" .. pass .. "'"), text)
      return nil
    else
      return nil
    end
  end
  vim.ui.input({prompt = "Enter the phrase: "}, run)
  return output
end
local function encodeR()
  local _3_ = encode(vim.fn.GetVisualString())
  if (nil ~= _3_) then
    local text = _3_
    _G.V = text
    return vim.api.nvim_feedkeys(vim.keycode("gv\"=luaeval('V')<CR>p"), "nx", false)
  else
    return nil
  end
end
local function decodeR()
  local _5_ = decode(vim.fn.GetVisualString())
  if (nil ~= _5_) then
    local text = _5_
    _G.V = text
    return vim.api.nvim_feedkeys(vim.keycode("gv\"=luaeval('V')<CR>p"), "nx", false)
  else
    return nil
  end
end
local t = {encode = encode, decode = decode, encodeR = encodeR, decodeR = decodeR}
return t
