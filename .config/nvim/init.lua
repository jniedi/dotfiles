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
})

require("mini.pick").setup()
require("persistence").setup()
require("mini.extra").setup()
require("todo-comments").setup()
require("options")
require ('colorizer').setup()
-- require ('conform_setup')
require ('colorizer').setup()
require("colorizer").setup()

require("formatting")
require("remaps")
require("autocommands")
require("usercommands")
