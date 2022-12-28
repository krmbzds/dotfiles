local M = {
  "kevinhwang91/nvim-bqf",
}

function M.config()
  local status_ok, bqf = pcall(require, "bqf")
  if not status_ok then
    return
  end

  bqf.setup({
    preview = {
      border_chars = { "│", "│", "─", "─", "╭", "╮", "╰", "╯", "█" },
    },
  })
end

return M
