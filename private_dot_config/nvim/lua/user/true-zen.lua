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
  integrations = {
    gitsigns = true,
    nvim_bufferline = true,
    lualine = true,
  },
})
