-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            'nvim-telescope/telescope.nvim',
            -- tag = '0.1.8',
            -- or                              , branch = '0.1.x',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },

        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
        },
        "tpope/vim-fugitive",
        { 'neovim/nvim-lspconfig' },
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lsp',
                'petertriho/cmp-git'
            },
        },
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*",
            build = "make install_jsregexp"
        },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "VonHeikemen/lsp-zero.nvim",
        "lukas-reineke/lsp-format.nvim",
        "tpope/vim-surround",

    },
    -- automatically check for plugin updates
    checker = { enabled = true },
    install = {
        missing = true,
    }

})
