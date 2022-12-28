local M = {
  "stevearc/dressing.nvim",
}

function M.config()
  local status_ok, dressing = pcall(require, "dressing")
  if not status_ok then
    return
  end

  dressing.setup({
    input = {
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<C-p>"] = "HistoryPrev",
          ["<C-n>"] = "HistoryNext",
        },
      },
    },
  })
end

return M
