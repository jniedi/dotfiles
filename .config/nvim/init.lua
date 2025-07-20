-- ----------------------------------------------
-- ----------------------------------------------
-- plugins

local pluginpath = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"
if not vim.loop.fs_stat(pluginpath) then
  vim.fn.system({ "mkdir", "-p", pluginpath})
end

-- TODO: add functionality to check for updates
if not vim.loop.fs_stat(pluginpath .. "ultisnips.git") then
  vim.fn.system({ "git", "clone", "https://github.com/SirVer/ultisnips.git", pluginpath .. "ultisnips.git", })
  vim.opt.rtp:append(pluginpath .. "ultisnips.git")
end

vim.g.UltiSnipsExpandTrigger = '<C-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-l>'
vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'



-- ----------------------------------------------
-- ----------------------------------------------
-- variables
local vim = vim

-- ----------------------------------------------
-- ----------------------------------------------
-- options

-- TODO: add conceal stuff
-- TODO: add comments
vim.g.UltiSnipsSnippetDirectories = { 'snips' }
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.g.netrw_banner = ""
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- use (relative) line numbers
vim.o.number = true
vim.o.relativenumber = true

-- enable list characters
vim.o.list = true
vim.o.listchars ="tab:\\t,trail:␣"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- start scrolling down earlier
vim.o.scrolloff = 10

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'


-- ----------------------------------------------
-- ----------------------------------------------
-- keymaps

-- use escaple to remove highlight of search
vim.keymap.set("n","<esc>","<cmd>nohlsearch<cr>")

-- source the init.lua file
vim.keymap.set('n', '<leader>sc', ':source ~/.config/nvim/init.lua<cr>')

-- move line cursor is on around
vim.keymap.set("n", "<C-j>", ":move .+1<CR>")
vim.keymap.set("v", "<C-j>", ":move '>+1<CR>gv")

-- move visual selection around
vim.keymap.set("n", "<C-k>", ":move .-2<CR>")
vim.keymap.set("v", "<C-k>", ":move '<-2<CR>gv")

-- quickly edit the snippets file(s) for the filetype of the buffer
vim.keymap.set('n', '<leader>ue', ':UltiSnipsEdit<cr>')

-- move pages down and up
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- quickfix list stuff
vim.keymap.set("n", "<C-n>", ":cn<cr>")
vim.keymap.set("n", "<C-p>", ":cp<cr>")

-- buffer stuff
vim.keymap.set("n", "<A-n>", ":bn<cr>")
vim.keymap.set("n", "<A-p>", ":bp<cr>")
vim.keymap.set("n", "<A-d>", ":bd<cr>")
vim.keymap.set("n", "<A-l>", ":ls<cr>:b ")

-- toggle quickfix list
vim.keymap.set("n", "<C-q>", function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end)

-- diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- use fd to quickly edit files according to the pattern
vim.keymap.set("n", "<leader>qf", function() vim.ui.input({ prompt = "> " }, function(name) if name then vim.cmd("QuickFdEdit " .. name) end end) end)



-- ----------------------------------------------
-- ----------------------------------------------
-- autocommands
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end, group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }), pattern = "*", })

vim.api.nvim_create_autocmd("FileType",  { callback = 
  function() 
  local i = 4
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 100, false)) do local cind = line:match("^(%s+)") if cind and not line:match("^%s*$") then i = math.min(i, #cind) end end
    vim.opt_local.expandtab=true vim.opt_local.shiftwidth=i vim.opt_local.tabstop=i vim.opt_local.softtabstop = i end , })


-- ----------------------------------------------
-- ----------------------------------------------
-- LSP

-- https://wiki.archlinux.org/title/Language_Server_Protocol

vim.cmd [[set completeopt+=menuone,noselect,popup]]
local function find_root(patterns)
  local path = vim.fn.expand('%:p:h')
  local root = vim.fs.find(patterns, { path = path, upward = true })[1]
  return root and vim.fn.fnamemodify(root, ':h') or path
end

-- python
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
  local server = 'pylsp'
  if vim.fn.executable(server) == 1 then
  vim.lsp.start({
    name = server,
    cmd = {server},
    filetypes = {'python'},
    root_dir = find_root({'pyproject.toml', 'setup.py', 'setup.cfg', 'main.py', 'requirements.txt', '.git'}),
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
              enabled = false
          },
          flake8 = {
              enabled = true,
          },
          black = {
              enabled = true
          }
        }
      }
    },
    on_attach = function(client, bufnr)
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end,
  })
else
  vim.notify("Server " .. server .. " not found!", vim.log.levels.WARN)
  end
end,
  desc = 'Start Python LSP'
})


-- c/cpp
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'cpp', 'hpp','c'},
  callback = function()
  local server = 'clangd'
  if vim.fn.executable(server) == 1 then
  vim.lsp.start({
    name = server,
    cmd = {server},
    filetypes = {'cpp', 'c', 'hpp' },
    root_dir = find_root({".clangd" }),
    on_attach = function(client, bufnr)
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end,
  })
else
  vim.notify("Server " .. server .. " not found!", vim.log.levels.WARN)
  end
end,
  desc = 'Start cpp LSP'
})

-- lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
  local server = 'lua-language-server'
  if vim.fn.executable(server) == 1 then
  vim.lsp.start({
    name = server,
    cmd = {server},
    filetypes = {'lua'},
    -- Sets the "root directory" to the parent directory of the file in the
    -- current buffer that contains either a ".luarc.json" or a
    -- ".luarc.jsonc" file. Files that share a root directory will reuse
    -- the connection to the same LSP server.
    -- Nested lists indicate equal priority, see |vim.lsp.Config|.
     root_markers = { {"init.lua", '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        }
      }
    },
    on_attach = function(client, bufnr)
      vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub('%b()', '') }
        end,
      })
    end,
  })
else
  vim.notify("Server " .. server .. " not found!", vim.log.levels.WARN)
  end
end,
  desc = 'Start lua LSP'
})


local triggers = {'.'}
vim.api.nvim_create_autocmd('InsertCharPre', {
  buffer = vim.api.nvim_get_current_buf(),
  callback = function()
    if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
      return
    end
    local char = vim.v.char
    if vim.list_contains(triggers, char) then
      -- local key = vim.keycode('<C-x><C-n>')
      -- vim.api.nvim_feedkeys(key, 'm', false)
       vim.lsp.completion.get()
    end
  end
})

vim.keymap.set("n" , "<leader>lca" , function() vim.lsp.buf.code_action() end)
vim.keymap.set("n","<leader>lrn", function() vim.lsp.buf.rename() end)
vim.keymap.set("n","<leader>lrf", function() vim.lsp.buf.references() end)
vim.keymap.set("n","<leader>lim", function() vim.lsp.buf.implementation() end)
vim.keymap.set("n","<leader>ltd", function() vim.lsp.buf.type_definition() end)
vim.keymap.set("n","<leader>lds", function() vim.lsp.buf.document_symbol() end)

vim.diagnostic.config({
  signs = true,
  virtual_text = true, -- optional: show inline text (disable if you prefer signs only)
  update_in_insert = false,
  underline = true,
})


-- ----------------------------------------------
-- ----------------------------------------------
-- stuff to sort

_G.basic_excludes = { ".git", "*.egg-info", "__pycache__", "wandb","target" } _G.ext_excludes = vim.list_extend(vim.deepcopy(_G.basic_excludes), { ".venv", })

local function scratch() vim.bo.buftype = "nofile" vim.bo.bufhidden = "wipe" vim.bo.swapfile = false end
local function pre_search() if vim.bo.filetype == "netrw" then return vim.b.netrw_curdir, _G.basic_excludes, {} else return vim.fn.getcwd(), _G.ext_excludes, {} end end
local function scratch_to_quickfix(close_qf) local items, bufnr = {}, vim.api.nvim_get_current_buf() 
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do if line ~= "" then local f, lnum, text = line:match("^([^:]+):(%d+):(.*)$")
    if f and lnum then table.insert(items, { filename = vim.fn.fnamemodify(f, ":p"), lnum = tonumber(lnum), text = text, }) -- for grep filename:line:text
    else local lnum, text = line:match("^(%d+):(.*)$")
      if lnum and text then table.insert(items, { filename = vim.fn.bufname(vim.fn.bufnr("#")), lnum = tonumber(lnum), text = text, }) -- for current buffer grep
      else table.insert(items, { filename = vim.fn.fnamemodify(line, ":p") }) -- for find results, only fnames
  end end end end vim.api.nvim_buf_delete(bufnr, { force = true }) vim.fn.setqflist(items, "r") vim.cmd("copen | cc") if close_qf then vim.cmd("cclose") end end
local function extcmd(cmd, qf, close_qf, novsplit) out = vim.fn.systemlist(cmd) if not out or #out == 0 then return end
  vim.cmd(novsplit and "enew" or "vnew") vim.api.nvim_buf_set_lines( 0, 0, -1, false, out) scratch() if qf then scratch_to_quickfix(close_qf) end end

-- use alt+[npd] to go to next/previous buffer or to delete the buffer
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader><space>", ":ls<cr>:b ")
vim.keymap.set("n", "<leader>e", ":Explore<cr>")
vim.keymap.set("n", "-", ":Explore<cr>")
vim.keymap.set("n", "<leader>ln", ":set number!<cr>")
vim.keymap.set("n", "<leader>x",  scratch_to_quickfix)
vim.keymap.set("n", "<leader>h",  function() vim.bo.buftype = "" vim.bo.bufhidden = "hide" vim.bo.swapfile = true end)
vim.keymap.set("n", "<leader>so", function() vim.cmd("enew")  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.v.oldfiles) scratch() end) 
vim.keymap.set("n", "<leader>gb", function() extcmd("git blame " .. vim.fn.expand("%"), false, false, true) end)
vim.keymap.set("n", "<leader>gs", function() extcmd("git show " .. vim.fn.expand("<cword>")) end)
vim.keymap.set("n", "<leader>gc", function() extcmd("git diff --name-only --diff-filter=U", true) end)
vim.keymap.set("n", "<leader>gp", function() vim.cmd("edit " .. vim.fn.system("python3 -c 'import site; print(site.getsitepackages()[0])'") :gsub("%s+$", "") .. "/.") end)
vim.keymap.set("n", "<leader>gr", function() local reg = os.getenv("CARGO_HOME") or (os.getenv("HOME") .. "/.cargo") .. "/registry/src" vim.cmd( "edit " .. reg .. "/" .. vim.fn.systemlist("ls -1 " .. reg)[1]) end)
vim.keymap.set("n", "<leader>ss", function() vim.ui.input({ prompt = "> " }, function(p) if p then extcmd("grep -in '" .. p .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0))) end end) end)
vim.keymap.set("n", "<leader>sg", function() vim.ui.input({ prompt = "> " }, function(p) if p then local path, excludes, ex = pre_search() 
  for _, pat in ipairs(excludes) do table.insert(ex, string.format("--exclude-dir='%s'", pat)) end extcmd(string.format("grep -IEnr %s '%s' %s", table.concat(ex, " "), p, path), true) end end) end)
vim.keymap.set("n", "<leader>sf", function() vim.ui.input({ prompt = "> " }, function(p) if p then local path, excludes, ex = pre_search()
  for _, pat in ipairs(excludes) do table.insert(ex, string.format("-path '*%s*' -prune -o", pat)) end extcmd(string.format("find %s %s -path '*%s*' -print", vim.fn.shellescape(path), table.concat(ex, " "), p), true, true) end end) end)
vim.keymap.set("n", "<leader>l", function() local bn, ft = vim.fn.expand("%"), vim.bo.filetype
  if ft == "python" then extcmd("isort -q " .. bn .. "&& black -q " .. bn) extcmd("ruff check --output-format=concise --quiet " .. bn, true) vim.cmd("edit") 
  elseif ft == "rust" then vim.fn.systemlist("cargo fmt") extcmd("cargo check && cargo clippy") end end)
local letters = "abcdefghijklmnopqrstuvwxyz" for i = 1, #letters do local l = letters:sub(i, i) local u = l:upper() vim.keymap.set('n', '<leader>a' .. l, "m" .. u)  vim.keymap.set('n', '<leader>j' .. l, "'" .. u) end
vim.keymap.set("n", "<leader>c", function() vim.ui.input({ prompt = "> " }, function(c) if c then extcmd(c) end end) end)

-- use leader m to quickly run make
vim.keymap.set("n", "<leader>m", ":make<CR>")



vim.keymap.set('n', '<leader>bl', function()
  local qf_list = {}
  for _, buf in ipairs(vim.fn.getbufinfo()) do
    if buf.listed == 1 then
      table.insert(qf_list, {
        filename = buf.name ~= '' and buf.name or '[No Name]',
        text = ':' .. buf.bufnr
      })
    end
  end
  vim.fn.setqflist(qf_list, 'r')
  vim.cmd('copen')
end, {})

-- Mom, can we have telescope? No, we have telescope at home. Telescope at home:
local function run_search(cmd)
  local output = vim.fn.systemlist(cmd)
  vim.cmd("enew")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
end

vim.api.nvim_create_user_command("FileSearch", function(opts)
  local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
  local excludes = "-path '*.egg-info*' -prune -o -path '*.git*' -prune -o -path '*__pycache__*' -prune -o"
  if not opts.bang then
    excludes = excludes .. " -path '*.venv*' -prune -o"
    excludes = excludes .. " -path '" .. vim.fn.getcwd() .. "/target*'" .. " -prune -o"
  end
  run_search("find " .. vim.fn.shellescape(path) .. " " .. excludes .. " " .. " -name " .. "'*" .. opts.args .. "*' -print")
end, { nargs = "+", bang = true })

vim.api.nvim_create_user_command("GrepTextSearch", function(opts)
  local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
  local excludes = "--exclude-dir='*target*' --exclude-dir=.git --exclude-dir='*.egg-info' --exclude-dir='__pycache__'"
  if not opts.bang then
    -- cwd search should only look at project files.
    excludes = excludes .. " --exclude-dir=.venv"
  end
  run_search("grep -IEnr "  .. excludes .. " '" .. opts.args .. "' " .. path)
end, { nargs = "+", bang = true })


vim.api.nvim_create_user_command("BlackText", function()
  vim.api.nvim_set_hl(0, "Normal", { fg = "#000000" })
end, {  bang = true })


vim.api.nvim_create_user_command("TextSearch", function(opts)
  local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
  local excludes = "--glob '!**/target/**' --glob '!.git/**' --glob '!**/*.egg-info/**' --glob '!**/__pycache__/**'"
  if not opts.bang then
    excludes = excludes .. " --glob '!**/.venv/**'"
  else
    excludes = excludes .. " --no-ignore "
  end
  local cmd = "rg --vimgrep -i -n " .. excludes .. " '" .. opts.args .. "' " .. path
  run_search(cmd)

end, { nargs = "+", bang = true })


-- Use fd to search for a pattern and open all results in new buffers
vim.api.nvim_create_user_command("QuickFdEdit", function(opts)
  vim.cmd("n `fd --max-depth 3 --type f " .. opts.args .. "`")
  vim.cmd("ls")
end, { nargs = "+" })



vim.keymap.set("n", "<leader>q", scratch_to_quickfix)
vim.keymap.set("n", "<leader>sf", function() vim.ui.input({ prompt = "> " }, function(name) if name then vim.cmd("FileSearch " .. name) end end) end)
vim.keymap.set("n", "<leader>lf", function() vim.ui.input({ prompt = "> " }, function(name) if name then vim.cmd("FileSearch! " .. name) end end) end)
vim.keymap.set("n", "<leader>sg", function() vim.ui.input({ prompt = "> " }, function(pattern) if pattern then vim.cmd("TextSearch " .. pattern) end end) end)
vim.keymap.set("n", "<leader>lg", function() vim.ui.input({ prompt = "> " }, function(pattern) if pattern then vim.cmd("TextSearch! " .. pattern) end end) end)
vim.keymap.set("n", "<leader>/", function()
  vim.ui.input({ prompt = "> " }, function(pattern)
    if not pattern or pattern == "" then return end
    run_search("grep -n '" .. pattern .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
  end)
end)
