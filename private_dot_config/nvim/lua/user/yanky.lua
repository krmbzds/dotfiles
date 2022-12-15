local status_ok, yanky = pcall(require, "yanky")
if not status_ok then
  return
end

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.load_extension("yank_history")

yanky.setup({})
