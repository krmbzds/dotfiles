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
      nav = true, -- misc bindings to work with windows
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
  -- triggers = {"<leader>"} -- or specify a list manually
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
  ["a"] = { "<cmd>Neogen<cr>", "Annotate" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>set invhlsearch<CR>", "Toggle Highlight" },
  ["f"] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find File" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["u"] = { "<cmd>UndotreeToggle<cr>", "Undotree" },
  ["z"] = { "<cmd>TZAtaraxis<cr>", "Zen Mode"},
  ["F"] = { "<cmd>TZFocus<cr>", "Focus Mode"},
  ["?"] = { "<cmd>Cheatsheet<cr>", "Cheatsheet"},

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
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
    d = { "<cmd>PackerClean<cr>", "Clean" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
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
    L = { "<cmd>lua vim.g.gitblame_display_virtual_text=1-vim.g.gitblame_display_virtual_text<cr>", "Toggle blame"},
    O = { "<cmd>GitBlameOpenCommitURL<cr>", "Open in browser"},
    h = { "<cmd>GitBlameCopySHA<cr>", "Copy hash"},
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Telescope diagnostics bufnr=0 theme=ivy<cr>", "Buffer Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
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
    c = { "<cmd>Cheatsheet<cr>", "Cheatsheet"},
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", "Recent Files"},
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    p = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
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

  T = {
    name = "Terminal",
    d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Lazydocker" },
    r = { "<cmd>lua _RUBY_TOGGLE()<cr>", "Ruby" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
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
  ["/"] = { "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
  g = {
    name = "Git",
    o = { "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser })<CR>", "Open in browser" },
    c = { "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').copy_to_clipboard })<CR>", "Copy to clipboard" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
