-- improvements for later:
-- - reusing the terminal with rc doesn't reopen it
-- - add the ability to name terminals and use telescope to pick which one to reopen

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.scrolloff = 0
    end,
})

local find_terminal_buf = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == 'terminal' then
            return buf
        end
    end

    return nil
end

-- Focus a terminal, reusing an existing terminal buffer when there is one.
-- Returns its channel id.
local open_terminal = function()
    local buf = find_terminal_buf()

    if buf == nil then
        vim.cmd.vnew()
        vim.cmd.term()

        return vim.bo.channel
    end

    local win = vim.fn.bufwinid(buf)
    if win ~= -1 then
        vim.api.nvim_set_current_win(win)
    else
        vim.cmd.vsplit()
        vim.api.nvim_set_current_buf(buf)
    end

    return vim.bo[buf].channel
end

local job_id = 0
vim.keymap.set('n', '<leader>st', function()
    job_id = open_terminal()
end, { desc = '[s]plit [t]erminal' })

local strsplit = function(inputstr, sep)
    if sep == nil then
        sep = '%s'
    end
    local t = {}
    for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
        table.insert(t, str)
    end
    return t
end

local decide_command = function()
    local pathTable = strsplit(vim.api.nvim_buf_get_name(0), '/')

    if pathTable[#pathTable] == 'home.nix' then
        return 'home-manager switch'
    end

    local filetype_to_command = {
        sh = vim.api.nvim_buf_get_name(0),
        bash = vim.api.nvim_buf_get_name(0),
        go = 'go run ' .. vim.api.nvim_buf_get_name(0),
        python = 'python3 ' .. vim.api.nvim_buf_get_name(0),
    }

    local command = filetype_to_command[vim.bo.filetype]
    if command == nil then
        return nil
    end

    return command
end

vim.keymap.set('n', '<leader>rv', function()
    local command = decide_command()
    if command == nil then
        return
    end
    vim.cmd.vnew()
    vim.cmd.term(command)
end, { desc = '[R]un [v]ertically' })

vim.keymap.set('n', '<leader>rc', function()
    local command = decide_command()
    if command == nil then
        return
    end

    if next(vim.api.nvim_get_chan_info(job_id)) == nil then
        job_id = open_terminal()
    end

    vim.fn.chansend(job_id, { command .. '\r\n' })

    -- vim.fn.chansend(job_id, { "go run cmd/*/main.go\r\n" })
end, { desc = '[R]un [c]code' })

-- TODO: maybe move this to a better place?
vim.keymap.set('n', '<leader>gf', function()
    local command = 'git status --porcelain'
    if command == nil then
        return
    end
    vim.cmd.term(command)
end, { desc = '[g]it [f]iles' })
