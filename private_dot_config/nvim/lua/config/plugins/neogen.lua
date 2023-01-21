local M = {
  "danymat/neogen",
  keys = {
    { "<leader>a", mode = "n" },
  },
}

function M.config()
  local status_ok, neogen = pcall(require, "neogen")
  if not status_ok then
    return
  end

  neogen.setup({
    snippet_engine = "luasnip",
    languages = {
      lua = {
        template = {
          annotation_convention = "emmylua",
        },
      },
      ruby = {
        template = {
          annotation_convention = "yard",
        },
      },
    },
  })
end

return M
