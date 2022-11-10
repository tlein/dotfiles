local prettier_group = vim.api.nvim_create_augroup("Prettier", {clear = true})

vim.api.nvim_create_autocmd(
    "BufWritePre *.ts *.tsx *.js *.jsx undojoin",
    {command = "Prettier", group = prettier_group}
)

-- Treesitter bad folds workaround
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})
