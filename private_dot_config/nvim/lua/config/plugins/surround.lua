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
      insert = "<C-g>z",
      insert_line = "gC-ggZ",
      normal = "gz",
      normal_cur = "gZ",
      normal_line = "gzgz",
      normal_cur_line = "gZgZ",
      visual = "gz",
      visual_line = "gZ",
      delete = "gzd",
      change = "gzc",
    },
  })
end

return M
