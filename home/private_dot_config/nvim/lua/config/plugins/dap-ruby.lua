local M = {
  "suketa/nvim-dap-ruby",
}

function M.config()
  local dap_ruby_ok, dap_ruby = pcall(require, "dap-ruby")
  if not dap_ruby_ok then
    return
  end

  dap_ruby.setup()
end

return M
