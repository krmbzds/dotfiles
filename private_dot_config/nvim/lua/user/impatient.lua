local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  require("notify").notify("Error loading impatient", "error")
  return
end

impatient.enable_profile()
