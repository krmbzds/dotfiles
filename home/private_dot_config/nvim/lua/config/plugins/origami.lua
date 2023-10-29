local M = {
  "chrisgrieser/nvim-origami",
  event = "BufReadPost", -- later or on keypress would prevent saving folds
  opts = true, -- needed even when using default config
}

function M.config()
  local status_ok, origami = pcall(require, "origami")
  if not status_ok then
    return
  end

  origami.setup({
    keepFoldsAcrossSessions = true,
    pauseFoldsOnSearch = true,
    setupFoldKeymaps = true,
  })
end

return M
