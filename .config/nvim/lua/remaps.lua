MiniExtra = MiniExtra
local vim = vim
local functions = require("functions")
local map = vim.keymap.set

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")


map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "=ap", "ma=ap'a")

map({ "x", "n" }, "<leader>p", "\"+p")
map({ "x", "n" }, "<leader>P", "\"+P")

map({ "x", "n" }, "<leader>y", "\"+y")
map({ "x", "v" }, "<leader>Y", "\"+Y")

map({ "n", "v" }, "<leader>d", "\"_d")
map("n", "Q", "<nop>")

map("n", "<C-p>", "<cmd>cprev<CR>zz")
map("n", "<C-n>", "<cmd>cnext<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- create new file under cursor if it doesn't exist
map("n", "<leader>nf", ":e <cfile><cr>")

map("n", "<leader>m", ":make<CR>")
map("n", "<esc>", "<cmd>nohlsearch<cr>")

-- map("n", "<C-j>", ":move .+1<CR>")
map("v", "<C-j>", ":move '>+1<CR>gv")
map("v", "<C-k>", ":move '<-2<CR>gv")
map('n', '<leader>ue', ':UltiSnipsEdit<cr>')
map('n', '<C-u>', '<C-u>zz')

map("n", "<M-N>", ":tabnext<cr>")
map("n", "<M-P>", ":tabprev<cr>")
map("n", "<M-l>", ":ls<cr>:b ")
map("n", "<M-n>", ":bn<cr>")
map("n", "<M-p>", ":bp<cr>")
map("n", "<M-l>", ":ls<cr>:b ")

map("n", "<leader>cm", ":ConfigEdit maps<cr>")
map("n", "<leader>ce", ":ConfigEdit<cr>")
map("n", "<leader>co", ":ConfigEdit options<cr>")
map("n", "<leader>cl", ":ConfigEdit lua<cr>")
map("n", "<leader>cf", ":ConfigEdit functions<cr>")

-- TODO
-- make quickfixlist  controlled by control modifier

-- toggle quickfix list visibility
map("n", "<C-q>", function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end)


map("n", "<leader>ln", "<cmd>set invrelativenumber<cr>", { silent = true } )


-- map("c","ec","e ~/.config/nvim/lua/*.lua<C-Z>")


-- maybe find sth useful for these
map({ "v", "i", "n" }, "<PageUp>" , "<cmd>echo 'Upps!'<cr>", {})
map({ "v", "i", "n" }, "<PageDown>" , "<cmd>echo 'Upps!'<cr>", {})
map({ "v", "i", "n" }, "<Home>" , "<cmd>echo 'Upps!'<cr>", {})
map({ "v", "i", "n" }, "<End>" , "<cmd>echo 'Upps!'<cr>", {})


-- Window stuff
-- quickly jump to other window
map("n","<C-w><C-e>", "<C-w><C-w>", {})
map("n","<Up>" ,"<C-w>+",{})
map("n","<Down>" ,"<C-w>-",{})
map("n","<Left>" ,"<C-w><",{})
map("n","<Right>" ,"<C-w>>",{})


-- Pick stuff
map("n", "<leader>f", ":Pick files<CR>")
map("n", "<leader>s", ":Pick files<CR>")
map("n", "<leader>b", ":Pick buffers<CR>")
map("n", "<leader>h", ":Pick help<CR>")

-- remove mini.extra if I don't actually need it
map("n", "<leader>d", function() MiniExtra.pickers.diagnostic() end, {})
map("n", "<leader>w", function() MiniExtra.pickers.history() end, {})


local gitsigns = require("gitsigns")
-- Git stuff
map("n", "<leader>gb", gitsigns.blame, {})

map("n", "<leader><space>", ":Pick buffers<CR>")

map("n", "<M-f>", ":Pick files<CR>")
map("n", "<M-b>", ":Pick buffers<CR>")
map("n", "<M-h>", ":Pick help<CR>")
map("n", "<leader>e", ":Explore<cr>")
map("n", "<C-e>", ":Lexplore<cr>")
