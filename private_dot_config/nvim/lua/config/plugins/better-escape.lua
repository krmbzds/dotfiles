local M = {
  "max397574/better-escape.nvim",
  event = "InsertCharPre",
}

function M.config()
  local status_ok, better_escape = pcall(require, "better_escape")
  if not status_ok then
    return
  end

  better_escape.setup()
end

return M
