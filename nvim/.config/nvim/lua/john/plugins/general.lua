return {
  -- colors
 	 "savq/melange-nvim" ,
 	 "folke/tokyonight.nvim",
   "gilgigilgil/anderson.vim",
   "morhetz/gruvbox",
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
   { "rose-pine/neovim", name = "rose-pine" },
   -- indentation
   {
     "lukas-reineke/indent-blankline.nvim",
     main = "ibl",
     opts = {},
     config = function ()
       require "ibl".setup() end
   },
}
