local prettier_group = vim.api.nvim_create_augroup("Prettier", {clear = true})

vim.api.nvim_create_autocmd(
    "BufWritePre *.ts *.tsx *.js *.jsx undojoin",
    {command = "Prettier", group = prettier_group}
)
