vim.api.nvim_create_autocmd("FileType", {
    pattern = "nix",
    callback = function()
        local client = vim.lsp.start({
            name = "nixd",
            cmd = { "nixd" },
            root_dir = vim.fs.root(0, '.git'),
        })

        if not client then
            vim.notify("couldn't start the nixd", 5, {})
            return
        end

        vim.notify("connected nixd", 5, {})
        vim.lsp.buf_attach_client(0, client)
    end
})
