local M = {
  "rcarriga/nvim-notify",
}

function M.config()
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    return
  end

  local icons = require("config.icons")

  notify.setup({
    -- Animation style (see below for details)
    stages = "static",
    -- Function called when a new window is opened, use for changing win settings/config
    on_open = function() end,
    -- Function called when a window is closed
    on_close = function() end,
    -- Render function for notifications. See notify-render()
    render = "default",
    -- Default timeout for notifications
    timeout = 2000,
    -- For stages that change opacity this is treated as the highlight behind the window
    -- Set this to either a highlight group or an RGB hex value e.g. "#000000"
    background_colour = "Normal",
    -- Minimum width for notification windows
    minimum_width = 10,
    -- Icons for the different levels
    icons = {
      ERROR = icons.diagnostics.Error,
      WARN = icons.diagnostics.Warning,
      INFO = icons.diagnostics.Information,
      DEBUG = icons.ui.Bug,
      TRACE = icons.ui.Pencil,
    },
  })

  vim.cmd([[
  highlight NotifyERRORBorder guifg=#FF9580
  highlight NotifyWARNBorder guifg=#FFCA80
  highlight NotifyINFOBorder guifg=#80FFEA
  highlight NotifyDEBUGBorder guifg=#FFFF80
  highlight NotifyTRACEBorder guifg=#9580FF
  highlight NotifyERRORIcon guifg=#FF9580
  highlight NotifyWARNIcon guifg=#FFCA80
  highlight NotifyINFOIcon guifg=#80FFEA
  highlight NotifyDEBUGIcon guifg=#FFFF80
  highlight NotifyTRACEIcon guifg=#9580FF
  highlight NotifyERRORTitle guifg=#FF9580
  highlight NotifyWARNTitle guifg=#FFCA80
  highlight NotifyINFOTitle guifg=#80FFEA
  highlight NotifyDEBUGTitle guifg=#FFFF80
  highlight NotifyTRACETitle guifg=#9580FF
  highlight link NotifyERRORBody Normal
  highlight link NotifyWARNBody Normal
  highlight link NotifyINFOBody Normal
  highlight link NotifyDEBUGBody Normal
  highlight link NotifyTRACEBody Normal
]])

  vim.notify = notify
end

return M
