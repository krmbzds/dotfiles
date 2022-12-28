local M = {
  "gbprod/yanky.nvim",
  event = { "CmdlineEnter", "TextYankPost" },
  keys = {
    "<Plug>(YankyCycleBackward)",
    "<Plug>(YankyCycleForward)",
    "<Plug>(YankyGPutAfter)",
    "<Plug>(YankyGPutBefore)",
    "<Plug>(YankyPutAfter)",
    "<Plug>(YankyPutAfterFilter)",
    "<Plug>(YankyPutBefore)",
    "<Plug>(YankyPutBeforeFilter)",
    "<Plug>(YankyPutIndentAfterLinewise)",
    "<Plug>(YankyPutIndentAfterShiftLeft)",
    "<Plug>(YankyPutIndentAfterShiftRight)",
    "<Plug>(YankyPutIndentBeforeLinewise)",
    "<Plug>(YankyPutIndentBeforeShiftLeft)",
    "<Plug>(YankyPutIndentBeforeShiftRight)",
    "<Plug>(YankyYank)",
  },
  dependencies = {
    "kkharji/sqlite.lua",
  },
}

function M.config()
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
end

return M
