return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  config = function()
    local status_ok, neogit = pcall(require, "neogit")
    if not status_ok then
      return
    end

    neogit.setup({
      disable_commit_confirmation = true,
      commit_popup = { kind = "split" },
      kind = "vsplit",
    })
  end,
}
