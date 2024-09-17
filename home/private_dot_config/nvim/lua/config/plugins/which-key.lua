local M = {
  "folke/which-key.nvim",
}

function M.config()
  -- WhichKey
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  which_key.setup({
    preset = "modern",
    filter = function(mapping)
      return mapping.desc and mapping.desc ~= ""
    end,
    icons = {
      mappings = false,
    },
    win = {
      title = false,
    },
  })

  -- stylua: ignore start
  which_key.add({
    -- General mappings
    { "<leader>a", "<cmd>lua require('neogen').generate({})<cr>", desc = "Annotate" },
    { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
    { "<leader>q", "<cmd>q!<CR>", desc = "Quit" },
    { "<leader>c", "<cmd>lua require('bufdelete').bufdelete(0, false)<CR>", desc = "Close Buffer" },
    { "<leader>C", "<cmd>lua require('bufdelete').bufdelete(0, true)<cr>", desc = "Close Unsaved Buffer" },
    { "<leader>h", "<cmd>set invhlsearch<CR>", desc = "Toggle Highlight" },
    { "<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find File", },
    { "<leader>P", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
    { "<leader>r", "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", desc = "Recent Files" },
    { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Undotree" },
    { "<leader>z", "<cmd>:NoNeckPain<cr>", desc = "No Neck Pain" },
    { "<leader>?", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet" },

    -- Buffers
    { "<leader>b", group = "Buffers" },
    { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump" },
    { "<leader>bf", "<cmd>Neotree buffers position=float<cr>", desc = "Find" },
    { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous" },
    { "<leader>be", "<cmd>BufferLinePickClose<cr>", desc = "Pick which buffer to close" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close all to the left" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close all to the right" },
    { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort by directory" },
    { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language" },

    -- Debug
    { "<leader>d", group = "Debug" },
    { "<leader>dt", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>db", "<cmd>lua require('dap').step_back()<cr>", desc = "Step Back" },
    { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
    { "<leader>dC", "<cmd>lua require('dap').run_to_cursor()<cr>", desc = "Run To Cursor" },
    { "<leader>dd", "<cmd>lua require('dap').disconnect()<cr>", desc = "Disconnect" },
    { "<leader>dg", "<cmd>lua require('dap').session()<cr>", desc = "Get Session" },
    { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into" },
    { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
    { "<leader>du", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out" },
    { "<leader>dp", "<cmd>lua require('dap').pause.toggle()<cr>", desc = "Pause" },
    { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "Toggle Repl" },
    { "<leader>ds", "<cmd>lua require('dap').continue()<cr>", desc = "Start" },
    { "<leader>dq", "<cmd>lua require('dap').close(); require('dap.repl').close(); require('dapui').close()<cr>", desc = "Quit", },

    -- Lazy
    { "<leader>p", group = "Lazy" },
    { "<leader>po", "<cmd>lua require('lazy').home()<cr>", desc = "Home" },
    { "<leader>pi", "<cmd>lua require('lazy').install()<cr>", desc = "Install" },
    { "<leader>pu", "<cmd>lua require('lazy').update()<cr>", desc = "Update" },
    { "<leader>ps", "<cmd>lua require('lazy').sync()<cr>", desc = "Sync" },
    { "<leader>px", "<cmd>lua require('lazy').clean()<cr>", desc = "Clean" },
    { "<leader>pc", "<cmd>lua require('lazy').check()<cr>", desc = "Check" },
    { "<leader>pL", "<cmd>lua require('lazy').log()<cr>", desc = "Log" },
    { "<leader>pR", "<cmd>lua require('lazy').restore()<cr>", desc = "Restore" },
    { "<leader>pp", "<cmd>lua require('lazy').profile()<cr>", desc = "Profile" },
    { "<leader>pD", "<cmd>lua require('lazy').debug()<cr>", desc = "Debug" },
    { "<leader>pH", "<cmd>lua require('lazy').help()<cr>", desc = "Help" },
    { "<leader>pB", "<cmd>lua require('lazy').clear()<cr>", desc = "Clear" },
    { "<leader>pn", "<cmd>Telescope notify theme=ivy<cr>", desc = "Notifications" },
    { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" },

    -- Git
    { "<leader>g", group = "Git" },
    { "<leader>gg", "<cmd>lua require('neogit').open({ kind = 'split' })<cr>", desc = "Neogit" },
    { "<leader>gj", "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next hunk" },
    { "<leader>gk", "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Prev hunk" },
    { "<leader>gl", "<cmd>lua require('gitsigns').blame_line()<cr>", desc = "Blame line" },
    { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview hunk" },
    { "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset buffer" },
    { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset hunk" },
    { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage hunk" },
    { "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo stage hunk" },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },
    { "<leader>gO", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open in browser" },
    { "<leader>gh", "<cmd>GitBlameCopySHA<cr>", desc = "Copy hash" },

    -- LSP
    { "<leader>l", group = "LSP" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>lA", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 theme=ivy<cr>", desc = "Buffer Diagnostics" },
    { "<leader>lD", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>lf", "<cmd>Format<cr>", desc = "Format" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },

    -- Search
    { "<leader>s", group = "Search" },
    { "<leader>sf", "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", desc = "Find files" },
    { "<leader>sg", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Live Grep" },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>sc", "<cmd>Cheatsheet<cr>", desc = "Cheatsheet" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>sl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sp", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },
    { "<leader>sy", "<cmd>Telescope yank_history<cr>", desc = "Yank History" },
    { "<leader>sG", "<cmd>GrepAppInput<cr>", desc = "Web Grep" },

    -- Tabs
    { "<leader>t", group = "Tabs" },
    { "<leader>tc", "<cmd>tabclose<cr>", desc = "Close tab" },
    { "<leader>th", "<cmd>-tabmove<cr>", desc = "Move tab left" },
    { "<leader>tj", "<cmd>tabnext<cr>", desc = "Next tab" },
    { "<leader>tk", "<cmd>tabprevious<cr>", desc = "Previous tab" },
    { "<leader>tl", "<cmd>+tabmove<cr>", desc = "Move tab right" },
    { "<leader>tt", "<cmd>tab sb %<cr>", desc = "Move buffer to a new tab" },

    -- Neotest
    { "<leader>n", group = "Neotest" },
    { "<leader>no", "<cmd>lua require('neotest').summary.toggle()<CR>", desc = "Toggle summary" },
    { "<leader>nn", "<cmd>lua require('neotest').run.run()<CR>", desc = "Test nearest" },
    { "<leader>nf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Test file" },
    { "<leader>nl", "<cmd>lua require('neotest').run.run_last()<CR>", desc = "Run last test" },
    { "<leader>ns", "<cmd>lua require('neotest').run.run({ suite = true })<CR>", desc = "Test suite" },

    -- Visual mode mappings
    { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Comment", mode = "v", },
    { "<leader>g", group = "Git", mode = "v" },
    { "<leader>go", "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser })<CR>", desc = "Open in browser", mode = "v", },
    { "<leader>gc", "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').copy_to_clipboard })<CR>", desc = "Copy to clipboard", mode = "v", },
  })
end
-- stylua: ignore end

return M
