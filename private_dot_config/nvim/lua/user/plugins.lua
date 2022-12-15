local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  -- stylua: ignore
  PACKER_BOOTSTRAP = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- Essentials
  use({ "wbthomason/packer.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "kkharji/sqlite.lua" })
  use({ "MunifTanjim/nui.nvim" })
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-tree/nvim-web-devicons" })
  use({ "gpanders/editorconfig.nvim" })

  use({
    "stevearc/dressing.nvim",
    config = function()
      require("user.dressing")
    end,
  })

  use({
    "rcarriga/nvim-notify",
    config = function()
      require("user.notify")
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
      config = function()
        require("user.lualine")
      end,
    },
  })

  use({
    "jiaoshijie/undotree",
    config = function()
      require("user.undotree")
    end,
  })

  -- Colorschemes
  use({
    "Mofiqul/dracula.nvim",
    config = function()
      require("user.colorscheme")
    end,
  })

  use({
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("user.colorizer")
    end,
  })

  -- UI
  use({
    "akinsho/bufferline.nvim",
    event = "UIEnter",
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("user.bufferline")
    end,
  })

  use({
    "nvim-neo-tree/neo-tree.nvim",
    cmd = { "Neotree" },
    branch = "v2.x",
    requires = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    config = function()
      require("user.neo-tree")
    end,
  })

  use({
    "karb94/neoscroll.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("user.neoscroll")
    end,
  })

  use({
    "folke/which-key.nvim",
    config = function()
      require("user.which-key")
    end,
  })

  use({
    "Pocco81/true-zen.nvim",
    cmd = { "TZAtaraxis", "TZMinimalist", "TZNarrow", "TZFocus" },
    config = function()
      require("user.true-zen")
    end,
  })

  -- Debug Adapter Protocol
  use({
    "mfussenegger/nvim-dap",
    event = { "BufRead", "BufNewFile" },
    requires = {
      {
        "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        config = function()
          require("user.dap-ui")
        end,
      },
      {
        "suketa/nvim-dap-ruby",
        after = { "nvim-dap", "nvim-dap-ui" },
        config = function()
          require("user.dap-ruby")
        end,
      },
    },
    config = function()
      require("user.dap")
    end,
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter" },
    requires = {
      {
        "L3MON4D3/LuaSnip",
        requires = {
          { "rafamadriz/friendly-snippets" },
          {
            "danymat/neogen",
            config = function()
              require("user.neogen")
            end,
          },
        },
      },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "folke/neodev.nvim" },
    },
    config = function()
      require("user.cmp")
    end,
  })

  -- Language Server Protocol
  use({
    "williamboman/mason.nvim",
    requires = {
      "williamboman/mason-lspconfig.nvim",
      requires = {
        "neovim/nvim-lspconfig",
        config = function()
          require("user.lsp.handlers").setup()
        end,
      },
    },
    config = function()
      require("user.mason")
    end,
  })

  use({
    "jayp0521/mason-null-ls.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "williamboman/mason.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
    },
    config = function()
      require("user.lsp.null-ls")
    end,
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("user.telescope")
    end,
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        after = { "telescope.nvim" },
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        after = { "telescope.nvim", "sqlite.lua" },
      },
      { "sudormrfbin/cheatsheet.nvim", after = { "telescope.nvim" } },
    },
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("user.treesitter")
    end,
    {
      "numToStr/Comment.nvim",
      after = { "nvim-treesitter" },
      keys = {
        { "n", "gc" },
        { "n", "gb" },
        { "v", "/" },
      },
      config = function()
        require("user.comment")
      end,
    },
    {
      "windwp/nvim-autopairs",
      after = { "nvim-treesitter" },
      config = function()
        require("user.autopairs")
      end,
    },
    {
      "RRethy/vim-illuminate",
      after = { "nvim-treesitter" },
      config = function()
        require("user.illuminate")
      end,
    },
    {
      "abecodes/tabout.nvim",
      after = { "cmp-nvim-lsp" },
      config = function()
        require("user.tabout")
      end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "RRethy/nvim-treesitter-endwise" },
    { "RRethy/nvim-treesitter-textsubjects" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "windwp/nvim-ts-autotag" },
    {
      "kylechui/nvim-surround",
      after = { "nvim-treesitter", "nvim-treesitter-textobjects" },
      config = function()
        require("user.surround")
      end,
    },
    {
      "kevinhwang91/nvim-bqf",
      after = { "nvim-treesitter" },
      config = function()
        require("user.bqf")
      end,
    },
  })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("user.gitsigns")
    end,
  })

  use({
    "f-person/git-blame.nvim",
    cmd = {
      "GitBlameInit",
      "GitBlameEnable",
      "GitBlameDisable",
      "GitBlameToggle",
      "GitBlameOpenCommitURL",
      "GitBlameCopySHA",
      "GitBlameCopyCommitURL",
    },
    config = function()
      require("user.git-blame")
    end,
  })

  use({
    "ruifm/gitlinker.nvim",
    keys = {
      { "v", "<leader>go" },
      { "v", "<leader>gc" },
    },
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.gitlinker")
    end,
  })

  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.neogit")
    end,
  })

  -- Movement
  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("user.project")
    end,
  })

  use({
    "hrsh7th/nvim-gtd",
    config = function()
      require("user.gtd")
    end,
  })

  use({
    "ggandor/leap.nvim",
    requires = {
      "ggandor/flit.nvim",
      config = function()
        require("flit").setup({})
      end,
    },
    config = function()
      require("user.leap")
    end,
  })

  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("user.ufo")
    end,
  })

  -- Text editing helpers
  use({ "sQVe/sort.nvim" })

  use({
    "monaqa/dial.nvim",
    keys = {
      { "n", "<C-a>" },
      { "n", "<C-x>" },
      { "v", "<C-a>" },
      { "v", "<C-x>" },
      { "v", "g<C-a>" },
      { "v", "g<C-x>" },
    },
    config = function()
      require("user.dial")
    end,
  })

  use({
    "gbprod/yanky.nvim",
    event = { "CmdlineEnter", "TextYankPost" },
    after = { "telescope.nvim" },
    keys = {
      "<Plug>(YankyCycleBackward)",
      "<Plug>(YankyCycleForward)",
      "<Plug>(YankyGPutAfter)",
      "<Plug>(YankyGPutBefore)",
      "<Plug>(YankyPutAfter)",
      "<Plug>(YankyPutAfterFilter)",
      "<Plug>(YankyPutBefore)",
      "<Plug>(YankyPutBeforeFilter)",
      "<Plug>(YankyPutIndentAfterLinewise)",
      "<Plug>(YankyPutIndentAfterShiftLeft)",
      "<Plug>(YankyPutIndentAfterShiftRight)",
      "<Plug>(YankyPutIndentBeforeLinewise)",
      "<Plug>(YankyPutIndentBeforeShiftLeft)",
      "<Plug>(YankyPutIndentBeforeShiftRight)",
      "<Plug>(YankyYank)",
    },
    config = function()
      require("user.yanky")
    end,
  })

  use({
    "gbprod/substitute.nvim",
    event = { "CmdlineEnter", "TextYankPost" },
    setup = function()
      require("user.substitute")
    end,
  })

  -- Hacks
  use({
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("user.better-escape")
    end,
  })

  use({ "antoinemadec/FixCursorHold.nvim", event = { "BufRead", "BufNewFile" } }) -- This is needed to fix lsp doc highlight

  use({ "famiu/bufdelete.nvim" })

  -- Other
  use({
    "akinsho/toggleterm.nvim",
    event = "BufWinEnter",
    config = function()
      require("user.toggleterm")
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
