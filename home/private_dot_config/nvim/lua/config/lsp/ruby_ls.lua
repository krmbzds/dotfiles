local function ruby_ls_cmd()
  local ret_code = nil
  local jid = vim.fn.jobstart(
    "grep -rl ruby-lsp --include Gemfile --include Gemfile.lock --include *.gemspec --exclude-dir .ruby-lsp .",
    {
      on_exit = function(_, data)
        ret_code = data
      end,
    }
  )
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then
    return { "bundle", "exec", "ruby-lsp" }
  end
  return { "ruby-lsp" }
end

local enabled_features = {
  "codeActions",
  "diagnostics",
  "documentHighlights",
  "documentLink",
  "documentSymbols",
  "foldingRanges",
  -- "formatting",
  -- "hover",
  -- "inlayHint",
  -- "onTypeFormatting",
  "selectionRanges",
  "semanticHighlighting",
  "completion",
  "codeLens",
  "definition",
  "workspaceSymbol",
}

local ruby_ls_opts = {
  cmd = ruby_ls_cmd(),
  filetypes = { "ruby", "rakefile" },
  init_options = {
    enabledFeatures = enabled_features,
    formatter = "none",
  },
  root_dir = require("lspconfig/util").root_pattern("Gemfile", ".git"),
}

return ruby_ls_opts
