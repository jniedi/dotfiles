local vim = vim
local mini_extra=require('mini.extra')


vim.api.nvim_create_user_command("LspListWorkspaceFolders", function()
    print(vim.lsp.buf.list_workspace_folders()[1])
end
, {}
)

vim.api.nvim_create_user_command("GitBranches", function() MiniExtra.pickers.git_branches() end , {})
vim.api.nvim_create_user_command("Cli", function() MiniPick.builtin.cli({ command = { 'echo', 'a\nb\nc' } }) end , {})


