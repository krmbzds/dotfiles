local M = {
  "gbprod/substitute.nvim",
  event = { "CmdlineEnter", "TextYankPost" },
}

function M.config()
  local status_ok, substitute = pcall(require, "substitute")
  if not status_ok then
    return
  end

  substitute.setup({
    on_substitute = function(event)
      require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
    end,
    yank_substituted_text = false,
    range = {
      prefix = "su",
      prompt_current_text = false,
      confirm = false,
      complete_word = false,
      motion1 = false,
      motion2 = false,
      suffix = "",
    },
    exchange = {
      motion = false,
      use_esc_to_cancel = true,
    },
  })
end

return M
