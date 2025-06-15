-- NOTE: very slow!!!!!
--
-- local buffer_autoformat = function(bufnr)
--     local group = 'lsp_autoformat'
--     vim.api.nvim_create_augroup(group, { clear = false })
--     vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
--
--     vim.api.nvim_create_autocmd('BufWritePre', {
--         buffer = bufnr,
--         group = group,
--         desc = 'LSP format on save',
--         callback = function()
--             -- note: do not enable async formatting
--             vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
--         end,
--     })
-- end

-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(event)
--         local id = vim.tbl_get(event, 'data', 'client_id')
--         local client = id and vim.lsp.get_client_by_id(id)
--         if client == nil then
--             return
--         end
--
--         -- make sure there is at least one client with formatting capabilities
--         if client.supports_method('textDocument/formatting') then
--             buffer_autoformat(event.buf)
--         end
--     end
-- })


-- Custom command to write without formatting
-- vim.api.nvim_create_user_command('Write', 'noautocmd write', {})


-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(event)
--         local id = vim.tbl_get(event, 'data', 'client_id')
--         local client = id and vim.lsp.get_client_by_id(id)
--         if client == nil then
--             return
--         end
--
--         -- make sure you use clients with formatting capabilities
--         -- otherwise you'll get a warning message
--         if client.supports_method('textDocument/formatting') then
--             require('lsp-format').on_attach(client)
--         end
--     end
-- })

-- keybindings
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set({ 'n', 'x' }, "<leader>fo", function()
            vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, opts)
    end
})
