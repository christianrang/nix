vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('ai-term-open', { clear = true }),
    callback = function()
        vim.opt.scrolloff = 0
    end,
})

vim.api.nvim_create_user_command('AI', function()
    vim.cmd.vnew()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_width(win, 100)

    vim.cmd.term("devbox shell; nix-shell -p claude-code --run claude")
    vim.api.nvim_buf_set_name(0, 'ai')
end, {})
