vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "asciidoc", "gitcommit", "markdown" },
  callback = function()
    ---@diagnostic disable
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    ---@diagnostic enable
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd("quit")
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Leap
local leap_illuminate = vim.api.nvim_create_augroup("LeapIlluminate", { clear = true })

vim.api.nvim_create_autocmd("User", {
  pattern = "LeapEnter",
  callback = function()
    require("illuminate").pause()
  end,
  group = leap_illuminate,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "LeapLeave",
  callback = function()
    require("illuminate").resume()
  end,
  group = leap_illuminate,
})

-- Go to last cursor position when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
