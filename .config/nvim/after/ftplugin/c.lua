local vim = vim

vim.cmd([[
setlocal textwidth=100
setlocal comments-=:// comments+=:///,://

"setlocal makeprg=cmake\ --build\ .

nnoremap <buffer> [[    [[3<c-y>

" indent after parens, etc.
setlocal cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l1,b0  " Control structures
setlocal cinoptions+=ps,t0                            " function declarations
setlocal cinoptions+=c3,C1,/0                         " Comments
setlocal cinoptions+=+s                               " Continuation lines
setlocal cinoptions+=(0,u0,U1,w1,W0,m0,M0             " Parens and arguments
setlocal cinoptions+=)20,*30                          " Search range

if '' ==# findfile('.clang-format', ';')
  setlocal formatprg=clang-format\ -style=LLVM
else
  setlocal formatprg=clang-format\ -style=file
endif

if fnamemodify(@%, ':p') =~# 'neovim'
  let b:printf_pattern = 'ILOG("%d", %s);'
  nnoremap <silent><buffer> <leader>log oELOG("");<esc>
endif

command! InsertCBreak         norm! i#include <signal.h>raise(SIGINT);
]])

vim.api.nvim_create_autocmd('InsertCharPre', {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function()
        if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
            return
        else
            vim.lsp.completion.get()
        end
    end
})
