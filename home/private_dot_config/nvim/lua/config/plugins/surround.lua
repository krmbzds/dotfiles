local M = {
  "kylechui/nvim-surround",
}

function M.config()
  local status_ok, surround = pcall(require, "nvim-surround")
  if not status_ok then
    return
  end

  surround.setup({
    keymaps = {
      insert = false,
      insert_line = false,
      normal_cur = false,
      normal_line = false,
      normal_cur_line = false,
      visual_line = false,
      normal = "s",
      visual = "s",
      delete = "ds",
      change = "cs",
    },
  })
end

return M
