--    https://github.com/nvim-treesitter/nvim-treesitter
local ts = require("nvim-treesitter.configs")
ts.setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "bash", "rust", "c", "vim", "vimdoc", "query", "lua", "java", "python" },
	highlight = {
		enable = true,
		-- disable = {  "md", "markdown" },
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
		disable = { "ocaml" },
	},
})
