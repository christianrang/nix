require('aerial').setup({
  backends = { "treesitter", "lsp", "markdown", "man" },
  on_attach = function()
    vim.api.nvim_set_keymap('n', '<space>ao', '<cmd>Telescope aerial<CR>', {})
  end
})
