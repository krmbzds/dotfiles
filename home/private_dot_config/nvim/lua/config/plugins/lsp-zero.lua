local M = {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    -- LSP Support
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "jose-elias-alvarez/null-ls.nvim",
    "jay-babu/mason-null-ls.nvim",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "krmbzds/friendly-snippets",

    -- Miscellaneous
    { "j-hui/fidget.nvim", branch = "legacy" },
  },
}

function M.config()
  local status_neodev_ok, neodev = pcall(require, "neodev")
  if not status_neodev_ok then
    return
  end

  local status_null_ls_ok, null_ls = pcall(require, "null-ls")
  if not status_null_ls_ok then
    return
  end

  local status_mason_null_ls_ok, mason_null_ls = pcall(require, "mason-null-ls")
  if not status_mason_null_ls_ok then
    return
  end

  local status_lsp_zero_ok, lsp = pcall(require, "lsp-zero")
  if not status_lsp_zero_ok then
    return
  end

  local status_navic_ok, navic = pcall(require, "nvim-navic")
  if not status_navic_ok then
    return
  end

  local status_fidget_ok, fidget = pcall(require, "fidget")
  if not status_fidget_ok then
    return
  end

  local icons = require("config.icons").diagnostics

  local lua_ls_opts = require("config.lsp.lua_ls")
  local solargraph_opts = require("config.lsp.solargraph")

  require("mason.settings").set({ ui = { border = "rounded" } })
  lsp.preset("recommended")
  lsp.set_preferences({
    suggest_lsp_servers = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = true,
    configure_diagnostics = true,
    cmp_capabilities = true,
    manage_nvim_cmp = false,
    call_servers = "local",
    sign_icons = {
      error = icons.Error,
      warn = icons.Warning,
      hint = icons.Hint,
      info = icons.Information,
    },
  })
  lsp.ensure_installed({ "solargraph", "lua_ls", "tsserver" })
  lsp.configure("lua_ls", lua_ls_opts)
  lsp.configure("solargraph", solargraph_opts)
  lsp.on_attach(function(client, bufnr)
    if vim.b.lsp_attached then
      return
    end
    vim.b.lsp_attached = true
    if client.name == "lua_ls" then
      neodev.setup({})
    end
    if client.server_capabilities["documentSymbolProvider"] then
      navic.attach(client, bufnr)
    end
  end)
  lsp.nvim_workspace(lua_ls_opts)
  lsp.setup()

  null_ls.setup({
    debug = false,
    sources = {
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.vale,
      null_ls.builtins.formatting.erb_lint,
      null_ls.builtins.formatting.jq,
      null_ls.builtins.formatting.prettierd.with({
        env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/prettier/config.json") },
      }),
      null_ls.builtins.formatting.standardrb,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.xmlformat,
    },
  })

  mason_null_ls.setup({
    ensure_installed = {
      "erb_lint",
      "jq",
      "prettierd",
      "shellcheck",
      "standardrb",
      "stylelint",
      "stylua",
      "taplo",
      "tsserver",
      "vale",
      "xmlformatter",
    },
    automatic_installation = true,
    automatic_setup = true,
  })

  local cmp_status_ok, cmp = pcall(require, "cmp")
  if not cmp_status_ok then
    return
  end

  local snip_status_ok, luasnip = pcall(require, "luasnip")
  if not snip_status_ok then
    return
  end

  local tabout_status_ok, tabout = pcall(require, "tabout")
  if not tabout_status_ok then
    return
  end

  local buffer_fts = {
    "markdown",
    "toml",
    "yaml",
    "json",
  }

  local function contains(t, value)
    for _, v in pairs(t) do
      if v == value then
        return true
      end
    end
    return false
  end

  local compare = require("cmp.config.compare")

  require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
  require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets
  luasnip.filetype_extend("ruby", { "rails" })

  local check_backspace = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  vim.g.cmp_active = true

  luasnip.config.setup({
    updateevents = "TextChanged,TextChangedI", -- dynamic snippets update as you type
  })

  cmp.setup({
    enabled = function()
      local buftype = vim.api.nvim_buf_get_option(0, "buftype")
      if buftype == "prompt" then
        return false
      end
      return vim.g.cmp_active
    end,
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item({}), { "i", "c" }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item({}), { "i", "c" }),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
      ["<m-o>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
      ["<C-u>"] = function()
        if luasnip.choice_active() then
          require("luasnip.extras.select_choice")()
        end
      end,
      -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-c>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<m-j>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<m-k>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<m-c>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<S-CR>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Right>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expandable() then
          luasnip.expand({})
        elseif cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        elseif vim.api.nvim_get_mode().mode == "i" then
          tabout.tabout()
        elseif check_backspace() then
          -- cmp.complete()
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- NOTE: order matters
        vim_item.menu = ({
          luasnip = "",
          nvim_lsp = "",
          nvim_lua = "",
          buffer = "",
          path = "",
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = {
      {
        name = "nvim_lsp",
        filter = function(entry, _) -- entry, ctx
          local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
          if kind == "Text" then
            return true
          end
        end,
        group_index = 2,
      },
      { name = "nvim_lua", group_index = 2 },
      { name = "luasnip", group_index = 2 },
      {
        name = "buffer",
        group_index = 2,
        filter = function(_, ctx) -- entry, ctx
          if not contains(buffer_fts, ctx.prev_context.filetype) then
            return true
          end
        end,
      },
      { name = "path", group_index = 2 },
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        compare.offset,
        compare.exact,
        -- compare.scopes,
        compare.score,
        compare.recently_used,
        compare.locality,
        -- compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      --[[ documentation = false, ]]
      documentation = {
        border = "rounded",
        winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
      },
      completion = {
        border = "rounded",
        winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
      },
    },
    experimental = {
      ghost_text = { hl_group = "NonText" },
    },
  })

  cmp.setup.cmdline(":", {
    sources = {
      { name = "cmdline" },
    },
  })

  cmp.setup.cmdline({ "/", "?", "@" }, {
    sources = {
      { name = "buffer" },
    },
  })

  fidget.setup({ text = { spinner = "square_corners" } })
end

return M
