local notify = require('notify')

vim.notify = notify

notify.setup({
  top_down = false,
})
