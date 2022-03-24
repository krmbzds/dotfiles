-- dracula.nvim color palette customization
vim.g.dracula_colors = {
  black = "#454158",
  red = "#FF9580",
  green = "#8AFF80",
  yellow = "#FFFF80",
  purple = "#9580FF",
  pink = "#FF80BF",
  cyan = "#80FFEA",
  white = "#F8F8F2",
  selection = "#454158",
  bright_red = "#FFAA99",
  bright_green = "#A2FF99",
  bright_yellow = "#FFFF99",
  bright_blue = "#AA99FF",
  bright_magenta = "#FF99CC",
  bright_cyan = "#99FFEE",
  bright_white = "#FFFFFF",
  bg = "#22212C",
  fg = "#F8F8F2",
  comment = "#7970A9",
  menu = "#21222C",
  visual = "#3E4452",
  gutter_fg = "#4B5263",
  nontext = "#3B4048",
}

-- dracula.nvim other options
vim.g.dracula_show_end_of_buffer = true
vim.g.dracula_transparent_bg = false
vim.g.dracula_lualine_bg_color = "#454158"
vim.g.dracula_italic_comment = true

-- set colorscheme with fallback
vim.cmd([[
try
  colorscheme dracula
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
