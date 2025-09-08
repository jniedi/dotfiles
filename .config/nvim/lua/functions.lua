local vim = vim

local usercmd = vim.api.nvim_create_user_command

local M = {}

_G.basic_excludes = { ".git", "*.egg-info", "__pycache__", "wandb", "target" , "aux", "output" }
_G.ext_excludes = vim.list_extend(vim.deepcopy(_G.basic_excludes), { ".venv", })

M.scratch_to_quickfix = function(close_qf)
    local items, bufnr = {}, vim.api.nvim_get_current_buf()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
        if line ~= "" then
            local f, lnum, text = line:match("^([^:]+):(%d+):(.*)$")
            if f and lnum then
                table.insert(items, { filename = vim.fn.fnamemodify(f, ":p"), lnum = tonumber(lnum), text = text, }) -- for grep filename:line:text
            else
                local lnum, text = line:match("^(%d+):(.*)$")
                if lnum and text then
                    table.insert(items,
                        { filename = vim.fn.bufname(vim.fn.bufnr("#")), lnum = tonumber(lnum), text = text, }) -- for current buffer grep
                else
                    table.insert(items, { filename = vim.fn.fnamemodify(line, ":p") })                         -- for find results, only fnames
                end
            end
        end
    end
    vim.api.nvim_buf_delete(bufnr, { force = true })
    vim.fn.setqflist(items, "r")
    vim.cmd("copen | cc")
    if close_qf then vim.cmd("cclose") end
end

M.run_search = function(cmd)
    local output = vim.fn.systemlist(cmd)
    vim.cmd("enew")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
end

M.scratch = function()
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
end
M.pre_search = function() if vim.bo.filetype == "netrw" then return vim.b.netrw_curdir, _G.basic_excludes, {} else return
        vim.fn.getcwd(), _G.ext_excludes, {} end end
M.extcmd = function(cmd, qf, close_qf, novsplit)
    local out = vim.fn.systemlist(cmd)
    if not out or #out == 0 then return end
    vim.cmd(novsplit and "enew" or "vnew")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, out)
    M.scratch()
    if qf then M.scratch_to_quickfix(close_qf) end
end


-- Why not use tmux?
usercmd("ConfigEdit", function(opts)
    local dir = "~/.config/nvim"
    local o = {
        lua = "/lua",
        maps = "/lua/remaps.lua",
        functions = "/lua/functions.lua",
        options = "/lua/options.lua",
    }
    if o[opts.fargs[1]] then
        dir = dir .. o[opts.fargs[1]]
    end
    vim.cmd("e " .. dir)
end , {nargs="*"})



M.find_root = function(patterns)
    local path = vim.fn.expand('%:p:h')
    local root = vim.fs.find(patterns, { path = path, upward = true })[1]
    return root and vim.fn.fnamemodify(root, ':h') or path
end

return M
