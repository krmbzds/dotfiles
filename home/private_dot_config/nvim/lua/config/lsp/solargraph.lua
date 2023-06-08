local function solargraph_cmd()
  local ret_code = nil
  local jid = vim.fn.jobstart("grep -o solargraph Gemfile.lock", {
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

local solargraph_opts = {
  cmd = solargraph_cmd(),
  filetypes = { "ruby", "rakefile" },
  init_options = {
    formatting = false,
  },
  root_dir = require("lspconfig/util").root_pattern("Gemfile", ".git"),
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

return solargraph_opts
