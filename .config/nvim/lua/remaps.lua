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

map("n", "<leader>m", ":Man ")
map("n", "<esc>", "<cmd>nohlsearch<cr>")

-- map("n", "<C-j>", ":move .+1<CR>")
map("v", "<C-j>", ":move '>+1<CR>gv")
map("v", "<C-k>", ":move '<-2<CR>gv")
map('n', '<leader>ue', ':UltiSnipsEdit<cr>')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- buffer stuff
map("n", "<M-n>", ":bn<cr>")
map("n", "<M-p>", ":bp<cr>")
map("n", "<M-l>", ":ls<cr>:b ")

map("n", "<leader>c", "1z=")

-- TODO
-- make quickfixlist  controlled by control modifier

-- toggle quickfix list visibility
map("n", "<C-q>", function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end)

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
map("n", "<leader>g", function() MiniExtra.pickers.git_hunks() end, {})
map("n", "<leader>w", function() MiniExtra.pickers.history() end, {})

map("n", "<leader><space>", ":Pick buffers<CR>")

map("n", "<M-f>", ":Pick files<CR>")
map("n", "<M-b>", ":Pick buffers<CR>")
map("n", "<M-h>", ":Pick help<CR>")



-- use alt+[npd] to go to next/previous buffer or to delete the buffer
map("n", "<leader>e", ":Explore<cr>")
-- toggles full height explore
map("n", "<C-e>", ":Lexplore<cr>")
map("n", "-", ":Explore<cr>")
map("n", "<leader>ln", ":set number!<cr>")

-- map("n", "<leader>so",
--     function()
--         vim.cmd("enew")
--         vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.v.oldfiles)
--         functions.scratch()
--     end)

-- map("n", "<leader>gb", function() functions.extcmd("git blame " .. vim.fn.expand("%"), false, false, true) end)
-- map("n", "<leader>gs", function() functions.extcmd("git show " .. vim.fn.expand("<cword>")) end)
-- map("n", "<leader>gc", function() functions.extcmd("git diff --name-only --diff-filter=U", true) end)
-- map("n", "<leader>gp",
--     function()
--         vim.cmd("edit " ..
--             vim.fn.system("python3 -c 'import site; print(site.getsitepackages()[0])'"):gsub("%s+$", "") .. "/.")
--     end)

-- add indicator to statusline?
vim.keymap.set({'n','i'}, "<C-d>", function()
    local togglerino = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = togglerino })
end, { desc = 'Toggle diagnostic virtual_lines' })


-- TODO: this
-- -- change next occurence of $
-- -- TODO: fix to be able to handle span more than one line
-- map('n', 'ci$', function()
--     -- bufnum, lnum, col, off
--     local pos = vim.fn.getpos('.')
--     print(pos[2])
--     local line = vim.api.nvim_buf_get_lines(0,pos[2]-1,pos[2],false)
--     local pos = 0
--     for i,c in ipairs(line) do
--         if c == '$' then
--             pos = i
--         end
--     end
--     print(line)
--
--     -- if pos == 0 and line[0] ~= '$' then
--     --     vim.notify('No $ found',vim.log.levels.WARN)
--     -- else
--     --     vim.notify('$ found',vim.log.levels.WARN)
--     -- end
--
-- end)
