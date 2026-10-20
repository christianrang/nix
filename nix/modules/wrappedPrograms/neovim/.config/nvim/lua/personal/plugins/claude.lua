return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = function(_, opts)
        require("claudecode").setup(opts)

        -- The native terminal provider hardcodes `startinsert` on open/focus
        -- (no option to disable it). Drop back to normal mode after the plugin
        -- focuses the window. `vim.schedule` lands after the plugin's startinsert.
        local group = vim.api.nvim_create_augroup("claudecode-no-autoinsert", { clear = true })

        -- When a diff opens (esp. with `open_in_new_tab`), the plugin also spawns
        -- a Claude terminal split whose BufEnter autocmd hardcodes `startinsert`,
        -- so focus can land in the terminal in insert mode instead of the diff.
        -- The proposed-diff buffer is tagged with `claudecode_diff_tab_name`; when
        -- one appears, focus it and drop to normal mode. `vim.schedule` lands after
        -- the plugin's own focus/insert handling.
        vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
            group = group,
            callback = function(args)
                if not vim.b[args.buf].claudecode_diff_tab_name then
                    return
                end
                vim.schedule(function()
                    local win = vim.fn.bufwinid(args.buf)
                    if win ~= -1 then
                        vim.api.nvim_set_current_win(win)
                    end
                    vim.cmd("stopinsert")
                end)
            end,
        })
    end,
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
        "ClaudeCode",
        "ClaudeCodeFocus",
        "ClaudeCodeSelectModel",
        "ClaudeCodeAdd",
        "ClaudeCodeSend",
        "ClaudeCodeTreeAdd",
        "ClaudeCodeStatus",
        "ClaudeCodeStart",
        "ClaudeCodeStop",
        "ClaudeCodeOpen",
        "ClaudeCodeClose",
        "ClaudeCodeDiffAccept",
        "ClaudeCodeDiffDeny",
        "ClaudeCodeCloseAllDiffs",
    },
    opts = {
        terminal = {
            provider = "native",
        },
        diff_opts = {
            open_in_new_tab = true,
        },
    },
    keys = {
        { "<leader>a",  nil,                              desc = "AI/Claude Code" },
        { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<cr>",
            desc = "Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw", "snacks_picker_list" },
        },
        -- Diff management
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
    },
}
