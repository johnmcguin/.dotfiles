vim.g.mapleader = " "
-- normal mode remaps
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "[E]xplore files" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite file" })

-- when (n)exting search results, keep the cursor of the match in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")

-- move line
vim.keymap.set("n", "<C-j>", ":m +1<CR>==", { desc = "Move Line Down" })
vim.keymap.set("n", "<C-k>", ":m -2<CR>==", { desc = "Move Line Up" })

-- keep cursor in the middle of the screen when paginating
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "cw", "ciw")
vim.keymap.set("n", "dw", "diw")

-- quickly enter find & replace mode
vim.keymap.set("n", "<leader>fr", ":%s/", { desc = "[F]ind and [R]eplace" })

-- navigate buffers
vim.keymap.set("n", "<S-h>", ":bprev<CR>", { desc = "Navigate To Previous Buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Navigate To Next Buffer" })

-- multi screens
vim.keymap.set("n", "<leader>v", "<cmd> :vsplit<CR>", { desc = "[V]ertically Split Screen" })

-- insert mode remaps
-- exit insert mode quickly with jj 
vim.keymap.set("i", "jj", "<Esc>")

-- visual mode remaps
-- move highighlighted selections
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv", { desc = "Move Range Down" })
vim.keymap.set("v", "<C-k>", ":'<,'>m-2<CR>gv", { desc = "Move Range Up" })

-- quickly enter find & replace mode
vim.keymap.set("x", "<leader>fr", '"zy<Esc>:%s/<C-R>z//g<Left><Left>', { desc = "[F]ind and [R]eplace"})

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv^")
vim.keymap.set("v", ">", ">gv^")
-- stay in visual mode after visual mode yank
vim.keymap.set("v", "y", "ygv^")

-- diagnostics 
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostics - Open Float" })
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Diagnostics - previous diagnostic" })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Diagnostics - next diagnostic" })

-- source 
vim.keymap.set("n", "<leader>so", [[:source $MYVIMRC<CR>]], { desc = "[S]ource vimrc" })
