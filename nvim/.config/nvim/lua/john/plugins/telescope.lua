
return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')
      require('telescope').setup({
        pickers = {
          jumplist = {
            initial_mode = "normal"
          },
          marks = {
            initial_mode = "normal"
          },
          buffers = {
            initial_mode = "normal",
            mappings = {
              i = {
                -- when browsing buffers, quickly delete the currently selected buffer
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                -- when browsing buffers, quickly delete the currently selected buffer
                ["<c-d>"] = actions.delete_buffer,
              }
            }
          }
        }
      })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[F]ind [F]iles"})
      vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = "[F]ind [F]iles"})
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "[F]ind [G]it files"})
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = "[S]earch [G]rep"})
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = "[S]earch Grep current [W]ord"})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "[F]ind [B]uffers"})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "[F]ind [H]elp tags"})
      vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = "[F]ind [J]umplist"})
      vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = "[F]ind [M]arks"})
    end,
  },
}

