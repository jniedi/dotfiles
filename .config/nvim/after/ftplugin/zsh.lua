local vim = vim

vim.cmd([[
setlocal makeprg=shellcheck\ --shell=zsh\ %
]])

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

