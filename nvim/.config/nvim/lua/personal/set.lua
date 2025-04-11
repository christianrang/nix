vim.opt.nu = true
vim.opt.conceallevel = 0

vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.mouse = nil

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 25

vim.opt.smartindent = true

vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.colorcolumn = "80,120"
vim.opt.cursorline = true

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.opt.updatetime = 50

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.cmd('colorscheme catppuccin')
