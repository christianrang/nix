return {
    'Marskey/telescope-sg',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('telescope').setup {
            extensions = {
                ast_grep = {
                    command = {
                        "ast-grep",          -- For Linux, use `ast-grep` instead of `sg`
                        "--json=stream",
                    },                       -- must have --json=stream
                    grep_open_files = false, -- search in opened files
                    lang = nil,              -- string value, specify language for ast-grep `nil` for default
                }
            }
        }
    end
}
