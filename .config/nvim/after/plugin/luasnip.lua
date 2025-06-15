local ls = require("luasnip")


-- Keymap for expanding or jumping forward
vim.keymap.set("i", "<C-l>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump() -- Expand or jump forward
    else
        vim.notify("Nothing found to expand", vim.log.levels.INFO)
    end
end, { silent = true })

-- -- Keymap for jumping forward (without expansion)
-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
--     if ls.jumpable(1) then
--         ls.jump(1)
--     else
--         vim.notify("Use <C-e> to expand", vim.log.levels.INFO)
--     end
-- end, { silent = true })

-- Keymap for jumping backward
vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- Keymap for changing choices (in choice nodes)
vim.keymap.set({ "i", "s" }, "<C-o>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })


require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
vim.notify("test", 3)
