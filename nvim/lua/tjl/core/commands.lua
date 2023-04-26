-- demonstration command
vim.api.nvim_create_user_command('Upper', 'echo toupper(<q-args>)', { nargs = 1 })

vim.api.nvim_create_user_command(
  'Redir',
  'execute "edit temp_buffer | pu=execute(\'" . <q-args> . "\') | setl nomodified | setl buftype=nofile"',
  { nargs = 1 }
)
