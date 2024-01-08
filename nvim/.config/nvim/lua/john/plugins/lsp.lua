-- LspAttach auto command to attach lsp keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local bufnr = event.buf
    -- these will be buffer-local keybindings
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", {buffer = bufnr, desc = "Hover"})
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {buffer = bufnr, desc = "[G]o to [D]efinition"})
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {buffer = bufnr, desc = "[G]o to [D]eclaration"})
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {buffer = bufnr, desc = "[G]o to [I]mplementation"})
    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {buffer = bufnr, desc = "[G]o to type definition"})
    vim.keymap.set("n", "gr", function ()
      require("telescope.builtin").lsp_references()
    end, { buffer = bufnr, desc = "[G]o to [R]eferences"})
    -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", {buffer = bufnr, desc = "[G]o to [R]eferences"})
    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {buffer = bufnr, desc = "[G]o to [S]ignature help"})
    vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", {buffer = bufnr, desc = "[G]o to Code [A]ctions"})
    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", {buffer = bufnr, desc = "rename"})
    vim.keymap.set({"n", "x"}, "<leader><leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {buffer = bufnr, desc = "Format"})
  end
})

return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  { "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      {"rafamadriz/friendly-snippets"}
    },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.setup({})
      lsp_zero.format_on_save({
        format_opts = {
          async = false,
          timeout_ms = 10000
        },
        servers = {
          ["elixirls"] = {"elixir"}
        }
      })

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {"tsserver", "eslint", "elixirls", "elmls"},
        handlers = {
          lsp_zero.default_setup,
          -- see section on usage with mason-lspconfig -> https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/lsp.md#commands
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = {"vim"}
                  }
                }
              }
            })
          end
        },
      })

      -- cmp stuff
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()
      local cmp_format = lsp_zero.cmp_format()
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        sources = {
          {name = "nvim_lsp"},
          {name = "luasnip"},
        },
        mapping = cmp.mapping.preset.insert({
          -- select the selected item with <CR> (instead of default <C-y>
          ["<CR>"] = cmp.mapping.confirm({select = false}),
          -- Enable tab navigation behavior through the completion menu
          -- If this is undesirable, see https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#enable-super-tab
          -- atm, I can"t tell the diff between the two options in the documentation. I need to just experience it and see if I like it.
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab()
        }),
        formatting = cmp_format
      })

      -- null ls
      local null_ls = require("null-ls")
      local null_opts = lsp_zero.build_options("null-ls", {})
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        on_attach = function(client, bufnr)
          null_opts.on_attach(client, bufnr)
          -- formatting keymapping
          vim.keymap.set({"n", "x"}, "<leader><leader>fmt", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {buffer = bufnr, desc = "Format"})
          -- autoformatting
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
        sources = {
          -- Replace these with the tools you have installed
          null_ls.builtins.formatting.prettierd,
        }
      })

    end
  },
}
