local vim = vim

vim.pack.add({"https://github.com/SirVer/ultisnips.git"})
vim.pack.add({"https://github.com/chomosuke/typst-preview.nvim.git"})
vim.pack.add({"https://github.com/echasnovski/mini.pick.git"})
vim.pack.add({"https://github.com/echasnovski/mini.extra.git"})
vim.pack.add({"https://github.com/navarasu/onedark.nvim"})
vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
vim.pack.add({"https://github.com/norcalli/nvim-colorizer.lua"})
vim.pack.add({"https://github.com/folke/todo-comments.nvim"})


require('mini.pick').setup()
require('mini.extra').setup()
require('todo-comments').setup()
require("options")
require ('colorizer').setup()
require("remaps")
require("autocommands")
require("usercommands")
