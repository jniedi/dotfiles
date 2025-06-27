local pluginpath = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"
if not vim.loop.fs_stat(pluginpath) then
  vim.fn.system({ "mkdir", "-p", pluginpath})
end

if not vim.loop.fs_stat(pluginpath .. "ultisnips.git") then
  vim.fn.system({ "git", "clone", "https://github.com/SirVer/ultisnips.git", pluginpath .. "ultisnips.git", })
  vim.opt.rtp:append(pluginpath .. "ultisnips.git")
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.UltiSnipsExpandTrigger = '<C-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-l>'
vim.g.UltiSnipsJumpBackwardTrigger = '<C-h>'
vim.g.UltiSnipsSnippetDirectories = { 'snips' }
vim.opt.termguicolors = true -- enable 24-bit RGB color in the TUI
vim.g.netrw_banner = ""


vim.o.clipboard = "unnamedplus"
vim.cmd("syntax off | colorscheme vim") 

if vim.uv.fs_stat(vim.fn.expand("~") .. "/.cache/light") then
    vim.api.nvim_set_hl(0, "Normal", { fg = "#000000" })
else
    -- darkmode
    vim.api.nvim_set_hl(0, "Normal", { fg = "#ffff00" }) -- orange: fg = "#ffaf00"
end

_G.basic_excludes = { ".git", "*.egg-info", "__pycache__", "wandb","target" } _G.ext_excludes = vim.list_extend(vim.deepcopy(_G.basic_excludes), { ".venv", })
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end, group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }), pattern = "*", })
vim.api.nvim_create_autocmd("FileType",  { callback = function() local i = 4
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 100, false)) do local cind = line:match("^(%s+)") if cind and not line:match("^%s*$") then i = math.min(i, #cind) end end
    vim.opt_local.expandtab=true vim.opt_local.shiftwidth=i vim.opt_local.tabstop=i vim.opt_local.softtabstop = i end , })
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
vim.keymap.set('n', '<C-d>', '<C-d>zz')     vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set("n", "<C-n>", ":cn<cr>")     vim.keymap.set("n", "<C-p>", ":cp<cr>")
vim.keymap.set("n", "<leader>n", ":bn<cr>") vim.keymap.set("n", "<leader>p", ":bp<cr>") vim.keymap.set("n", "<leader>d", ":bd<cr>")
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<C-s>", function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end)
vim.keymap.set("n", "<leader><space>", ":ls<cr>:b ")
vim.keymap.set("n", "<leader>e", ":Explore<cr>")
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

--
---- end of custom telescope 
--- in case I ever want to go back to telescope
-- local pluginpath = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"
-- if not vim.loop.fs_stat(pluginpath) then
--   vim.fn.system({ "git", "clone", "https://github.com/yobibyte/telescope.nvim", "--branch=0.1.x", pluginpath .. "telescope.nvim", })
--   vim.opt.rtp:append(pluginpath .. "telescope.nvim")
--   vim.fn.system({ "git", "clone", "https://github.com/yobibyte/plenary.nvim", pluginpath .. "plenary.nvim", })
-- end
-- vim.keymap.set("n", "<leader>sf", function() 
--   local config = { previewer = false, layout_strategy = "center", layout_config = { height = 0.4, }, } 
--   if vim.bo.filetype == "netrw" then config.cwd = vim.fn.expand("%:p:h") config.no_ignore = true end
--   require("telescope.builtin").find_files(config)
-- end)
-- vim.keymap.set("n", "<leader>sg", function() 
--   local config = {}
--   if vim.bo.filetype == "netrw" then
--     config.search_dirs = {vim.b.netrw_curdir} 
--     config.additional_args = function() return { "--hidden", "--no-ignore" } end
--   end
--   require("telescope.builtin").live_grep(config)
-- end)

vim.keymap.set("n", "<leader>o",  function() vim.cmd.edit(vim.fn.fnameescape(vim.fn.trim(vim.fn.getreg("+")))) end)
vim.keymap.set("n", "<C-j>", ":move .+1<CR>")
vim.keymap.set("n", "<C-k>", ":move .-2<CR>")
vim.keymap.set("v", "<C-j>", ":move '>+1<CR>gv")
vim.keymap.set("v", "<C-k>", ":move '<-2<CR>gv")
