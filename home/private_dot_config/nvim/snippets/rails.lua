local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local s = luasnip.snippet
local t = luasnip.text_node
local c = luasnip.choice_node
local i = luasnip.insert_node

luasnip.add_snippets("rails", {
  s(
    "job",
    fmt(
      [[
      class {}Job < ActiveJob::Base
        queue_as :{}
        sidekiq_options retry: {}, backtrace: {}

        def perform({})
          {}
        end
      end
      ]],
      {
        i(1, "Example"),
        c(2, { t("default"), t("low"), t("high"), t("critical") }),
        i(3, "25"),
        i(4, "false"),
        i(5, "*args"),
        i(6),
      }
    )
  ),
})
