local M = {
  "tversteeg/registers.nvim",
  keys = {
    { '"', mode = "n" },
    { '"', mode = "v" },
    { "<C-r>", mode = "i" },
  },
}

function M.config()
  local status_ok, registers = pcall(require, "registers")
  if not status_ok then
    return
  end

  registers.setup({
    window = {
      max_width = 0,
      border = "rounded",
      transparency = 20,
    },
  })
end

return M
