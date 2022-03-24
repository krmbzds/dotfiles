local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require("user.icons")

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

dashboard.section.buttons.val = {
  dashboard.button("f", icons.documents.Files .. "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("e", icons.ui.NewFile .. "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", icons.git.Repo .. "  Find project", ":Telescope projects <CR>"),
  dashboard.button("r", icons.ui.History .. "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("t", icons.ui.List .. "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("c", icons.ui.Gear .. "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("q", icons.diagnostics.Error .. "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
