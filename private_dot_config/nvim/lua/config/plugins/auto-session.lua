local M = {
  "rmagatti/auto-session",
}

function M.config()
  local status_ok, auto_session = pcall(require, "auto-session")
  if not status_ok then
    return
  end

  local close_floating_windows = function()
    local api = vim.api
    for _, win in ipairs(api.nvim_list_wins()) do
      local config = api.nvim_win_get_config(win)
      if config.relative ~= "" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end

  auto_session.setup({
    log_level = "error",
    auto_session_suppress_dirs = { "/", "~/", "~/Downloads" },
    pre_save_cmds = { "Neotree close", "cclose", "lua vim.notify.dismiss()", close_floating_windows },
  })
end

return M
