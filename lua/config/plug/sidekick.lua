-- [nfnl] fnl/config/plug/sidekick.fnl
local function setup()
  require("sidekick").setup({nes = {enabled = false}, cli = {tools = {coco = {cmd = {"coco"}, title = "Coco AI"}}}})
  local function _1_()
    return require("sidekick.cli").show({name = "coco"})
  end
  vim.keymap.set("n", "<leader>at", _1_, {desc = "show sidekick"})
  vim.keymap.set("n", "<M-i>", "<leader>at", {remap = true})
  vim.keymap.set("n", "<leader>a<space>", "<leader>at", {remap = true})
  vim.keymap.set("n", "<C-.>", "<leader>at", {remap = true})
  local function _2_()
    return require("sidekick.cli").send({name = "coco", msg = "{this}"})
  end
  vim.keymap.set({"n", "x"}, "<leader>a<CR>", _2_, {desc = "sidekick_send {this}"})
  local function _3_()
    return require("sidekick.cli").send({name = "coco", msg = "{file}"})
  end
  vim.keymap.set("n", "<leader>af", _3_, {desc = "sidekick_send {file}"})
  local function _4_()
    return require("sidekick.cli").send({name = "coco", msg = "{selection}"})
  end
  return vim.keymap.set("x", "<leader>av", _4_, {desc = "sidekick_send {selection}"})
end
return {setup = setup}
