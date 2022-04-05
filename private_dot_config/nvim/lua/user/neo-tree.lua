local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
  return
end

local icons_ok, icons = pcall(require, "user.icons")
if not icons_ok then
  return
end

neo_tree.setup({
  popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
  default_component_configs = {
    indent = {
      indent_marker = icons.neo_tree.indent.IndentMarker,
      last_indent_marker = icons.neo_tree.indent.LastIndentMarker,
      expander_collapsed = icons.neo_tree.indent.ExpanderCollapsed,
      expander_expanded = icons.neo_tree.indent.ExpanderExpanded,
    },
    icon = {
      folder_closed = icons.neo_tree.icon.folder.Closed,
      folder_open = icons.neo_tree.icon.folder.Open,
      folder_empty = icons.neo_tree.icon.folder.Empty,
      default = icons.neo_tree.icon.Default,
    },
    modified = {
      symbol = icons.neo_tree.modified.Modified,
    },
    git_status = {
      symbols = {
        -- Change type
        added = icons.neo_tree.git_status.symbols.Added,
        deleted = icons.neo_tree.git_status.symbols.Deleted,
        modified = icons.neo_tree.git_status.symbols.Modified,
        renamed = icons.neo_tree.git_status.symbols.Renamed,
        -- Status type
        untracked = icons.neo_tree.git_status.symbols.Untracked,
        ignored = icons.neo_tree.git_status.symbols.Ignored,
        unstaged = icons.neo_tree.git_status.symbols.Unstaged,
        staged = icons.neo_tree.git_status.symbols.Staged,
        conflict = icons.neo_tree.git_status.symbols.Conflict,
      },
      align = "right",
    },
  },
  window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
    width = 35, -- applies to left and right positions
    popup = { -- settings that apply to float position only
      size = {
        height = "80%",
        width = "25%",
      },
      position = "50%", -- 50% means center it
      -- you can also specify border here, if you want a different setting from
      -- the global popup_border_style.
    },
    -- Mappings for tree window. See `:h nep-tree-mappings` for a list of built-in commands.
    -- You can also create your own commands by providing a function instead of a string.
    mappings = {
      ["<space>"] = "toggle_node",
      ["<2-LeftMouse>"] = "open",
      ["<cr>"] = "open",
      ["s"] = "open_split",
      ["v"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["h"] = "close_node",
      ["l"] = "toggle_node",
      ["z"] = "close_all_nodes",
      ["R"] = "refresh",
      ["a"] = "add",
      ["A"] = "add_directory",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination
      ["m"] = "move", -- takes text input for destination
      ["q"] = "close_window",
    },
  },
  filesystem = {
    window = {
      mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
      },
    },
    filtered_items = {
      visible = false, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
      },
      -- never_show = { -- remains hidden even if visible is toggled to true
      --   --".DS_Store",
      --   --"thumbs.db"
      -- },
    },
    follow_current_file = true,
    use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
    -- instead of relying on nvim autocmd events.
  },
  buffers = {
    bind_to_cwd = true,
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["bd"] = "buffer_delete",
      },
    },
  },
  git_status = {
    window = {
      mappings = {
        ["A"] = "git_add_all",
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
      },
    },
  },
})
