require('gitsigns').setup{
  on_attach = function(bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>hd', '<cmd>:Gitsigns diffthis<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>hb', '<cmd>:Gitsigns blame_line<CR>', {})
  end
}
