vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        local client = vim.lsp.start({
            cmd = { "rust-analyzer" },
            root_dir = vim.fs.root(0, '.git'),
        })

        if not client then
            vim.notify("couldn't start rust-analyzer", vim.log.levels.ERROR, {})
            return
        end

        vim.notify("connected rust-analyzer", 5, {})
        vim.lsp.buf_attach_client(0, client)
    end
})
