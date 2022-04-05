local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
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

-- Navigate tabs
keymap("n", "<A-l>", ":tabnext<CR>", opts)
keymap("n", "<A-h>", ":tabprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==", opts)

-- Neotree
keymap("n", "<leader>E", "<cmd>Neotree toggle position=left<cr>", opts)
keymap("n", "<leader>e", "<cmd>Neotree toggle position=float<cr>", opts)
keymap("n", "<leader>0", "<cmd>Neotree focus<cr>", opts)

-- Unimpaired
keymap("n", "[a", ":previous<cr>", opts)
keymap("n", "]a", ":next<cr>", opts)
keymap("n", "[A", ":first<cr>", opts)
keymap("n", "]A", ":last<cr>", opts)
keymap("n", "[b", ":bprevious<cr>", opts)
keymap("n", "]b", ":bnext<cr>", opts)
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

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
