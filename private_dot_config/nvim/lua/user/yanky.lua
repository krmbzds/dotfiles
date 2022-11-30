local status_ok, yanky = pcall(require, "yanky")
if not status_ok then
  return
end

yanky.setup({})
