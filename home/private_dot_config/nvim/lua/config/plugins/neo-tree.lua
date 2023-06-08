local M = {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = { "Neotree" },
  branch = "v2.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
}

function M.config()
  local status_ok, neo_tree = pcall(require, "neo-tree")
  if not status_ok then
    return
  end

  local icons = require("config.icons").neo_tree
  local ignore = require("config.ignore")

  neo_tree.setup({
    sources = {
      "filesystem",
      "git_status",
      "buffers",
    },
    close_if_last_window = "false",
    popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
    default_component_configs = {
      indent = {
        indent_marker = icons.indent.IndentMarker,
        last_indent_marker = icons.indent.LastIndentMarker,
        expander_collapsed = icons.indent.ExpanderCollapsed,
        expander_expanded = icons.indent.ExpanderExpanded,
      },
      icon = {
        folder_closed = icons.icon.folder.Closed,
        folder_open = icons.icon.folder.Open,
        folder_empty = icons.icon.folder.Empty,
        default = icons.icon.Default,
      },
      modified = {
        symbol = icons.modified.Modified,
      },
      git_status = {
        symbols = {
          -- Change type
          added = icons.git_status.symbols.Added,
          deleted = icons.git_status.symbols.Deleted,
          modified = icons.git_status.symbols.Modified,
          renamed = icons.git_status.symbols.Renamed,
          -- Status type
          untracked = icons.git_status.symbols.Untracked,
          ignored = icons.git_status.symbols.Ignored,
          unstaged = icons.git_status.symbols.Unstaged,
          staged = icons.git_status.symbols.Staged,
          conflict = icons.git_status.symbols.Conflict,
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
        ["<tab>"] = function(state)
          local node = state.tree:get_node()
          if require("neo-tree.utils").is_expandable(node) then
            state.commands["toggle_node"](state)
          else
            state.commands["open"](state)
            vim.cmd("Neotree reveal")
          end
        end,
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["t"] = "open_tabnew",
        ["h"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        end,
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" then
            if not node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            elseif node:has_children() then
              require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
            end
          end
        end,
        ["P"] = "toggle_preview",
        ["z"] = "close_all_nodes",
        ["Z"] = "expand_all_nodes",
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
      follow_current_file = true,
      use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes instead of relying on nvim autocmd events.
      async_directory_scan = false, -- Scan files synchronously
      window = {
        mappings = {
          ["o"] = "system_open",
          ["e"] = "next_source",
          ["H"] = "toggle_hidden",
          ["/"] = "filter_as_you_type",
          -- ["/"] = "fuzzy_finder",
          ["f"] = "filter_on_submit",
          ["<esc>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        },
      },
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = ignore.file_ignore_patterns,
        -- never_show = { -- remains hidden even if visible is toggled to true
        --   --".DS_Store",
        --   --"thumbs.db"
        -- },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.api.nvim_command(string.format("silent !open '%s'", path))
        end,
      },
    },
    buffers = {
      bind_to_cwd = true,
      window = {
        mappings = {
          ["e"] = "next_source",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["bd"] = "buffer_delete",
        },
      },
    },
    git_status = {
      window = {
        mappings = {
          ["e"] = "close_window",
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
    event_handlers = {
      -- Close neo-tree when opening a file.
      {
        event = "file_opened",
        handler = function()
          require("neo-tree").close_all()
        end,
      },
    },
  })
end

return M
