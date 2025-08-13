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

map("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- create new file under cursor if it doesn't exist
map("n", "<leader>nf", ":e <cfile><cr>")

map("n", "<leader>m", ":Man ")
map("n", "<esc>", "<cmd>nohlsearch<cr>")

map('n', '<leader>sc', ':source ~/.config/nvim/init.lua<cr>')
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

-- diagnostic keymaps: what is this for?
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- TODO
-- make quickfixlist  controlled by control modifier

-- functions
map("n", "<C-q>", function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end)
map("n", "<leader>q", require("functions").scratch_to_quickfix)

map("n", "<leader>ff",
    function() vim.ui.input({ prompt = "ff> " }, function(name) if name then vim.cmd("FileSearch! " .. name) end end) end)

map("n", "<leader>sg",
    function()
        vim.ui.input({ prompt = "sg> " },
            function(pattern) if pattern then vim.cmd("TextSearch " .. pattern) end end)
    end)

map("n", "<leader>fg",
    function()
        vim.ui.input({ prompt = "fg> " },
            function(pattern) if pattern then vim.cmd("TextSearch! " .. pattern) end end)
    end)
map("n", "<leader>/", function()
    vim.ui.input({ prompt = "> " }, function(pattern)
        if not pattern or pattern == "" then return end
        functions.run_search("grep -n '" .. pattern .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
    end)
end)




-- use alt+[npd] to go to next/previous buffer or to delete the buffer
map("n", "<leader><space>", ":ls<cr>:b ")
map("n", "<leader>e", ":Explore<cr>")
map("n", "-", ":Explore<cr>")
map("n", "<leader>ln", ":set number!<cr>")

map("n", "<leader>h", function()
    vim.bo.buftype = ""
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = true
end)
map("n", "<leader>so",
    function()
        vim.cmd("enew")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.v.oldfiles)
        functions.scratch()
    end)
map("n", "<leader>gb", function() functions.extcmd("git blame " .. vim.fn.expand("%"), false, false, true) end)
map("n", "<leader>gs", function() functions.extcmd("git show " .. vim.fn.expand("<cword>")) end)
map("n", "<leader>gc", function() functions.extcmd("git diff --name-only --diff-filter=U", true) end)
map("n", "<leader>gp",
    function()
        vim.cmd("edit " ..
            vim.fn.system("python3 -c 'import site; print(site.getsitepackages()[0])'"):gsub("%s+$", "") .. "/.")
    end)
map("n", "<leader>gr",
    function()
        local reg = os.getenv("CARGO_HOME") or (os.getenv("HOME") .. "/.cargo") .. "/registry/src"
        vim.cmd("edit " .. reg .. "/" .. vim.fn.systemlist("ls -1 " .. reg)[1])
    end)
map("n", "<leader>ss",
    function()
        vim.ui.input({ prompt = "> " },
            function(p)
                if p then
                    functions.extcmd("grep -in '" ..
                        p .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
                end
            end)
    end)
map("n", "<leader>sg",
    function()
        vim.ui.input({ prompt = "> " }, function(p)
            if p then
                local path, excludes, ex = functions.pre_search()
                for _, pat in ipairs(excludes) do table.insert(ex, string.format("--exclude-dir='%s'", pat)) end
                functions.extcmd(string.format("grep -IEnr %s '%s' %s", table.concat(ex, " "), p, path), true)
            end
        end)
    end)

map("n", "<leader>sf",
    function()
        vim.ui.input({ prompt = "> " }, function(p)
            if p then
                local path, excludes, ex = functions.pre_search()
                for _, pat in ipairs(excludes) do table.insert(ex, string.format("-path '*%s*' -prune -o", pat)) end
                functions.extcmd(
                    string.format("find %s %s -path '*%s*' -print", vim.fn.shellescape(path), table.concat(ex, " "), p),
                    true,
                    true)
            end
        end)
    end)

map("n", "<leader>l",
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
    map('n', '<leader>a' .. l, "m" .. u)
    map('n', '<leader>j' .. l, "'" .. u)
end

map("n", "<leader>c",
    function()
        vim.ui.input({ prompt = "> " },
            function(c)
                if c then functions.extcmd(c) end
            end)
    end
)

map('n', '<leader>bl', function()
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

-- -- lsp stuff without l prefix
-- Can be done natively with g..
-- vim.keymap.set("n" , "<leader>ca" , vim.lsp.buf.code_action )
-- vim.keymap.set("n","<leader>rn", vim.lsp.buf.rename )
-- vim.keymap.set("n","<leader>rf", vim.lsp.buf.references )
-- vim.keymap.set("n","<leader>im", vim.lsp.buf.implementation )
-- vim.keymap.set("n","<leader>td", vim.lsp.buf.type_definition )
-- vim.keymap.set("n","<leader>ds", vim.lsp.buf.document_symbol )
-- vim.keymap.set("n","<leader>fo", vim.lsp.buf.format )


 
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
