vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    -- disable line numbers and relative line numbers in terminal buffers
    vim.wo.nu = false;
    vim.wo.relativenumber = false;
  end
})
