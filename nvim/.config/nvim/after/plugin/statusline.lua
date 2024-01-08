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
