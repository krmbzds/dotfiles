local status_ok, gtd = pcall(require, "gtd")
if not status_ok then
  return
end

gtd.setup({
  sources = {
    { name = "lsp" },
    { name = "findup" },
    { name = "walk" },
  },
  on_locations = function(_, locations)
    local function entry_maker(locs)
      local entries = {}
      for i, location in pairs(locs) do
        local row = location.targetSelectionRange.start.line + 1
        local col = location.targetSelectionRange.start.character + 1
        local fname = vim.uri_to_fname(location.targetUri)
        local rname = require("plenary.path"):new(fname):make_relative(vim.loop.cwd())
        local display = ("%s:%s:%s"):format(rname, row, col)
        entries[i] = { fname, display }
      end
      return entries
    end

    require("telescope.pickers")
      .new({}, {
        prompt_title = false,
        results_title = " Go to definition",
        layout_strategy = "bottom_pane",
        layout_config = {
          prompt_position = "bottom",
          width = 80,
          height = 9,
        },
        border = true,
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { "─", " ", " ", " ", "─", "─", " ", " " },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        sorter = require("telescope.sorters").get_generic_fuzzy_sorter({}),
        finder = require("telescope.finders").new_table({
          results = entry_maker(locations),
          entry_maker = function(result)
            return {
              value = result[1],
              display = result[2],
              ordinal = result[1],
            }
          end,
        }),
      })
      :find()
  end,
})
