vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('ai-term-open', { clear = true }),
    callback = function()
        vim.opt.scrolloff = 0
    end,
})

vim.api.nvim_create_user_command('AI', function()
    -- Check if the 'ai' buffer already exists
    local ai_buf = vim.fn.bufnr('ai')

    if ai_buf ~= -1 then
        -- Find if it's visible in any window
        local ai_win = vim.fn.bufwinid(ai_buf)
        if ai_win ~= -1 then
            vim.api.nvim_win_close(ai_win, false)
            return
        end
        -- Buffer exists but not visible, open it in a split
        vim.cmd('vsplit')
        vim.api.nvim_win_set_buf(0, ai_buf)
        vim.api.nvim_win_set_width(0, 100)
        return
    end

    -- Buffer doesn't exist, create it
    vim.cmd.vnew()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_width(win, 100)
    vim.cmd.term("nix-shell -p claude-code --run claude")
    vim.api.nvim_buf_set_name(0, 'ai')
end, {})
