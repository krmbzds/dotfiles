local M = {
  "jiaoshijie/undotree",
}

function M.config()
  local status_ok, undotree = pcall(require, "undotree")
  if not status_ok then
    return
  end

  local ignore = require("config.ignore")

  undotree.setup({
    float_diff = true, -- using float window previews diff, set this `true` will disable layout option
    layout = "left_bottom", -- "left_bottom", "left_left_bottom"
    ignore_filetype = ignore.undotree_ignore_filetype,
    window = {
      winblend = 30,
    },
    keymaps = {
      ["j"] = "move_next",
      ["k"] = "move_prev",
      ["J"] = "move_change_next",
      ["K"] = "move_change_prev",
      ["<cr>"] = "action_enter",
      ["p"] = "enter_diffbuf",
      ["q"] = "quit",
    },
  })
end

return M
