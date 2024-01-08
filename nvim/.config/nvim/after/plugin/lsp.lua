local lsp_zero = require("lsp-zero").preset({})

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  -- lsp_zero.default_keymaps({buffer = bufnr})
  -- local opts = {buffer = bufnr}
  -- For some reason lsp_zero.default_keymaps({buffer = bufnr}) was not working for me.
  -- manually creating the same bindings seems to work for whatever reason
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
  vim.keymap.set({"n", "x"}, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {buffer = bufnr, desc = "Format"})

  vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", {buffer = bufnr, desc = "[G]o to diagnostics"})
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {buffer = bufnr, desc = "previous [D]iagnostic"})
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", {buffer = bufnr, desc = "next [D]iagnostic"})
end)

lsp_zero.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000
  },
  servers = {
    ["elixirls"] = {"elixir"}
  }
})

lsp_zero.setup({})

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {"tsserver", "eslint", "elixirls", "elmls"},
  handlers = {
    lsp_zero.default_setup,
    -- see section on usage with mason-lspconfig -> https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/lsp.md#commands
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
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
-- configure servers after the mason-lspconfig setup
-- (Optional) Configure lua language server for neovim
-- require("lspconfig").lua_ls.setup(lsp_zero.nvim_lua_ls())
-- require("lspconfig").elixirls.setup({})
-- require("lspconfig").tsserver.setup({})
local null_ls = require("null-ls")
local null_opts = lsp_zero.build_options("null-ls", {})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
    ---
    -- you can add other stuff here....
    ---
    -- formatting keymapping
    vim.keymap.set("n", "<leader>fmt", ":lua vim.lsp.buf.format()<CR>", { desc = "[F]or[M]a[T] using lsp" })
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

