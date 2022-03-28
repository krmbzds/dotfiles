local status_ok, true_zen = pcall(require, "true-zen")
if not status_ok then
  require("notify").notify("Error loading true-zen", "error")
  return
end

true_zen.setup()
