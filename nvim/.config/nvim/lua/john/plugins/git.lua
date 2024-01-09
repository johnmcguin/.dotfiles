return {
  -- TODO: look into
  -- lazygit https://github.com/jesseduffield/lazygit
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
}
