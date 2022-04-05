local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  return
end

local dap_ui_ok, dap_ui = pcall(require, "dapui")
if not dap_ui_ok then
  return
end

local dap_ruby_ok, dap_ruby = pcall(require, "dap-ruby")
if not dap_ruby_ok then
  return
end

local icons_ok, icons = pcall(require, "user.icons")
if not icons_ok then
  return
end

-- nvim-dap
local dap_config = {
  breakpoint = {
    text = icons.ui.Bug,
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = icons.ui.Bug,
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = icons.ui.ChevronRight,
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_config.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", dap_config.breakpoint_rejected)
vim.fn.sign_define("DapStopped", dap_config.stopped)

dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

-- nvim-dap-ui
local dap_ui_config = {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

-- Open dap-ui when debugger starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dap_ui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dap_ui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dap_ui.close()
end

dap_ui.setup(dap_ui_config)
dap_ruby.setup()
