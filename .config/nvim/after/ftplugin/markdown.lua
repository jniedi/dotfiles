local vim = vim

vim.keymap.set("n", "<leader>aa", 
    function() vim.ui.input({ prompt = "alias> " },
    function(name) if name then vim.cmd("!ln -fs " .. name  .. "md" ) end end) end ,{silent = true })
