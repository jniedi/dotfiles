local vim = vim

vim.keymap.set("n", "<leader>aa",
    function()
        vim.ui.input({ prompt = "alias> " },
            function(name)
                if name then
                    vim.system({ "ln", "-fs", vim.fn.expand("%") , name .. ".md" })
                end
            end)
    end, { silent = true })
