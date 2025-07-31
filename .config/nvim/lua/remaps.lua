local vim = vim
local functions = require("functions")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

vim.keymap.set("x", "<leader>p", [["_dP]])

-- copy/paste stuff to/from the system clipbaord
vim.keymap.set("n", "<leader>pp", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
vim.keymap.set("n", "Q", "<nop>")


vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- create new file under cursor if it doesn't exist
vim.keymap.set("n", "<leader>nf", ":e <cfile><cr>")

vim.keymap.set("n", "<leader>m", ":Man ")
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set('n', '<leader>sc', ':source ~/.config/nvim/init.lua<cr>')
-- vim.keymap.set("n", "<C-j>", ":move .+1<CR>")
vim.keymap.set("v", "<C-j>", ":move '>+1<CR>gv")
vim.keymap.set("v", "<C-k>", ":move '<-2<CR>gv")
vim.keymap.set('n', '<leader>ue', ':UltiSnipsEdit<cr>')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- buffer stuff
vim.keymap.set("n", "<C-n>", ":bn<cr>")
vim.keymap.set("n", "<C-p>", ":bp<cr>")

-- diagnostic keymaps: what is this for?
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- functions
vim.keymap.set("n", "<A-q>", function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end)
vim.keymap.set("n", "<leader>q", require("functions").scratch_to_quickfix)

vim.keymap.set("n", "<leader>ff",
    function() vim.ui.input({ prompt = "ff> " }, function(name) if name then vim.cmd("FileSearch! " .. name) end end) end)

vim.keymap.set("n", "<leader>sg",
    function() vim.ui.input({ prompt = "sg> " },
            function(pattern) if pattern then vim.cmd("TextSearch " .. pattern) end end) end)

vim.keymap.set("n", "<leader>fg",
    function() vim.ui.input({ prompt = "fg> " },
            function(pattern) if pattern then vim.cmd("TextSearch! " .. pattern) end end) end)
vim.keymap.set("n", "<leader>/", function()
    vim.ui.input({ prompt = "> " }, function(pattern)
        if not pattern or pattern == "" then return end
        functions.run_search("grep -n '" .. pattern .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
    end)
end)




-- use alt+[npd] to go to next/previous buffer or to delete the buffer
vim.keymap.set("x", "<leader>p", "\"+dP")
vim.keymap.set("n", "<leader><space>", ":ls<cr>:b ")
vim.keymap.set("n", "<leader>e", ":Explore<cr>")
vim.keymap.set("n", "-", ":Explore<cr>")
vim.keymap.set("n", "<leader>ln", ":set number!<cr>")

vim.keymap.set("n", "<leader>h", function()
    vim.bo.buftype = ""
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = true
end)
vim.keymap.set("n", "<leader>so",
    function()
        vim.cmd("enew")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.v.oldfiles)
        functions.scratch()
    end)
vim.keymap.set("n", "<leader>gb", function() functions.extcmd("git blame " .. vim.fn.expand("%"), false, false, true) end)
vim.keymap.set("n", "<leader>gs", function() functions.extcmd("git show " .. vim.fn.expand("<cword>")) end)
vim.keymap.set("n", "<leader>gc", function() functions.extcmd("git diff --name-only --diff-filter=U", true) end)
vim.keymap.set("n", "<leader>gp",
    function() vim.cmd("edit " ..
        vim.fn.system("python3 -c 'import site; print(site.getsitepackages()[0])'"):gsub("%s+$", "") .. "/.") end)
vim.keymap.set("n", "<leader>gr",
    function()
        local reg = os.getenv("CARGO_HOME") or (os.getenv("HOME") .. "/.cargo") .. "/registry/src"
        vim.cmd("edit " .. reg .. "/" .. vim.fn.systemlist("ls -1 " .. reg)[1])
    end)
vim.keymap.set("n", "<leader>ss",
    function() vim.ui.input({ prompt = "> " },
            function(p) if p then functions.extcmd("grep -in '" ..
                    p .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0))) end end) end)
vim.keymap.set("n", "<leader>sg",
    function()
        vim.ui.input({ prompt = "> " }, function(p)
            if p then
                local path, excludes, ex = functions.pre_search()
                for _, pat in ipairs(excludes) do table.insert(ex, string.format("--exclude-dir='%s'", pat)) end
                functions.extcmd(string.format("grep -IEnr %s '%s' %s", table.concat(ex, " "), p, path), true)
            end
        end)
    end)

vim.keymap.set("n", "<leader>sf",
    function()
        vim.ui.input({ prompt = "> " }, function(p)
            if p then
                local path, excludes, ex = functions.pre_search()
                for _, pat in ipairs(excludes) do table.insert(ex, string.format("-path '*%s*' -prune -o", pat)) end
                functions.extcmd(
                string.format("find %s %s -path '*%s*' -print", vim.fn.shellescape(path), table.concat(ex, " "), p), true,
                    true)
            end
        end)
    end)

vim.keymap.set("n", "<leader>l",
    function()
        local bn, ft = vim.fn.expand("%"), vim.bo.filetype
        if ft == "python" then
            functions.extcmd("isort -q " .. bn .. "&& black -q " .. bn)
            functions.extcmd("ruff check --output-format=concise --quiet " .. bn, true)
            vim.cmd("edit")
        elseif ft == "rust" then
            vim.fn.systemlist("cargo fmt")
            functions.extcmd("cargo check && cargo clippy")
        end
    end
)


local letters = "abcdefghijklmnopqrstuvwxyz"
for i = 1, #letters do
    local l = letters:sub(i, i)
    local u = l:upper()
    vim.keymap.set('n', '<leader>a' .. l, "m" .. u)
    vim.keymap.set('n', '<leader>j' .. l, "'" .. u)
end

vim.keymap.set("n", "<leader>c",
    function()
        vim.ui.input({ prompt = "> " },
            function(c)
                if c then functions.extcmd(c) end
            end)
    end
)

vim.keymap.set('n', '<leader>bl', function()
    local qf_list = {}
    for _, buf in ipairs(vim.fn.getbufinfo()) do
        if buf.listed == 1 then
            table.insert(qf_list, {
                filename = buf.name ~= '' and buf.name or '[No Name]',
                text = ':' .. buf.bufnr
            })
        end
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.cmd('copen')
end, {})
