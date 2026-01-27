local vim = vim



vim.pack.add({
	"https://github.com/SirVer/ultisnips.git",
	"https://github.com/chomosuke/typst-preview.nvim.git",
	"https://github.com/echasnovski/mini.pick.git",
	"https://github.com/echasnovski/mini.extra.git",
	"https://github.com/navarasu/onedark.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/norcalli/nvim-colorizer.lua",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/tpope/vim-surround",
	"https://github.com/tpope/vim-repeat", -- further checkout https://github.com/tpope/vim-repeat
	"https://github.com/folke/persistence.nvim",
	"https://github.com/stevearc/conform.nvim", -- formatting
	"https://github.com/tpope/vim-fugitive", -- git standard stuff
    "https://github.com/nvim-zh/colorful-winsep.nvim"
})

require("mini.pick").setup()
require("persistence").setup()
require("colorful-winsep").setup({
    animate = { enabled = false },
    indicator_for_2wins = {
        -- only work when the total of windows is two
        position = "center", -- false to disable or choose between "center", "start", "end" and "both"
        symbols = {
            -- the meaning of left, down ,up, right is the position of separator
            start_left = ">",
            end_left = ">",
            start_down = "|",
            end_down = "|",
            start_up = "|",
            end_up = "|",
            start_right = "<",
            end_right = "<",
        },
    },
})
require("mini.extra").setup()
require("todo-comments").setup()
require("options")
require('colorizer').setup()
-- require ('conform_setup')
require('colorizer').setup()
require("colorizer").setup()

-- require("formatting")
require("remaps")
require("autocommands")
require("usercommands")
