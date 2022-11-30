local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end

-- Give visual feedback when leap is active
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

-- Searching in all windows (including the current one) on the tab page.
function LEAP_ALL_WINDOWS()
  local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).focusable
  end, vim.api.nvim_tabpage_list_wins(0))
  require("leap").leap({ target_windows = focusable_windows_on_tabpage })
end

leap.setup({})

-- Keymaps
leap.set_default_keymaps()
keymap("n", "<C-s>", ":lua LEAP_ALL_WINDOWS()<cr>", opts)
