local vim = vim

vim.api.nvim_create_user_command("LspListWorkspaceFolders", function()
    print(vim.lsp.buf.list_workspace_folders()[1])
end
, {}
)
