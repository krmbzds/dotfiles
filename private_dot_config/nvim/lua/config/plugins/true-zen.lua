local M = {
  "Pocco81/true-zen.nvim",
  cmd = { "TZAtaraxis", "TZMinimalist", "TZNarrow", "TZFocus" },
}

function M.config()
  local status_ok, true_zen = pcall(require, "true-zen")
  if not status_ok then
    return
  end

  true_zen.setup({
    modes = {
      ataraxis = {
        ideal_writing_area_width = { 80 },
        quit = "close",
      },
    },
  })
end

return M
