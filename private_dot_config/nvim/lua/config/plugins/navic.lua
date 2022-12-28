local M = {
  "SmiteshP/nvim-navic",
  dependencies = { "neovim/nvim-lspconfig" },
}

function M.config()
  local status_navic_ok, navic = pcall(require, "nvim-navic")
  if not status_navic_ok then
    return
  end

  navic.setup({})
end

return M
