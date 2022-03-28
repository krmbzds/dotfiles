local icons_status_ok, icons = pcall(require, "user.icons")
if not icons_status_ok then
  require("notify").notify("Error loading icons", "error")
  return
end

local nvim_tree_icons = icons.nvim_tree
local diagnostic_icons = icons.diagnostics

vim.g.nvim_tree_icons = {
  default = nvim_tree_icons.Default,
  symlink = nvim_tree_icons.Symlink,
  git = {
    unstaged = nvim_tree_icons.Git.Unstaged,
    staged = nvim_tree_icons.Git.Staged,
    unmerged = nvim_tree_icons.Git.Unmerged,
    renamed = nvim_tree_icons.Git.Renamed,
    deleted = nvim_tree_icons.Git.Deleted,
    untracked = nvim_tree_icons.Git.Untracked,
    ignored = nvim_tree_icons.Git.Ignored,
  },
  folder = {
    default = nvim_tree_icons.Folder.Default,
    open = nvim_tree_icons.Folder.Open,
    empty = nvim_tree_icons.Folder.Empty,
    empty_open = nvim_tree_icons.Folder.Empty_open,
    symlink = nvim_tree_icons.Folder.Symlink,
  },
}

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  require("notify").notify("Error loading nvim-tree", "error")
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  require("notify").notify("Error loading nvim-tree config", "error")
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  update_to_buf_dir = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = diagnostic_icons.Hint,
      info = diagnostic_icons.Information,
      warning = diagnostic_icons.Warning,
      error = diagnostic_icons.Error,
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "h", cb = tree_cb("close_node") },
        { key = "v", cb = tree_cb("vsplit") },
      },
    },
    number = false,
    relativenumber = false,
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  quit_on_open = 0,
  git_hl = 1,
  disable_window_picker = 0,
  root_folder_modifier = ":t",
  show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1,
    tree_width = 30,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
})
