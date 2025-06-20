return {
  'mbbill/undotree',
  name = undotree,
  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
    vim.opt.undofile = true
  end,
}
