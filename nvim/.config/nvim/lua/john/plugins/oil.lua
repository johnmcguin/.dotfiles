return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup({
      delete_to_trash = true,
      view_options = {
        show_hidden = true
      }
    })
    local actions = require("oil.actions")
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<C-v>", function ()
      require("oil").select({vertical = true})
    end, { desc = "Open the entry under the cursor in vertical split" })
  end 
}
