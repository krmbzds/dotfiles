local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_ok then
  return
end

local mason_servers = {
  "solargraph",
  "sumneko_lua",
  "tsserver",
}

local mason_null_ls_servers = {
  "erb_lint",
  "jq",
  "prettierd",
  "shellcheck",
  "standardrb",
  "stylua",
  "tsserver",
  "vale",
}

local mason_settings = {
  ui = {
    border = "rounded",
  },
}

mason.setup(mason_settings)
mason_lspconfig.setup({
  ensure_installed = mason_servers,
  automatic_installation = true,
})
mason_null_ls.setup({
  ensure_installed = mason_null_ls_servers,
  automatic_installation = true,
})

local opts = {}

for _, server in pairs(mason_servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "sumneko_lua" then
    local neodev_status_ok, neodev = pcall(require, "neodev")
    if not neodev_status_ok then
      return
    end
    neodev.setup({})
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", opts, sumneko_opts)
    lspconfig.sumneko_lua.setup(opts)
    goto continue
  end

  if server == "solargraph" then
    local solargraph_opts = require("user.lsp.settings.solargraph")
    opts = vim.tbl_deep_extend("force", opts, solargraph_opts)
  end

  lspconfig[server].setup(opts)
  ::continue::
end
