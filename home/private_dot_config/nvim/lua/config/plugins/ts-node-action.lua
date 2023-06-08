local M = {
  "CKolkey/ts-node-action",
  dependencies = { "nvim-treesitter" },
}

function M.config()
  local status_ok, ts_node_action = pcall(require, "ts-node-action")
  if not status_ok then
    return
  end

  ts_node_action.setup({})
end

return M
