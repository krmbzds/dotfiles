local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

-- Give visual feedback when leap is active
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

leap.setup({})
