local M = {
  "f-person/git-blame.nvim",
  cmd = {
    "GitBlameInit",
    "GitBlameEnable",
    "GitBlameDisable",
    "GitBlameToggle",
    "GitBlameOpenCommitURL",
    "GitBlameCopySHA",
    "GitBlameCopyCommitURL",
  },
}

function M.config()
  vim.g.gitblame_enabled = 1
  vim.g.gitblame_display_virtual_text = 0
  vim.g.gitblame_message_template = " <summary> • <date> • <author> "
  vim.g.gitblame_highlight_group = "Comment"
end

return M
