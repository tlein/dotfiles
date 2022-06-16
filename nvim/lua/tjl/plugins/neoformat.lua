-- Non-specific filtype settings
--[[ vim.g.neoformat_basic_format_retab = 1 -- Tab -> Spaces
vim.g.neoformat_basic_format_trim = 1 -- Trim trailing whitespace ]]
-- Languages configured for formatting
vim.g.neoformat_enabled_cpp = {"clangformat"}
vim.g.neoformat_enabled_c = {"clangformat"}
vim.g.neoformat_enabled_lua = {"luafmt"}
vim.g.neoformat_enabled_sh = {"shfmt"}
vim.g.shfmt_opt = "-ci"
