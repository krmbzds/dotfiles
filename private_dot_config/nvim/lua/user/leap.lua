local status_ok, leap = pcall(require, "leap")
if not status_ok then
  require("notify").notify("Error loading leap", "error")
  return
end

leap.setup({})
leap.set_default_keymaps()
