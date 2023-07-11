local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "olimorris/neotest-rspec",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
  },
}

function M.config()
  local status_ok, neotest = pcall(require, "neotest")
  if not status_ok then
    return
  end

  local status_rspec_ok, rspec = pcall(require, "neotest-rspec")
  if not status_rspec_ok then
    return
  end

  local icons = require("config.icons").neotest

  neotest.setup({
    adapters = {
      require("neotest-rspec"),
    },
    icons = {
      running_animated = icons.running_animated,
      passed = icons.passed,
      running = icons.running,
      failed = icons.failed,
      skipped = icons.skipped,
      unknown = icons.unknown,
    },
  })
end

return M
