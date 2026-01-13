local vim = vim

vim.pack.add(
	{
"https://github.com/SirVer/ultisnips.git"
,"https://github.com/chomosuke/typst-preview.nvim.git"
,"https://github.com/echasnovski/mini.pick.git"
,"https://github.com/echasnovski/mini.extra.git"
,"https://github.com/navarasu/onedark.nvim"
,"https://github.com/lewis6991/gitsigns.nvim"
,"https://github.com/norcalli/nvim-colorizer.lua"
,"https://github.com/folke/todo-comments.nvim"
, "https://github.com/rebelot/kanagawa.nvim"
})



require('mini.pick').setup()
require('mini.extra').setup()
require('todo-comments').setup()
require("options")
require ('colorizer').setup()
require("remaps")
require("autocommands")
require("usercommands")
