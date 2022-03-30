return {
  settings = {

    Lua = {
      diagnostics = {
        globals = { "vim" },
        disable = {
          "different-requires",
        },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
