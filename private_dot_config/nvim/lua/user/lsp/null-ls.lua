local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  debug = false,
  sources = {
    diagnostics.shellcheck,
    diagnostics.vale,
    formatting.erb_lint,
    formatting.jq,
    formatting.prettierd.with({
      env = {
        PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/prettier/config.json"),
      },
    }),
    formatting.standardrb,
    formatting.stylua,
  },
})
