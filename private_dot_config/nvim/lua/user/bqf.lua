local status_ok, bqf = pcall(require, "bqf")
if not status_ok then
  require("notify").notify("Error loading bqf", "error")
  return
end

bqf.setup({
  preview = {
    border_chars = { "│", "│", "─", "─", "╭", "╮", "╰", "╯", "█" },
  },
})
