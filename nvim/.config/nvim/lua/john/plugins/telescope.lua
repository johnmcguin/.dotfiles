
return {
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')
      local themes = require('telescope.themes')
      local function with_ivy(cb, opts)
        -- tbl_extend provides an api to extend the ivy config
        -- e.g. to enter in normal mode instead of insert
        opts = opts or {}
        -- Then merge the user's options with the ivy theme options
        -- local final_opts = vim.tbl_deep_extend("force", ivy_opts, opts)
        local options = vim.tbl_deep_extend("force", {
          layout_config = {
            height = 0.9,
            width = 0.9,
            bottom_pane = {
              preview_cutoff = 120,
              prompt_position = "top"
            },
          },
        }, opts)

        return function() cb(themes.get_ivy(options)) end
      end
      require('telescope').setup({})
      vim.keymap.set('n', '<leader>ff', with_ivy(builtin.find_files), { desc = "[F]ind [F]iles"})
      vim.keymap.set('n', '<leader>p', with_ivy(builtin.find_files), { desc = "[F]ind [F]iles"})
      vim.keymap.set('n', '<leader>fg', with_ivy(builtin.git_files), { desc = "[F]ind [G]it files"})
      vim.keymap.set('n', '<leader>sg', with_ivy(builtin.live_grep), { desc = "[S]earch [G]rep"})
      vim.keymap.set('n', '<leader>sw', with_ivy(builtin.grep_string), { desc = "[S]earch Grep current [W]ord"})
      vim.keymap.set('n', '<leader>fb', with_ivy(builtin.buffers, {
        initial_mode = "normal",
        attach_mappings = function(prompt_bufnr, map)
          map('i', '<c-d>', actions.delete_buffer)
          map('n', '<c-d>', actions.delete_buffer)
          return true
        end,
      }), { desc = "[F]ind [B]uffers"})
      vim.keymap.set('n', '<leader>fh', with_ivy(builtin.help_tags), { desc = "[F]ind [H]elp tags"})
      vim.keymap.set('n', '<leader>fj', with_ivy(builtin.jumplist, {initial_mode = "normal" }), { desc = "[F]ind [J]umplist"})
      vim.keymap.set('n', '<leader>fm', with_ivy(builtin.marks, {initial_mode = "normal"}), { desc = "[F]ind [M]arks" })
    end,
  },
}

