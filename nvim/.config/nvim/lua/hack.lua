-- I use this file for random stuff I'm playing with but I don't want to build a plugin for just yet.
local ns = vim.api.nvim_create_namespace("CustomDiagnostics")
local bufnr = 0
vim.keymap.set("n", "<leader>asdf", function()
    vim.diagnostic.set(ns, bufnr, { {
        message = "testing",
        col = 0,
        lnum = 1,
        severity = vim.diagnostic.severity.ERROR
    } }, {})
end)

vim.keymap.set("n", "<leader>qwer", function()
    vim.diagnostic.hide(ns, bufnr)
end)
