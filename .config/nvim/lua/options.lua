local vim=vim
vim.cmd("colorscheme retrobox")
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
vim.o.autowrite = false

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

