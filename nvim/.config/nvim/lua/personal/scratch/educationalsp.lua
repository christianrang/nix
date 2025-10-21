vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        local home = os.getenv("HOME")
        local client = vim.lsp.start({
            name = "educationalsp",
            cmd = { home .. "/tmp/educationalsp/main" },
            root_dir = vim.fs.root(0, '.git'),
        })

        if not client then
            vim.notify("couldn't start the educationlsp", 5, {})
            return
        end

        vim.notify("connected educationalsp", 5, {})
        vim.lsp.buf_attach_client(0, client)
    end
})
