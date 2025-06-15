function ColorMyPencils(color)
    color = color or "rose-pine-main"
    vim.cmd.colorscheme(color)
    vim.cmd('hi NonText ctermbg=none guibg=NONE')
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE')
    vim.cmd('hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE')

    vim.cmd('hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE')
    vim.cmd('hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE')
    vim.cmd('hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE')
    vim.cmd('hi TabLine ctermbg=None ctermfg=None guibg=None')
end



ColorMyPencils("wildcharm")
-- ColorMyPencils()
