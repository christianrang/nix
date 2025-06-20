return {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function()
        require("oil").setup {
            columns = { "icon" },
            keymaps = {
              ["<C-h>"] = false,
              ["<C-l>"] = false,
              ["<C-k>"] = false,
              ["<C-j>"] = false,
            },
        }

        -- Open parent directory in current window
        vim.keymap.set("n", "-", require("oil").open)

        -- Open parent directory in side window
        vim.keymap.set("n", "<leader>-", function()
            vim.cmd.vnew()
            require("oil").open()
            vim.cmd.wincmd("H")
        end, 
        { desc = "Open parent directory" })
    end,
}
