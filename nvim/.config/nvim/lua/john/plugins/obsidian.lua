-- full documentation: https://github.com/epwalsh/obsidian.nvim
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- Optional.
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-treesitter/nvim-treesitter"
  },
  opts = {
    workspaces = {
      {
        name = "dat",
        path = "~/Dat/vault",
      }
    },
    ui = {
      enable = false
    },
    -- more options available (see docs)
  },
}  
