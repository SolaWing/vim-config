-- [nfnl] Compiled from fnl/config/plug/spectre.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  local function spectre()
    vim.fn["plug#load"]("nvim-spectre")
    return require("spectre")
  end
  local function search_input()
    local function _1_(_241)
      if _241 then
        return spectre().open({search_text = _241})
      else
        return nil
      end
    end
    return vim.ui.input({prompt = "Search: "}, _1_)
  end
  vim.keymap.set("n", "<Leader>sr", search_input)
  local function _3_()
    return spectre().open_visual()
  end
  vim.keymap.set("x", "<Leader>sr", _3_)
  return vim.keymap.set({"n", "x"}, "<Leader>x/", "<Leader>sr", {remap = true})
end
return {setup = setup}
