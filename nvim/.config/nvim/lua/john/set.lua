-- show line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamed'

vim.g.mapleader = " "

-- registers mdx files for treesitter syntax highlighting
vim.filetype.add({
	extension = {
		mdx = "markdown.mdx",
	}
})
-- default colorscheme
vim.cmd("colorscheme catppuccin-frappe")
