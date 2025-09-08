local vim = vim

-- TODO: add to function file
local function find_root(patterns)
  local path = vim.fn.expand('%:p:h')
  local root = vim.fs.find(patterns, { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ':h') or path
end

vim.cmd([[
"obfuscate paragraph
nmap <leader>op vapg?
set spell
set formatprg=typstyle
]])

local server = 'typescript-language-server'
if vim.fn.executable(server) == 1 then
    vim.lsp.start({
        name = server,
        cmd = { server , '--stdio'  },
        filetypes = { 'main.ts' },
        root_dir = find_root({ "" }),
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
print('hello')
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

