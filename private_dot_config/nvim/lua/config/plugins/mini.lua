local M = {
  "echasnovski/mini.nvim",
}

function M.config()
  local status_ok, mini_indentscope = pcall(require, "mini.indentscope")
  if not status_ok then
    return
  end

  local status_dracula_ok, dracula = pcall(require, "dracula")
  if status_dracula_ok then
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = dracula.colors().gutter_fg })
  end

  mini_indentscope.setup({
    symbol = "¦",
    draw = {
      delay = 100,
      animation = require("mini.indentscope").gen_animation.linear({
        easing = "in-out",
        duration = 20,
        unit = "total",
      }),
    },
  })
end

return M
