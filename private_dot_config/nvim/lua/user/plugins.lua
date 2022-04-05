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
  use({ "nvim-lua/popup.nvim" })
  use({ "MunifTanjim/nui.nvim" })
  use({ "rcarriga/nvim-notify" })
  use({ "kyazdani42/nvim-web-devicons" })

  -- UI
  -- stylua: ignore
  use({ "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" } })
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  use({ "SmiteshP/nvim-gps", requires = { "nvim-treesitter/nvim-treesitter", "nvim-lualine/lualine.nvim" } })
  use({ "karb94/neoscroll.nvim" })
  use({ "folke/which-key.nvim" })
  use({ "Pocco81/TrueZen.nvim" })

  -- Debug Adapter Protocol
  use({ "mfussenegger/nvim-dap" })
  use({ "suketa/nvim-dap-ruby", requires = { "mfussenegger/nvim-dap" } })
  use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

  -- Colorschemes
  use({ "Mofiqul/dracula.nvim" })
  use({ "br1anchen/nvim-colorizer.lua" })

  -- Completion
  use({ "hrsh7th/nvim-cmp" })
  use({ "hrsh7th/cmp-buffer", requires = { "hrsh7th/nvim-cmp" } })
  use({ "hrsh7th/cmp-path", requires = { "hhrsh7th/nvim-cmp" } })
  use({ "hrsh7th/cmp-cmdline", requires = { "hhrsh7th/nvim-cmp" } })
  use({ "saadparwaiz1/cmp_luasnip", requires = { "hhrsh7th/nvim-cmp" } })
  use({ "hrsh7th/cmp-nvim-lsp", requires = { "hhrsh7th/nvim-cmp" } })
  use({ "hrsh7th/cmp-nvim-lua", requires = { "hhrsh7th/nvim-cmp" } })

  -- Snippets
  use({ "L3MON4D3/LuaSnip" })
  use({ "rafamadriz/friendly-snippets" })
  use({ "danymat/neogen", requires = { "nvim-treesitter/nvim-treesitter" } })

  -- Language Server Protocol
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "williamboman/nvim-lsp-installer", requires = { "neovim/nvim-lspconfig" } })
  use({ "tamago324/nlsp-settings.nvim", requires = { "neovim/nvim-lspconfig" } })
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" } })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", requires = { "nvim-telescope/telescope.nvim" } })
  use({ "sudormrfbin/cheatsheet.nvim", requires = { "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim" } })
  use({ "nvim-telescope/telescope-frecency.nvim", requires = { "nvim-telescope/telescope.nvim", "tami5/sqlite.lua" } })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "numToStr/Comment.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "windwp/nvim-autopairs", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "RRethy/nvim-treesitter-endwise", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "RRethy/nvim-treesitter-textsubjects", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "windwp/nvim-ts-autotag", requires = { "nvim-treesitter/nvim-treesitter" } })
  use({ "ahmedkhalf/project.nvim" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "f-person/git-blame.nvim" })
  use({ "ruifm/gitlinker.nvim", requires = { "nvim-lua/plenary.nvim" } })

  -- Movement
  use({ "ggandor/leap.nvim" })
  use({ "abecodes/tabout.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

  -- Text editing helpers
  use({ "sQVe/sort.nvim" })
  use({ "monaqa/dial.nvim" })
  use({ "jiaoshijie/undotree" })

  -- Hacks
  use({ "moll/vim-bbye" })
  use({ "max397574/better-escape.nvim" })
  use({ "antoinemadec/FixCursorHold.nvim" }) -- This is needed to fix lsp doc highlight

  -- Other
  use({ "akinsho/toggleterm.nvim" })
  use({ "kevinhwang91/nvim-bqf", requires = { "nvim-treesitter/nvim-treesitter" } })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
