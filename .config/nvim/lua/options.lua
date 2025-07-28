local vim=vim
vim.cmd("colorscheme retrobox")
vim.g.UltiSnipsExpandTrigger = '<C-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-l>'
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
vim.o.list = true
vim.o.listchars ="tab:>-,trail:␣"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.scrolloff = 10
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })
vim.opt.diffopt:append("linematch:60")


-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

