local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local p = require("luasnip.extras").partial
local fmt = require("luasnip.extras.fmt").fmt
-- cool feature could be integration with treesitter.
-- get line before and log its data
local jsLog = function ()
  return s("ins", fmt("console.log({});", i(1)))
end

local function copy(args)
	return args[1]
end

local function date()
	return os.date("%m-%d-%Y")
end

ls.setup({
  update_events = "TextChanged,TextChangedI",
  enable_autosnippets = true
})
ls.add_snippets(nil, {
  -- markdown
  markdown = {
    s("journal", fmt([[
      ---
      date: {}
      ---
      ## Check In
      {}

      ## Review Yesterday's Things
      _personal_ - {}

      _professional_ - {}

      ## One Thing Personal
      1. {}

      ## One Thing Professional
      1. {}
      
      ## Gratitude
      1. {}
    ]], {f(date, {}), i(1), i(2), i(3), i(4), i(5), i(6)}))
  },
  -- JS ecosystem helpers
  typescriptreact = { jsLog() },
  typescript = { jsLog() },
  javascript = { jsLog() },
  -- elixir
  elixir = {
    s("ins", fmt([[
        IO.puts("""
        {} is
        #{{inspect({}, pretty: true)}}
        """)
      ]], { i(1), f(copy, 1) }))
  }
})

