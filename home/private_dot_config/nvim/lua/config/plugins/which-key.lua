local M = {
  "folke/which-key.nvim",
}

function M.config()
  -- WhichKey
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local setup = {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "rounded", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"}, -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  -- stylua: ignore
  local mappings = {
    ["a"] = { "<cmd>lua require('neogen').generate({})<cr>", "Annotate" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["c"] = { "<cmd>lua require('bufdelete').bufdelete(0, false)<CR>", "Close Buffer" },
    ["C"] = { "<cmd>lua require('bufdelete').bufdelete(0, true)<cr>", "Close Unsaved Buffer" },
    ["h"] = { "<cmd>set invhlsearch<CR>", "Toggle Highlight" },
    ["f"] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find File" },
    ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
    ["r"] = { "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", "Recent Files" },
    ["u"] = { "<cmd>lua require('undotree').toggle()<cr>", "Undotree" },
    ["z"] = { "<cmd>:NoNeckPain<cr>", "No Neck Pain" },
    ["?"] = { "<cmd>Cheatsheet<cr>", "Cheatsheet" },

    b = {
      name = "Buffers",
      j = { "<cmd>BufferLinePick<cr>", "Jump" },
      f = { "<cmd>Neotree buffers position=float<cr>", "Find" },
      b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
      e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
      h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
      l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
      D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
      L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
    },

    d = {
      name = "Debug",
      t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      b = { "<cmd>lua require('dap').step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
      C = { "<cmd>lua require('dap').run_to_cursor()<cr>", "Run To Cursor" },
      d = { "<cmd>lua require('dap').disconnect()<cr>", "Disconnect" },
      g = { "<cmd>lua require('dap').session()<cr>", "Get Session" },
      i = { "<cmd>lua require('dap').step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require('dap').step_over()<cr>", "Step Over" },
      u = { "<cmd>lua require('dap').step_out()<cr>", "Step Out" },
      p = { "<cmd>lua require('dap').pause.toggle()<cr>", "Pause" },
      r = { "<cmd>lua require('dap').repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require('dap').continue()<cr>", "Start" },
      q = { "<cmd>lua require('dap').close(); require('dap.repl').close(); require('dapui').close()<cr>", "Quit" },
    },

    p = {
      name = "Lazy",
      o = { "<cmd>lua require('lazy').home()<cr>", "Home" },
      i = { "<cmd>lua require('lazy').install()<cr>", "Install" },
      u = { "<cmd>lua require('lazy').update()<cr>", "Update" },
      s = { "<cmd>lua require('lazy').sync()<cr>", "Sync" },
      x = { "<cmd>lua require('lazy').clean()<cr>", "Clean" },
      c = { "<cmd>lua require('lazy').check()<cr>", "Check" },
      L = { "<cmd>lua require('lazy').log()<cr>", "Log" },
      R = { "<cmd>lua require('lazy').restore()<cr>", "Restore" },
      p = { "<cmd>lua require('lazy').profile()<cr>", "Profile" },
      D = { "<cmd>lua require('lazy').debug()<cr>", "Debug" },
      H = { "<cmd>lua require('lazy').help()<cr>", "Help" },
      B = { "<cmd>lua require('lazy').clear()<cr>", "Clear" },
      n = { "<cmd>Telescope notify theme=ivy<cr>", "Notifications" },
      m = { "<cmd>Mason<cr>", "Mason" },
    },

    g = {
      name = "Git",
      g = { "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", "Neogit" },
      j = { "<cmd>lua require('gitsigns').next_hunk()<cr>", "Next hunk" },
      k = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", "Prev hunk" },
      l = { "<cmd>lua require('gitsigns').blame_line()<cr>", "Blame line" },
      p = { "<cmd>lua require('gitsigns').preview_hunk()<cr>", "Preview hunk" },
      R = { "<cmd>lua require('gitsigns').reset_buffer()<cr>", "Reset buffer" },
      r = { "<cmd>lua require('gitsigns').reset_hunk()<cr>", "Reset hunk" },
      s = { "<cmd>lua require('gitsigns').stage_hunk()<cr>", "Stage hunk" },
      u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", "Undo stage hunk" },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
      O = { "<cmd>GitBlameOpenCommitURL<cr>", "Open in browser" },
      h = { "<cmd>GitBlameCopySHA<cr>", "Copy hash" },
    },

    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      A = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      d = { "<cmd>Telescope diagnostics bufnr=0 theme=ivy<cr>", "Buffer Diagnostics" },
      D = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "Format" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
    },

    s = {
      name = "Search",
      f = { "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", "Find files" },
      g = { "<cmd>Telescope live_grep theme=ivy<cr>", "Live Grep" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Cheatsheet<cr>", "Cheatsheet" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      l = { "<cmd>Telescope resume<cr>", "Last Search" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
      y = { "<cmd>Telescope yank_history<cr>", "Yank History" },
      G = { "<cmd>GrepAppInput<cr>", "Web Grep" },
    },

    t = {
      name = "Tabs",
      c = { "<cmd>tabclose<cr>", "Close tab" },
      h = { "<cmd>-tabmove<cr>", "Move tab left" },
      j = { "<cmd>tabnext<cr>", "Next tab" },
      k = { "<cmd>tabprevious<cr>", "Previous tab" },
      l = { "<cmd>+tabmove<cr>", "Move tab right" },
      t = { "<cmd>tab sb %<cr>", "Move buffer to a new tab" },
    },

    n = {
      name = "Neotest",
      o = { "<cmd>lua require('neotest').summary.toggle()<CR>", "Toggle summary" },
      n = { "<cmd>lua require('neotest').run.run()<CR>", "Test nearest" },
      f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", "Test file" },
      l = { "<cmd>lua require('neotest').run.run_last()<CR>", "Run last test" },
      s = { function()
        local neotest = require("neotest")
        for _, adapter_id in ipairs(neotest.state.adapter_ids()) do
          neotest.run.run({ suite = true, adapter = adapter_id })
        end
      end, "Test suite" },
    }
  }

  local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  -- stylua: ignore
  local vmappings = {
    ["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "Comment" },
    g = {
      name = "Git",
      o = { "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser })<CR>", "Open in browser" },
      c = { "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').copy_to_clipboard })<CR>", "Copy to clipboard" },
    },
  }

  -- Register which-key bindings
  which_key.setup(setup)
  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
