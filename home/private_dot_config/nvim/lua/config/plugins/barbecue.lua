local M = {
  "utilyre/barbecue.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  local status_ok, barbecue = pcall(require, "barbecue")
  if not status_ok then
    return
  end

  local icons = require("config.icons").barbecue
  local ignore = require("config.ignore")

  barbecue.setup({
    attach_navic = false, -- whether to attach navic to language servers automatically
    create_autocmd = true, -- whether to create winbar updater autocmd
    include_buftypes = { "" }, -- buftypes to enable winbar in
    exclude_filetypes = ignore.barbecue_ignore_patterns, -- filetypes not to enable winbar in
    modifiers = {
      dirname = ":~:.", -- filename modifiers applied to dirname
      basename = "", -- filename modifiers applied to basename
    },
    custom_section = function() -- returns a string to be shown at the end of winbar
      return ""
    end,
    -- theme to be used which should be located under `barbecue.theme` module
    theme = "dracula", -- `auto` defaults to your current colorscheme
    show_modified = false, -- whether to replace file icon with the modified symbol when buffer is modified
    symbols = {
      modified = icons.symbols.modified, -- modification indicator
      ellipsis = icons.symbols.ellipsis, -- truncation indicator
      separator = icons.symbols.separator, -- entry separator
    },
    -- icons for different context entry kinds
    kinds = icons, -- `false` to disable kind icons
  })
end

return M
