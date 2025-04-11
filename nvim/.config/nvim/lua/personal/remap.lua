vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>cr", ":let @+ = expand(\"%\")<CR>")
vim.keymap.set("n", "<leader>sr", ":lua vim.notify(vim.fn.expand(\"%\"))<CR>")

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-j>", "jzz")
-- vim.keymap.set("n", "<C-k>", "kzz")
vim.keymap.set("n", "gd", "gdzz")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('n', '<leader>g', ':OpenGithubFile<CR>')

vim.keymap.set('n', '<leader>o', ':Oil<CR>')

vim.keymap.set("n", "<leader>j", ":cnext<CR>")
vim.keymap.set("n", "<leader>k", ":cprev<CR>")
vim.keymap.set("n", "<leader>co", ":cope<CR>")
vim.keymap.set("n", "<leader>nd", ":lua require('personal.hack.notes').daily_note()<CR>")

vim.keymap.set("n", "-", ":Oil<CR>")

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local npm_commands = function(opts)
  opts = opts or {}
  local results = {}

  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  if filetype == "python" then
    table.insert(results, "python %")
  elseif filetype == "go" then
    table.insert(results, "go run %")
    table.insert(results, "go run cmd/*/main.go")
  elseif filetype == "javascript" then
    table.insert(results, "npm run dev")
    table.insert(results, "npm run start")
  elseif filetype == "typescriptreact" then
    table.insert(results, "npm run dev")
    table.insert(results, "npm run start")
  end

  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
      results = results,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local command = "tmux splitw -hl 80 '" .. selection[1] .. "; tail -f /dev/null'"
        vim.cmd("silent !"..command)
      end)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>r", function () npm_commands() end, { silent = true })
