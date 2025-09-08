local vim = vim

vim.cmd([[
set spell
set makeprg=javac\ %
]])


local server = 'jdtls'
if vim.fn.executable(server) == 1 then
    vim.lsp.start({
        name = server,
        cmd = { server },
        filetypes = { 'java' },
        root_dir = vim.fs.root(0, { 'main.java', '.git' }),
        on_attach = function(client, bufnr)
            vim.lsp.completion.enable(true, client.id, bufnr, {
                autotrigger = true,
                convert = function(item)
                    return { abbr = item.label:gsub('%b()', '') }
                end,
            })
        end,
    })
else
    vim.notify("Server " .. server .. " not found!", vim.log.levels.WARN)
end

vim.api.nvim_create_autocmd('InsertCharPre', {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
        if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
            return
        else
            vim.lsp.completion.get()
        end
    end
})

