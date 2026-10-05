local root = "/Users/christian.rang/progdev/github.com/sackbuoy/reviewer-nvim/main"

return {
    dir = root,
    name = "reviewer-nvim",
    config = function()
        package.cpath = root .. "/result/lib/?.so;" .. package.cpath
        require('reviewer-nvim').setup({
            enabled = true,
            picker = "telescope", -- or "fzf-lua" or "native"
        })
    end,
}
