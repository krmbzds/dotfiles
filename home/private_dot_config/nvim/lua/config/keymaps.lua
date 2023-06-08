-- Keymaps
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

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

-- Go to file
keymap("n", "gf", "<cmd>lua require('gtd').exec({ command = 'edit' })<cr>", opts)

-- Neotree
keymap("n", "<leader>e", "<cmd>Neotree toggle position=left<cr>", opts)
keymap("n", "<leader>E", "<cmd>Neotree toggle position=float<cr>", opts)
keymap("n", "<leader>0", "<cmd>Neotree focus<cr>", opts)

-- Leap
-- stylua: ignore start
keymap("n", "kj", "<cmd>lua require('leap').leap { target_windows = vim.tbl_filter(function(win) return vim.api.nvim_win_get_config(win).focusable end, vim.api.nvim_tabpage_list_wins(0)) }<cr>", opts)
-- stylua: ignore end

-- Substitute
keymap("n", "su", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
keymap("x", "su", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
keymap("n", "X", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
keymap("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })

-- Treesitter Node Action
keymap("n", "<A-n>", ":NodeAction<cr>", opts)

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

-- Center screen
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-o>", "<C-o>zz", opts)
keymap("n", "<C-i>", "<C-i>zz", opts)

-- Keep cursor in place when joining
keymap("n", "J", "mzJ`z", opts)
keymap("n", "gJ", "mzgJ`z", opts)

-- Repeat last macro with single key
keymap("n", ",", ":lua REPEAT_LAST_MACRO_OR_Q()<CR>", opts)

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

-- Sort selection
keymap("v", "&", ":Sort u<CR>", opts)

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
