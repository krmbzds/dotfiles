local M = {
  "rcarriga/nvim-dap-ui",
}

function M.config()
  local dap_ok, dap = pcall(require, "dap")
  if not dap_ok then
    return
  end

  local dap_ui_ok, dap_ui = pcall(require, "dapui")
  if not dap_ui_ok then
    return
  end

  local icons = require("config.icons")
  local dap_ui_config = {
    icons = {
      expanded = icons.debugging.expanded,
      collapsed = icons.debugging.collapsed,
      current_frame = icons.debugging.current_frame,
    },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
    controls = {
      enabled = true,
      element = "repl",
      icons = {
        pause = icons.debugging.pause,
        play = icons.debugging.play,
        step_into = icons.debugging.step_into,
        step_over = icons.debugging.step_over,
        step_out = icons.debugging.step_out,
        step_back = icons.debugging.step_back,
        run_last = icons.debugging.run_last,
        terminate = icons.debugging.terminate,
      },
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
    dap_ui.open({})
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dap_ui.close({})
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dap_ui.close({})
  end

  dap_ui.setup(dap_ui_config)
end

return M
