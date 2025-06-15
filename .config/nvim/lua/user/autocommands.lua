-- This ensures that read-only files are marked as non-modifiable inside Neovim, preventing any changes or accidental writes.

vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*",
    callback = function()
        if vim.bo.readonly then
            vim.bo.modifiable = false
        end
    end,
})
