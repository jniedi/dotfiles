local vim = vim

local pluginpath = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"
if not vim.loop.fs_stat(pluginpath) then
  vim.fn.system({ "mkdir", "-p", pluginpath})
end

if not vim.loop.fs_stat(pluginpath .. "ultisnips.git") then
  vim.fn.system({ "git", "clone", "https://github.com/SirVer/ultisnips.git", pluginpath .. "ultisnips.git", })
  vim.opt.rtp:append(pluginpath .. "ultisnips.git")
end

require("options")
require("remaps")
require("autocommands")
require("lsp")




