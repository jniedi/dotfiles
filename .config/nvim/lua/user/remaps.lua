
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "-", vim.cmd.Ex)

local map = vim.keymap.set

-- map("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
-- map("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
--
-- map("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
-- map("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
-- previous buffer with ctr shift h

map("n", "<C-S-h>", ":bp<CR>", { noremap = true, silent = true })
map("n", "<C-S-l>", ":bn<CR>", { noremap = true, silent = true })

map("n", "<A-l>", ":bn<CR>", { noremap = true, silent = true })
map("n", "<A-h>", ":bp<CR>", { noremap = true, silent = true })


map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")



map("x", "<leader>p", "\"_dP")
map("n", "<leader>pc", "\"+p")

map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")


-- Open
map("n", "<leader>l", "<cmd>Lexplore<CR>")

map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")

-- map("n", "<C-f>", "<cmd>silent !tmux new-window tmux-sessionizer<CR>")

map("n", "<leader>lt", [[:ListcharsToggle<CR>]], { noremap = true, silent = true })
map("n", [[<leader>fo]], [[:Format<CR>]], { noremap = true, silent = true })


map("n", "<leader>x", "<cmd>!chmod +x %<CR>")


map("n", "<leader>m", "<cmd>!make<CR>", { noremap = true, silent = true })



-- executes the current file if it is executable
map("n", "<leader>e", function()
    local file = vim.fn.expand('%:p')
    local v = vim.api.nvim_exec2("!file " .. file, { output = true })
    if string.find(v.output, "executable", 0, true) then
        -- vim.notify(file, 3)
        local result = vim.fn.system(file)
        vim.notify(result, 1)
    end
end
, { noremap = true, silent = true })
-- Example keybinding to expand LuaSnip snippet


map("n", "<leader>fr", 'ye:%s/<C-R>"/')

map('n', '<leader>u', vim.cmd.UndotreeToggle)



