local vim = vim


local function find_root(patterns)
  local path = vim.fn.expand('%:p:h')
  local root = vim.fs.find(patterns, { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ':h') or path
end

-- c/cpp
local server = 'clangd'
if vim.fn.executable(server) == 1 then
    vim.lsp.start({
        name = server,
        cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
        filetypes = { 'cpp', 'c', 'hpp' },
        root_dir = find_root({ ".clangd", "compile_commands.json" }),
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

