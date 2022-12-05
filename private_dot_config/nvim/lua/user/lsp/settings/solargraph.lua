local util = require("lspconfig/util")

local solargraph_cmd = function()
  local ret_code = nil
  local jid = vim.fn.jobstart("bundle info solargraph", {
    on_exit = function(_, data)
      ret_code = data
    end,
  })
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then
    return { "bundle", "exec", "solargraph", "stdio" }
  end
  return { "solargraph", "stdio" }
end

local opts = {
  cmd = solargraph_cmd(),
  filetypes = { "ruby", "rakefile" },
  init_options = {
    formatting = false,
  },
  root_dir = util.root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      autoformat = false,
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true,
    },
  },
}

return opts
