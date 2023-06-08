local api = vim.api
local fn = vim.fn

local function empty(s)
  return not s or s == ""
end

local function format(s)
  return fn.shellescape(s, 1):sub(2, -2)
end

local function echo(msg)
  api.nvim_echo({ { "grep.app: ", "Error" }, { msg } }, true, {})
end

local function cursorline()
  return format(fn.getline(".")) --- @diagnostic disable-line: param-type-mismatch
end

local function clipboard()
  return format(fn.getreg("+"):gsub("\n", " "))
end

local function input(args)
  fn.inputsave()
  local query = fn.input(args)
  fn.feedkeys(":", "nx")
  fn.inputrestore()
  return query
end

local function open(query)
  local job = require("plenary.job")
  local url = "https://grep.app/search?q="
  job:new({ command = "open", args = { url .. query } }):start()
end

-- stylua: ignore
local function grep_app(s, err)
  if not empty(s) then open(s) else echo(err) end
end

-- Commands

-- Search cursor line
api.nvim_create_user_command("GrepAppCursorLine", function()
  grep_app(cursorline(), "Cursor line empty")
end, { desc = "Search cursor line on grep.app" })

-- Search clipboard content
api.nvim_create_user_command("GrepAppClipboard", function()
  grep_app(clipboard(), "Clipboard empty")
end, { desc = "Search clipboard contents on grep.app" })

-- Search prompt
api.nvim_create_user_command("GrepAppInput", function()
  grep_app(input({ prompt = "grep.app: ", completion = "buffer" }), "Search cancelled")
end, { desc = "Search input on grep.app" })

-- Global functions
function REPEAT_LAST_MACRO_OR_Q()
  if pcall(function()
    return vim.fn.getreg("@@") == ""
  end) then
    vim.cmd("normal! @q")
  else
    vim.cmd("normal! @@")
  end
end
