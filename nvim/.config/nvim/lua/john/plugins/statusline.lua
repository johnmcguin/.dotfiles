return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = "auto",
        },
        inactive_sections = {
          lualine_x = { "encoding", "fileformat" },
          lualine_y = {"progress"}
        }
      })
    end
  },
}
