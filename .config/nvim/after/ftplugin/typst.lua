-- really should
local vim = vim

vim.keymap.set("n", "<leader>wp",
    function()
        local filename = string.gsub(vim.fn.expand("%"), ".md", "")
        filename = string.gsub(filename, "_", " ")
        vim.ui.open("https://en.wikipedia.org/w/index.php?search=" .. filename)
    end, { silent = true })


local function find_root(patterns)
  local path = vim.fn.expand('%:p:h')
  local root = vim.fs.find(patterns, { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ':h') or path
end

vim.cmd([[
"obfuscate paragraph
nmap <leader>op vapg?
nmap <leader>tp :TypstPreview<CR>
setlocal makeprg=typst\ compile\ --ignore-system-fonts\ %
set spell
set formatprg=typstyle
]])

local server = 'tinymist'
if vim.fn.executable(server) == 1 then
    vim.lsp.start({
        name = server,
        cmd = { server  },
        filetypes = { 'main.typ' },
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

