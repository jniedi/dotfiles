local vim=vim
-- TODO: simplyfy

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

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
          global = { "vim" },
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

-- TODO: toggle redline with <C-d> 
vim.diagnostic.config({
    signs = true,
        -- signs = {
        --     text = {
        --         [vim.diagnostic.severity.ERROR] = '',
        --         [vim.diagnostic.severity.WARN] = '',
        --     },
        --     linehl = {
        --         [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        --     },
        --     numhl = {
        --         [vim.diagnostic.severity.WARN] = 'WarningMsg',
        --     },
        -- },
  virtual_text = false,
  update_in_insert = false,
  underline = true,
})

local test = "hello there"
