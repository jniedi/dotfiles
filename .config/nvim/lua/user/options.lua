local vim = vim
vim.opt.clipboard = ""
vim.opt.clipboard = ""
vim.opt.wildmenu = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in Nvim



vim.opt.ruler = false -- don't display the current position in file

-- vim.opt.guicursor = ""        -- leave cursor small in insert mode

-- editing
-- vim.opt.tildeop = true          -- "~" behaves like an operator
vim.opt.foldmethod = "manual"   -- folds defined manually

vim.opt.tabstop = 4           -- number of visual spaces per TAB
vim.opt.softtabstop = 4       -- number of spacesin tab when editing
vim.opt.shiftwidth = 4        -- insert 4 spaces on a tab
vim.opt.expandtab = true      -- tabs are spaces, mainly because of python
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true     -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
vim.o.showmode = false

-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = false  -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered
vim.opt.expandtab = true  -- enable tab characters
vim.opt.lazyredraw = true --  Do not redraw screen in the middle of a macro. Makes them complete faster.

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.conceallevel = 2 -- Hide * markup for bold and italic text

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.g.undolevels = 1000
-- vim.diagnostic.config({ signcolumn = true })
vim.cmd("set undofile")


vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.cmd("colorscheme habamax")

vim.g.markdown_fenced_languages = { 'zsh=bash' }
vim.api.nvim_set_hl(0, "@punctuation", { link = "Normal" })

