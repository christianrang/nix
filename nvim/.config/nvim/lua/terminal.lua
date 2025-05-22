local job_id = 0
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()

    job_id = vim.bo.channel
end)

vim.keymap.set("n", "<leader>rc", function()
    vim.fn.chansend(job_id, { "go run cmd/*/main.go\r\n" })
end)
