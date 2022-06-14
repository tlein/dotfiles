----------------------------------------------
-- Neoformat
local neoformat_group = vim.api.nvim_create_augroup("Neoformat", {clear = true})

vim.api.nvim_create_autocmd("BufWritePre * undojoin",
                            {command = "Neoformat", group = neoformat_group})
