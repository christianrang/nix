local M = {}

local defaults = {}

--- @class notes.Options
--- @field base_path string: The base path used when creating the daily notes directory

--- @type notes.Options
local options = {
  base_path = os.getenv 'HOME' .. '/vaults/vault/daily',
}

--- @param opts notes.Options
M.setup = function(opts)
  options = vim.tbl_deep_extend('force', defaults, opts or {})
end

--- @param timedelta integer?:
local function get_daily_path(timedelta)
  local full_filepath = options.base_path .. os.date('/%Y/%m/%d/', timedelta)

  return full_filepath
end

M.daily_note = function()
  local filename = 'daily_' .. os.date '%Y-%m-%d' .. '.md'
  local filepath = get_daily_path()

  local function is_buffer_exists(options)
    local buffer_name = options.buffer_name

    for buffer = 1, vim.fn.bufnr '$' do
      if buffer_name == vim.fn.bufname(buffer) then
        return true
      end
    end

    return false
  end

  if vim.fn.isdirectory(filepath) == 0 then
    os.execute('mkdir -p ' .. filepath)
  end

  local function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
      io.close(f)
      return true
    else
      return false
    end
  end

  if file_exists(filepath .. filename) == false then
    print('file does not exist: creating: ' .. filepath .. filename)
    os.execute('touch ' .. filepath .. filename)
    -- os.execute("tmpl-daily -o " .. filepath .. filename)
  end

  local exists = is_buffer_exists { buffer_name = filepath .. filename }

  if exists then
    vim.cmd('bw ' .. filepath .. filename)
  else
    vim.cmd('e ' .. filepath .. filename)
  end
end

M.tomorrow_daily_note = function()
  local tomorrows_date_delta = os.time() + 24 * 60 * 60
  local filename = 'daily_' .. os.date("%Y-%m-%d", tomorrows_date_delta)  .. '.md'
  local filepath = get_daily_path(tomorrows_date_delta)

  local function is_buffer_exists(options)
    local buffer_name = options.buffer_name

    for buffer = 1, vim.fn.bufnr '$' do
      if buffer_name == vim.fn.bufname(buffer) then
        return true
      end
    end

    return false
  end

  if vim.fn.isdirectory(filepath) == 0 then
    os.execute('mkdir -p ' .. filepath)
  end

  local function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
      io.close(f)
      return true
    else
      return false
    end
  end

  if file_exists(filepath .. filename) == false then
    print('file does not exist: creating: ' .. filepath .. filename)
    os.execute('touch ' .. filepath .. filename)
    -- os.execute("tmpl-daily -o " .. filepath .. filename)
  end

  local exists = is_buffer_exists { buffer_name = filepath .. filename }

  if exists then
    vim.cmd('bw ' .. filepath .. filename)
  else
    vim.cmd('e ' .. filepath .. filename)
  end
end

return M
