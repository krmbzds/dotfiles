local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "RRethy/vim-illuminate",
    "abecodes/tabout.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "RRethy/nvim-treesitter-endwise",
    "RRethy/nvim-treesitter-textsubjects",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "kylechui/nvim-surround",
    "kevinhwang91/nvim-bqf",
  },
}

function M.config()
  local status_ok, configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  configs.setup({
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "comment",
      "cpp",
      "css",
      "dockerfile",
      "hcl",
      "html",
      "http",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "make",
      "python",
      "ruby",
      "scss",
      "toml",
      "typescript",
      "vim",
      "yaml",
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "" }, -- List of parsers to ignore installing
    autopairs = {
      enable = true,
    },
    autotag = {
      enable = true,
      filetypes = { "html", "xml", "javascript", "typescript" },
    },
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "" }, -- list of language that will be disabled
      -- additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
        },
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        include_surrounding_whitespace = true,
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]a"] = "@parameter.inner",
          ["]b"] = "@block.inner",
          ["]c"] = "@class.inner",
          ["]f"] = "@function.inner",
          ["]m"] = "@function.outer",
        },
        goto_next_end = {
          ["]eb"] = "@block.inner",
          ["]ec"] = "@class.inner",
          ["]ef"] = "@function.inner",
          ["]em"] = "@function.outer",
        },
        goto_previous_start = {
          ["[a"] = "@parameter.inner",
          ["[b"] = "@block.inner",
          ["[c"] = "@class.inner",
          ["[f"] = "@function.inner",
          ["[m"] = "@function.outer",
        },
        goto_previous_end = {
          ["[eb"] = "@block.inner",
          ["[ec"] = "@class.inner",
          ["[ef"] = "@function.inner",
          ["[em"] = "@function.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["]["] = "@parameter.inner" },
        swap_previous = { ["[]"] = "@parameter.inner" },
      },
    },
    textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
  })
end

return M
