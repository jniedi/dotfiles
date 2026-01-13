local vim = vim
local functions = require("functions")

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost",
    {
        callback = function() vim.highlight.on_yank() end,
        group = vim.api.nvim_create_augroup("YankHighlight",
            { clear = true }),
        pattern = "*",
    })

vim.api.nvim_create_autocmd("FileType",
    {
        callback = function()
            local i = 4
            for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 100, false)) do
                local cind = line:match("^(%s+)")
                if cind and not line:match("^%s*$") then i = math.min(i, #cind) end
            end
            vim.opt_local.expandtab = true
            vim.opt_local.shiftwidth = i
            vim.opt_local.tabstop = i
            vim.opt_local.softtabstop = i
        end,
    })

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "lua", "python" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "javascript", "typescript", "json", "html", "css" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = { "cpp", "c", "hpp" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0, {})
        end
    end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
    end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    callback = function()
        local dir = vim.fn.expand('<afile>:p:h')
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, 'p')
        end
    end,
})

vim.api.nvim_create_user_command("FileSearch", function(opts)
    local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local excludes = "-path '*.egg-info*' -prune -o -path '*.git*' -prune -o -path '*__pycache__*' -prune -o"
    if not opts.bang then
        excludes = excludes .. " -path '*.venv*' -prune -o"
        excludes = excludes .. " -path '" .. vim.fn.getcwd() .. "/target*'" .. " -prune -o"
    end
    functions.run_search("find " ..
        vim.fn.shellescape(path) .. " " .. excludes .. " " .. " -name " .. "'*" .. opts.args .. "*' -print")
end, { nargs = "+", bang = true })

vim.api.nvim_create_user_command("GrepTextSearch", function(opts)
    local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local excludes = "--exclude-dir='*target*' --exclude-dir=.git --exclude-dir='*.egg-info' --exclude-dir='__pycache__'"
    if not opts.bang then
        -- cwd search should only look at project files.
        excludes = excludes .. " --exclude-dir=.venv"
    end
    functions.run_search("grep -IEnr " .. excludes .. " '" .. opts.args .. "' " .. path)
end, { nargs = "+", bang = true })


vim.api.nvim_create_user_command("BlackText", function()
    vim.api.nvim_set_hl(0, "Normal", { fg = "#000000" })
end, { bang = true })


vim.api.nvim_create_user_command("TextSearch", function(opts)
    local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local excludes = "--glob '!**/target/**' --glob '!.git/**' --glob '!**/*.egg-info/**' --glob '!**/__pycache__/**'"
    if not opts.bang then
        excludes = excludes .. " --glob '!**/.venv/**'"
    else
        excludes = excludes .. " --no-ignore "
    end
    local cmd = "rg --vimgrep -i -n " .. excludes .. " '" .. opts.args .. "' " .. path
    functions.run_search(cmd)
end, { nargs = "+", bang = true })

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = { "*:i", "i:*" },
    command = "set invlist"
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = { "*:i", "i:*" },
    callback = function()
        vim.cmd([[set invcul]])
    end
})

-- vim.api.nvim_create_autocmd("ModeChanged", {
--     callback = function()
--         local is_enabled = vim.opt.relativenumber:get()
--         vim.opt.relativenumber = not is_enabled
--     end,
--     pattern = { "[vV\x16]*:*", "*:[vV\x16]*" },
-- }
-- )


