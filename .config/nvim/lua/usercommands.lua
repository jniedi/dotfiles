local vim = vim
local mini_extra = require("mini.extra")

vim.api.nvim_create_user_command("LspListWorkspaceFolders", function()
	print(vim.lsp.buf.list_workspace_folders()[1])
end, {})

vim.api.nvim_create_user_command("GitBranches", function() MiniExtra.pickers.git_branches() end , {})
vim.api.nvim_create_user_command("Cli", function() MiniPick.builtin.cli({ command = { 'echo', 'a\nb\nc' } }) end , {})


vim.api.nvim_create_user_command("GitBranches", function()
	MiniExtra.pickers.git_branches()
end, {})
vim.api.nvim_create_user_command("Cli", function()
	MiniPick.builtin.cli({ command = { "echo", "a\nb\nc" } })
end, {})


vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
