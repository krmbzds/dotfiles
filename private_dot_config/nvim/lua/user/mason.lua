local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
  return
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

local mason_servers = {
  "sumneko_lua",
  "solargraph",
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

local opts = {}

for _, server in pairs(mason_servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "sumneko_lua" then
    local lua_dev_status_ok, lua_dev = pcall(require, "lua-dev")
    if not lua_dev_status_ok then
      return
    end
    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
    opts = vim.tbl_deep_extend("force", opts, sumneko_opts)
    opts = vim.tbl_deep_extend("force", opts, require("lua-dev").setup())
    local luadev = lua_dev.setup({
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        settings = opts.settings,
      },
    })
    lspconfig.sumneko_lua.setup(luadev)
    goto continue
  end

  if server == "solargraph" then
    local solargraph_opts = require("user.lsp.settings.solargraph")
    opts = vim.tbl_deep_extend("force", opts, solargraph_opts)
  end

  lspconfig[server].setup(opts)
  ::continue::
end
