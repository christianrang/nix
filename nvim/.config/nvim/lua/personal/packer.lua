-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
-- vim.cmd.packadd('packer.nvim')

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
            config = function()
                require("telescope").load_extension("live_grep_args")
            end
        }
    }

    use('stevearc/aerial.nvim')

    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')
    use('towolf/vim-helm')

    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('numToStr/Comment.nvim')
    use('scrooloose/nerdtree')
    use('nvim-tree/nvim-web-devicons')
    use('lewis6991/gitsigns.nvim')
    use({ 'prettier/vim-prettier', run = 'yarn install --frozen-lockfile --production' })

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("folke/zen-mode.nvim")

    use('folke/tokyonight.nvim')
    use { "catppuccin/nvim", as = "catppuccin" }

    use({
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup {}
        end
    })

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons',
        opt = true },
    }

    use('RishabhRD/popfix')
    use('RishabhRD/nvim-cheat.sh')

    use("ellisonleao/glow.nvim")

    use('tpope/vim-surround')

    use('tyru/open-browser.vim')
    use('tyru/open-browser-github.vim')

    use('stevearc/oil.nvim')

    -- use("christoomey/vim-tmux-navigator")

    use ("sindrets/diffview.nvim")

    use ("tpope/vim-dadbod")
    use ("kristijanhusak/vim-dadbod-ui")

    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        config = function()
            vim.g.coq_settings = {
                auto_start = true
            }
        end
    }

    use {
        'ms-jpq/coq.artifacts',
        branch = 'artifacts',
        config = function()
            vim.g.coq_settings = {
                auto_start = true
            }
        end
    }

    use {
        'ms-jpq/coq.thirdparty',
        branch = '3p',
        config = function()
            vim.g.coq_settings = {
                auto_start = true
            }
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
