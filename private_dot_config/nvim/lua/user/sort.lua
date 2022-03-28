local status_ok, sort = pcall(require, "sort")
if not status_ok then
  require("notify").notify("Error loading sort", "error")
  return
end

sort.setup({})
