local M = {
  "shortcuts/no-neck-pain.nvim",
}

function M.config()
  local status_ok, no_neck_pain = pcall(require, "no-neck-pain")
  if not status_ok then
    return
  end

  local status_dracula_ok, dracula = pcall(require, "dracula")
  if not status_dracula_ok then
    return
  end

  local colors = dracula:colors()

  no_neck_pain.setup({
    buffers = {
      right = {
        enabled = false,
      },
    },
    colors = {
      background = colors.black,
      text = colors.comment,
    },
  })
end

return M
