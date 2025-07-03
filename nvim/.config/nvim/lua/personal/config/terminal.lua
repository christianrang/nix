vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.scrolloff = 0
    end,
})

local job_id = 0
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()

    job_id = vim.bo.channel
end)

local strsplit = function(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local decide_command = function()
    local pathTable = strsplit(vim.api.nvim_buf_get_name(0), "/")

    if pathTable[#pathTable] == "home.nix" then
        return "home-manager switch"
    end

    local filetype_to_command = {
        bash = vim.api.nvim_buf_get_name(0),
        go = 'go run ' .. vim.api.nvim_buf_get_name(0),
        python = 'python3 ' .. vim.api.nvim_buf_get_name(0),
        sh = vim.api.nvim_buf_get_name(0),
    }

    local command = filetype_to_command[vim.bo.filetype]
    if command == nil then
        return nil
    end

    return command
end

vim.keymap.set("n", "<leader>rv", function()
    local command = decide_command()
    if command == nil then
        return
    end
    vim.cmd.vnew()
    vim.cmd.term(command)
end, { desc = "[R]un [v]ertically" })

vim.keymap.set("n", "<leader>rc", function()
    local chan_info = vim.api.nvim_get_chan_info(job_id)

    local command = decide_command()
    if command == nil then
        return
    end

    if next(chan_info) == nil then
        vim.cmd.vnew()
        vim.cmd.term()

        job_id = vim.bo.channel
    end

    vim.fn.chansend(job_id, { command .. "\r\n" })

    -- vim.fn.chansend(job_id, { "go run cmd/*/main.go\r\n" })
end, { desc = "[R]un [c]code" })
