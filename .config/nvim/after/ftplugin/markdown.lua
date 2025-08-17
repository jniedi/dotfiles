local vim = vim
local map = vim.keymap.set

map("n", "<leader>aa",
    function()
        vim.ui.input({ prompt = "alias> " },
            function(name)
                if name then
                    vim.system({ "ln", "-fs", vim.fn.expand("%"), name .. ".md" })
                end
            end)
    end, { silent = true })

map("n", "<leader>wp",
    function()
        local filename = string.gsub(vim.fn.expand("%"),".md","")
        filename = string.gsub(filename,"_", " ")
        vim.ui.open("https://en.wikipedia.org/w/index.php?search="..filename)
    end, { silent = true })

vim.g.vim_markdown_conceal = 1

vim.cmd([[
"obfuscate paragraph
nmap <leader>op vapg?
]])
