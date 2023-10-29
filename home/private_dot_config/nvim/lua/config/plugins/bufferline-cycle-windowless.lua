local M = {
  "roobert/bufferline-cycle-windowless.nvim",
  dependencies = {
    { "akinsho/bufferline.nvim" },
  },
}

function M.config()
  local status_ok, bufferline_cycle_windowless = pcall(require, "bufferline-cycle-windowless")
  if not status_ok then
    return
  end

  bufferline_cycle_windowless.setup({
    -- whether to start in enabled or disabled mode
    default_enabled = true,
  })
end

return M
