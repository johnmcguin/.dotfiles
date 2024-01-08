local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- telescope
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- themes

	{ "savq/melange-nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "folke/tokyonight.nvim"},
  -- treesitter
	{ "nvim-treesitter/nvim-treesitter" },
	{ "nvim-treesitter/playground" },
  -- lsp
	{
	  "VonHeikemen/lsp-zero.nvim",
	  branch = "v3.x",
	  dependencies = {
	    -- LSP Support
	    {"neovim/nvim-lspconfig"},             -- Required
	    {"williamboman/mason.nvim"},           -- Optional
	    {"williamboman/mason-lspconfig.nvim"}, -- Optional

	    -- Autocompletion
	    {"hrsh7th/nvim-cmp"},     -- Required
	    {"hrsh7th/cmp-nvim-lsp"}, -- Required
	    {"L3MON4D3/LuaSnip"},     -- Required
      {"saadparwaiz1/cmp_luasnip"}, -- Allows for custom Lua Snippets
      {"rafamadriz/friendly-snippets"}
	  }
	},
  {
    "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" }
  },
  -- move to config after file
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    end
  },
  -- Comment
  { "numToStr/Comment.nvim" },
  { "nvim-lualine/lualine.nvim" },
})
