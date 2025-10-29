local vim=vim
local diagnostic = vim.diagnostic

-- Lua
require('onedark').setup {
    style = 'darker'
}
require('onedark').load()

vim.g.UltiSnipsExpandTrigger = '<C-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-l>'
vim.o.joinspaces = true
vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'
vim.g.UltiSnipsSnippetDirectories = { 'snips' }
vim.opt.termguicolors = true
vim.g.netrw_banner = ""
vim.o.ignorecase = true
vim.o.smartcase = true
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.o.number = true
vim.o.relativenumber = true
vim.g.wildcharm='<C-Z>'
vim.o.list = false
vim.o.listchars ="tab:>-,trail:␣"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 10
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.updatetime = 250
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0
vim.o.autoread = true
vim.o.autowrite = false -- todo: checkout what this does
vim.o.cul = true

vim.opt.winborder="rounded"

vim.cmd(":hi statusline guibg=NONE")


-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })
vim.opt.diffopt:append("linematch:60")


-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- https://wiki.archlinux.org/title/Language_Server_Protocol
vim.cmd [[set completeopt+=menuone,noselect,popup]]


-- Diagnostics
-- TODO: toggle redline with <C-d>
vim.diagnostic.config({
    signs = true,
    virtual_text = true,
    update_in_insert = true,
    underline = true,
})

local highlight_groups = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticVirtualTextError",
  [vim.diagnostic.severity.WARN] = "DiagnosticVirtualTextWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticVirtualTextInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticVirtualTextHint",
}

local highlight_group = highlight_groups[diagnostic.severity]
