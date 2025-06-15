local builtin = require('telescope.builtin')
local map = vim.keymap.set

map("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true })
-- map("n", "<C-f>", builtin.find_files, { noremap = true, silent = true })
map("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true })
-- map("n", "<C-g>", builtin.live_grep, { noremap = true, silent = true })
map("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true })
map("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true })

-- map("n", "<C-o>", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "Telescope buffers" })
-- map("n", "<C-f>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true, desc = "Telescope find files" })

map('n', '<leader>pf', builtin.find_files, { desc = 'File search' })
map('n', '<leadoptser>pg', builtin.find_files, { desc = 'Git file search' })

-- used with luasnip
-- map('n', '<C-p>', builtin.git_files, { desc = 'Git file search' })

map('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("grep> ") });
end
, { desc = 'File search' })
