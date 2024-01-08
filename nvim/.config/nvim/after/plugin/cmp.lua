local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  },
  mapping = cmp.mapping.preset.insert({
    -- select the selected item with <CR> (instead of default <C-y>
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    -- Enable tab navigation behavior through the completion menu
    -- If this is undesirable, see https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#enable-super-tab
    -- atm, I can't tell the diff between the two options in the documentation. I need to just experience it and see if I like it.
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab()
  }),
  formatting = cmp_format
})
