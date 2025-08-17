local vim = vim

vim.api.nvim_create_user_command(
    'ShiftLine', function(opts)
        for i=1, opts.args, 1 do
            vim.cmd("norm _")
            vim.cmd("norm x")
            vim.cmd("norm $p")
        end
    end,
    { nargs = 1 }
)

vim.keymap.set("n", "<leader>s", ":ShiftLine ", {})

-- hfdhfhf
