local M = {
  "gbprod/yanky.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
  },
}

function M.config()
  local status_ok, yanky = pcall(require, "yanky")
  if not status_ok then
    return
  end

  local status_telescope_ok, telescope = pcall(require, "telescope")
  if not status_telescope_ok then
    return
  end

  telescope.load_extension("yank_history")

  yanky.setup({})
end

return M
