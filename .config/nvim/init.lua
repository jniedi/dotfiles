local vim = vim


local pluginpath = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"
if not vim.loop.fs_stat(pluginpath) then
    vim.fn.system({ "mkdir", "-p", pluginpath })
end



local plugins = {
    {
        p = pluginpath .. "ultisnips.git",
        url = "https://github.com/SirVer/ultisnips.git",
    },
    {
        p = pluginpath .. "typst-preview.git",
        url = "https://github.com/chomosuke/typst-preview.nvim.git",
    },
    {
        p = pluginpath .. "mini.pick.git",
        url = "https://github.com/echasnovski/mini.pick.git",
    },
    {
        p = pluginpath .. "mini.extra.git",
        url = "https://github.com/echasnovski/mini.extra.git",
    }

}



for _,plugin in pairs(plugins) do
    if not vim.loop.fs_stat(plugin.p) then
        vim.fn.system({ "git", "clone", plugin.url, plugin.p  })
        vim.opt.rtp:append(plugin.p)
    end
end

-- vim.pack.add({"https://github.com/SirVer/ultisnips.git"})

require('mini.pick').setup()
require('mini.extra').setup()
require("options")
require("remaps")
require("autocommands")
require("lsp")
