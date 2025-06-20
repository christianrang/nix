return {
    "morhetz/gruvbox",
    name = "gruvbox",
    enabled = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_contrast_dark = "hard"
        vim.cmd.colorscheme 'gruvbox'
    end,
}
