local vim = vim
local funcs = require("functions")


local server = "lua-language-server"
if vim.fn.executable(server) == 1 then
    vim.lsp.start({
        name = server,
        cmd = { server },
        filetypes = { "lua" },
        -- Sets the "root directory" to the parent directory of the file in the
        -- current buffer that contains either a ".luarc.json" or a
        -- ".luarc.jsonc" file. Files that share a root directory will reuse
        -- the connection to the same LSP server.
        -- Nested lists indicate equal priority, see |vim.lsp.Config|.
        root_markers = { { "init.lua", ".luarc.json", ".luarc.jsonc" }, ".git" },
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                    global = { "vim" },
                },
            },
        },
        on_attach = function(client, bufnr)
            vim.lsp.completion.enable(true, client.id, bufnr, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub("%b()", "") }
                end,
            })
        end,
    })
else
    vim.notify("Server " .. server .. " not found!", vim.log.levels.WARN)
end
vim.api.nvim_create_autocmd("InsertCharPre", {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
        if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
            return
        else
            vim.lsp.completion.get()
        end
    end,
})
