-- WhichKey
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local wk_setup = {
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
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local wk_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- stylua: ignore
local wk_mappings = {
  ["a"] = { "<cmd>Neogen<cr>", "Annotate" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>lua require('bufdelete').bufdelete(0, false)<CR>", "Close Buffer" },
  ["C"] = { "<cmd>lua require('bufdelete').bufdelete(0, true)<cr>", "Close Unsaved Buffer" },
  ["h"] = { "<cmd>set invhlsearch<CR>", "Toggle Highlight" },
  ["f"] = { "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Find File" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["r"] = { "<cmd>Telescope frecency theme=dropdown previewer=false<cr>", "Recent Files" },
  ["u"] = { "<cmd>lua require('undotree').toggle()<cr>", "Undotree" },
  ["z"] = { "<cmd>TZAtaraxis<cr>", "Zen Mode" },
  ["F"] = { "<cmd>TZFocus<cr>", "Focus Mode" },
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
    n = { "<cmd>Telescope notify theme=ivy<cr>", "Notifications" }
  },

  g = {
    name = "Git",
    g = { "<cmd>lua require('neogit').open()<cr>", "Neogit" },
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
    L = { "<cmd>lua vim.g.gitblame_display_virtual_text=1-vim.g.gitblame_display_virtual_text<cr>", "Toggle blame" },
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

local wk_vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- stylua: ignore
local wk_vmappings = {
  ["/"] = { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", "Comment" },
  g = {
    name = "Git",
    o = { "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').open_in_browser })<CR>", "Open in browser" },
    c = { "<cmd>lua require('gitlinker').get_buf_range_url('v', { action_callback = require('gitlinker.actions').copy_to_clipboard })<CR>", "Copy to clipboard" },
  },
}

-- Register which-key bindings
which_key.setup(wk_setup)
which_key.register(wk_mappings, wk_opts)
which_key.register(wk_vmappings, wk_vopts)

-- Keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- theprimeagen
keymap("n", "J", "mzJ`z", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

--Remap space as leader key (needs to be done before loading lazy.nvim)
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-A-l>", "<cmd>BufferLineMoveNext<CR>", opts)
keymap("n", "<S-A-h>", "<cmd>BufferLineMovePrev<CR>", opts)

-- Navigate tabs
keymap("n", "<A-l>", ":tabnext<CR>", opts)
keymap("n", "<A-h>", ":tabprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- Open links
keymap("n", "gx", [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]], opts)
keymap("n", "gX", "<cmd>GrepAppCursorLine<cr>", opts)
keymap("n", "gy", "<cmd>GrepAppClipboard<cr>", opts)

-- Neotree
keymap("n", "<leader>e", "<cmd>Neotree toggle position=left<cr>", opts)
keymap("n", "<leader>E", "<cmd>Neotree toggle position=float<cr>", opts)
keymap("n", "<leader>0", "<cmd>Neotree focus<cr>", opts)

-- Leap
-- stylua: ignore start
keymap("n", "s", "<cmd>lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<cr>", opts)
keymap("n", "gs", "<cmd>lua require('leap').leap { target_windows = require'leap.util'.get_enterable_windows() }<cr>", opts)
-- stylua: ignore end

-- Substitute
keymap("n", "S", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
keymap("n", "X", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
keymap("x", "S", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })

-- Yanky
-- default mappings
keymap("n", "p", "<Plug>(YankyPutAfter)", opts)
keymap("n", "P", "<Plug>(YankyPutBefore)", opts)
keymap("n", "gp", "<Plug>(YankyGPutAfter)", opts)
keymap("n", "gP", "<Plug>(YankyGPutBefore)", opts)
-- yank-ring
keymap("n", "<C-n>", "<Plug>(YankyCycleForward)", opts)
keymap("n", "<C-p>", "<Plug>(YankyCycleBackward)", opts)
-- preserve cut position on yank
keymap("n", "y", "<Plug>(YankyYank)", opts)
-- special put moves (inspired by Unimpaired)
keymap("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", opts)
keymap("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", opts)
keymap("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", opts)
keymap("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", opts)
keymap("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", opts)
keymap("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", opts)
keymap("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", opts)
keymap("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", opts)
keymap("n", "=p", "<Plug>(YankyPutAfterFilter)", opts)
keymap("n", "=P", "<Plug>(YankyPutBeforeFilter)", opts)

-- Unimpaired
keymap("n", "[A", ":first<cr>", opts)
keymap("n", "]A", ":last<cr>", opts)
keymap("n", "[B", ":bfirst<cr>", opts)
keymap("n", "]B", ":blast<cr>", opts)
keymap("n", "[l", ":lprevious<cr>", opts)
keymap("n", "]l", ":lnext<cr>", opts)
keymap("n", "[L", ":lfirst<cr>", opts)
keymap("n", "]L", ":llast<cr>", opts)
keymap("n", "[<C-L>", ":lpfile<cr>", opts)
keymap("n", "]<C-L>", ":lnfile<cr>", opts)
keymap("n", "[q", ":cprevious<cr>", opts)
keymap("n", "]q", ":cnext<cr>", opts)
keymap("n", "[Q", ":cfirst<cr>", opts)
keymap("n", "]Q", ":clast<cr>", opts)
keymap("n", "[<C-Q>", ":cpfile<cr>", opts)
keymap("n", "]<C-Q>", ":cnfile<cr>", opts)
keymap("n", "[t", ":tprevious<cr>", opts)
keymap("n", "]t", ":tnext<cr>", opts)
keymap("n", "[T", ":tfirst<cr>", opts)
keymap("n", "]T", ":tlast<cr>", opts)
keymap("n", "[<C-T>", ":ptprevious<cr>", opts)
keymap("n", "]<C-T>", ":ptnext<cr>", opts)

-- Gitsigns
keymap("n", "[g", "<cmd>Gitsigns prev_hunk<cr>", opts)
keymap("n", "]g", "<cmd>Gitsigns next_hunk<cr>", opts)

-- Insert --
-- Make Control+Backspace delete whole words
keymap("i", "<C-H>", "<C-W>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv-gv", opts)
keymap("x", "K", ":m '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Yanky
-- default mappings
keymap("x", "p", "<Plug>(YankyPutAfter)", opts)
keymap("x", "P", "<Plug>(YankyPutBefore)", opts)
keymap("x", "gp", "<Plug>(YankyGPutAfter)", opts)
keymap("x", "gP", "<Plug>(YankyGPutBefore)", opts)
-- preserve cut position on yank
keymap("x", "y", "<Plug>(YankyYank)", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
