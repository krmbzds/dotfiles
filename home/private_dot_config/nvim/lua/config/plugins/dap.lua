local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui" },
    { "suketa/nvim-dap-ruby" },
  },
}

function M.config()
  local dap_ok, dap = pcall(require, "dap")
  if not dap_ok then
    return
  end

  local icons_ok, icons = pcall(require, "config.icons")
  if not icons_ok then
    return
  end

  -- nvim-dap
  local dap_config = {
    breakpoint = {
      text = icons.debugging.breakpoint,
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = icons.debugging.breakpoint_rejected,
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = icons.debugging.stopped,
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_config.breakpoint)
  vim.fn.sign_define("DapBreakpointRejected", dap_config.breakpoint_rejected)
  vim.fn.sign_define("DapStopped", dap_config.stopped)

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
end

return M
