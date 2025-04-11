local M = {}

local function get_daily_path()
    local base_path = os.getenv("NOTES_DAILY_BASE_PATH") or os.getenv("HOME") .. "/vaults/vault/daily"
    local full_filepath = base_path .. os.date("/%Y/%m/%d/")

    return full_filepath
end

function M.daily_note()
    local filename = "daily_" .. os.date("%Y-%m-%d") .. ".md"
    local filepath = get_daily_path()
    print(filepath)

    local function is_buffer_exists(options)
        local buffer_name = options.buffer_name

        for buffer = 1, vim.fn.bufnr('$') do
            if buffer_name == vim.fn.bufname(buffer) then
                return true
            end
        end

        return false
    end

    if vim.fn.isdirectory(filepath) == 0 then
        os.execute("mkdir -p " .. filepath)
    end

    local function file_exists(name)
        local f=io.open(name,"r")
        if f~=nil then
            io.close(f)
            return true
        else
            return false
        end
    end

    if file_exists(filepath .. filename) == false then
        print("file does not exist: creating: " .. filepath .. filename)
        os.execute("tmpl-daily -o " .. filepath .. filename)
    end

    local exists = is_buffer_exists({buffer_name = filepath .. filename})

    if exists then
        vim.cmd("bw " .. filepath .. filename)
    else
        vim.cmd("e " .. filepath .. filename)
    end
end


function M.tomorrow_daily_note()
    local filename = "daily_" .. os.date("%Y-%m-%d",os.time()+24*60*60) .. ".md"
    local filepath = get_daily_path()
    print(filepath)

    local function is_buffer_exists(options)
        local buffer_name = options.buffer_name

        for buffer = 1, vim.fn.bufnr('$') do
            if buffer_name == vim.fn.bufname(buffer) then
                return true
            end
        end

        return false
    end

    if vim.fn.isdirectory(filepath) == 0 then
        os.execute("mkdir -p " .. filepath)
    end

    local function file_exists(name)
        local f=io.open(name,"r")
        if f~=nil then
            io.close(f)
            return true
        else
            return false
        end
    end

    if file_exists(filepath .. filename) == false then
        print("file does not exist: creating: " .. filepath .. filename)
        os.execute("tmpl-daily -o " .. filepath .. filename)
    end

    local exists = is_buffer_exists({buffer_name = filepath .. filename})

    if exists then
        vim.cmd("bw " .. filepath .. filename)
    else
        vim.cmd("e " .. filepath .. filename)
    end
end

return M
