-- really should
local vim = vim

vim.keymap.set("n", "<leader>wp",
    function()
        local filename = string.gsub(vim.fn.expand("%"),".md","")
        filename = string.gsub(filename,"_", " ")
        vim.ui.open("https://en.wikipedia.org/w/index.php?search="..filename)
    end, { silent = true })

vim.cmd([[
"obfuscate paragraph
nmap <leader>op vapg?
nmap <leader>tp :TypstPreview<CR>
set spell
]])
