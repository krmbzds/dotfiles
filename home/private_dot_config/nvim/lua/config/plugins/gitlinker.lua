local M = {
  "ruifm/gitlinker.nvim",
  keys = {
    { "<leader>gO", mode = "n" },
    { "<leader>go", "<leader>gc", mode = "v" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local status_ok, gitlinker = pcall(require, "gitlinker")
  if not status_ok then
    return
  end

  gitlinker.setup({
    opts = {
      callbacks = {
        ["github.com"] = require("gitlinker.hosts").get_github_type_url,
      },
      -- remote = 'github', -- force the use of a specific remote
      -- adds current line nr in the url for normal mode
      add_current_line_on_normal_mode = true,
      -- callback for what to do with the url
      action_callback = require("gitlinker.actions").copy_to_clipboard,
      -- print the url after performing the action
      print_url = false,
      -- mapping to call url generation
      mappings = nil,
    },
  })
end

return M
