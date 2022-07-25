local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

-- Searching in all windows (including the current one) on the tab page.
function leap_all_windows()
  local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).focusable
  end, vim.api.nvim_tabpage_list_wins(0))
  require("leap").leap({ target_windows = focusable_windows_on_tabpage })
end

leap.setup({})
leap.set_default_keymaps()

keymap("n", "<C-s>", ":lua leap_all_windows()<cr>", opts)
