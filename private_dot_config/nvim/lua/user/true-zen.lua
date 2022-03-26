local status_ok, true_zen = pcall(require, "true-zen")
if not status_ok then
  return
end

true_zen.setup()
