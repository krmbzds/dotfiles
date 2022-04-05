local status_ok, dial_config = pcall(require, "dial.config")
if not status_ok then
  return
end

local augend_ok, augend = pcall(require, "dial.augend")
if not augend_ok then
  return
end

dial_config.augends:register_group({
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%H:%M"],
  },
  visual = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%H:%M"],
  },
})

local map = require("dial.map")
vim.api.nvim_set_keymap("n", "<C-x>", map.inc_normal(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-x>", map.inc_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-x>", map.inc_gvisual(), { noremap = true })
vim.api.nvim_set_keymap("n", "<C-a>", map.dec_normal(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-a>", map.dec_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-a>", map.dec_gvisual(), { noremap = true })
