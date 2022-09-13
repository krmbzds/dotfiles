local util = require("lspconfig/util")
local opts = {
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby", "rakefile" },
  init_options = {
    formatting = false,
  },
  root_dir = util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      autoformat = false,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
}

return opts
