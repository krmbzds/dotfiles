---@diagnostic disable
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt

-- :help options
opt.laststatus = 3 -- global statusline
opt.backup = false -- creates a backup file
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.lazyredraw = true -- do not redraw screen in the middle of a macro
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.mousemodel = "extend" -- do now show popup window
opt.pumheight = 10 -- pop up menu height
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.undolevels = 1000
opt.updatetime = 300 -- faster completion (4000ms default)
opt.writebackup = true -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.wrap = false -- display lines as one long line
opt.scrolloff = 8 -- minimum number of lines to keep above/below cursor when scrolling
opt.sidescrolloff = 8
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.wildmode = "longest:full,full" -- change tab completion behavior
opt.shortmess:append("Ic") -- no intro message, no |ins-completion-menu| messages
opt.spelloptions = { "camel", "noplainbuffer" }
opt.foldcolumn = "auto:4"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.shada = "!,'0,f0,<50,s10,h"
opt.sessionoptions = "buffers,curdir,globals,tabpages,winpos,winsize" -- Session options to store in the session
---@diagnostic enable

-- disable builtin plugins
g.loaded_perl_provider = 0
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logiPat = 1
g.loaded_man = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_netrw = 1
g.loaded_netrwFileHandlers = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_remote_plugins = 1
g.loaded_rrhelper = 1
g.loaded_shada_plugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.sh_fold_enabled = 3
g.ts_highlight_lua = true

cmd("set whichwrap+=<,>,[,],h,l")
cmd([[set iskeyword+=-]])
cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])
