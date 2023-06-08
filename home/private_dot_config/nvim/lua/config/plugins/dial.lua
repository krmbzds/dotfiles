local M = {
  "monaqa/dial.nvim",
  keys = { "<C-a>", "<C-x>" },
}

function M.config()
  local status_ok, dial_config = pcall(require, "dial.config")
  if not status_ok then
    return
  end

  local augend_ok, augend = pcall(require, "dial.augend")
  if not augend_ok then
    return
  end

  ---@diagnostic disable
  dial_config.augends:register_group({
    default = {
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,
      augend.constant.alias.bool,
      augend.date.alias["%Y-%m-%d"],
      augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
      augend.constant.new({ elements = { "[ ]", "[x]" }, word = false, cyclic = true }),
      augend.date.alias["%H:%M"],
    },
    visual = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y-%m-%d"],
      augend.date.alias["%H:%M"],
    },
  })
  ---@diagnostic enable

  local map = require("dial.map")
  local keymap = vim.api.nvim_set_keymap
  local opts = { noremap = true }

  keymap("n", "<C-x>", map.inc_normal(), opts)
  keymap("v", "<C-x>", map.inc_visual(), opts)
  keymap("v", "g<C-x>", map.inc_gvisual(), opts)
  keymap("n", "<C-a>", map.dec_normal(), opts)
  keymap("v", "<C-a>", map.dec_visual(), opts)
  keymap("v", "g<C-a>", map.dec_gvisual(), opts)
end

return M
