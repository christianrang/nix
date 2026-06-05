vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Copy motion to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"+d", { desc = "Cut to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy line to clipboard" })

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>j", ":cnext<CR>", { desc = "Next in Quickfix" })
vim.keymap.set("n", "<leader>k", ":cprev<CR>", { desc = "Previous in Quickfix" })

vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>",
    { desc = "Change working directory to the directory of open file" })

vim.keymap.set("n", "<leader>z", ":tab split<CR>", { desc = "Fullscreen current window" })

vim.keymap.set('n', '<leader>cp', function()
    local path = vim.fn.expand('%')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy relative path to clipboard' })

-- Optional: Copy absolute path
vim.keymap.set('n', '<leader>cP', function()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy absolute path to clipboard' })

-- Optional: Copy just the filename
vim.keymap.set('n', '<leader>cf', function()
    local path = vim.fn.expand('%:t')
    vim.fn.setreg('+', path)
    vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy filename to clipboard' })
