local fn = vim.fn
local loop = vim.loop
local opt = vim.opt
local icons = require("config.icons").lazy

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

opt.runtimepath:prepend(lazypath)

local opts = {
  defaults = {
    lazy = false,
  },
  concurrency = 8,
  checker = {
    enabled = false,
    concurrency = 8,
    notify = false,
    frequency = 3600,
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    icons = icons,
  },
}

require("lazy").setup("config.plugins", opts)
