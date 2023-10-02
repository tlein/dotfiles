--------------------------------------------
-- Tucker Lein's Neovim config
--
-- Based On: https://github.com/brainfucksec/neovim-lua
--------------------------------------------
--------------------------------------------
-- Initialize Packer (Plugin Manager)
teg = require('tjl/core/teg')
require('tjl/packer_init')

------------------------------------------
-- Load core vim settings
require('tjl/core/options')
require('tjl/core/keymaps')
require('tjl/core/colors')
require('tjl/core/commands')
require('tjl/core/autocmds')

------------------------------------------
-- Load plugin settings
require('tjl/plugins/lsp')
require('tjl/plugins/lspkind')
require('tjl/plugins/nvim-tree')
require('tjl/plugins/nvim-treesitter')
require('tjl/plugins/FTerm')
require('tjl/plugins/telescope')
require('tjl/plugins/commander')
require('tjl/plugins/kommentary')
require('tjl/plugins/spectre')
require('tjl/plugins/auto_dark_mode')
require('tjl/plugins/zk')
require('tjl/plugins/nvim-cursorline')
require('tjl/plugins/catppuccin')
require('tjl/plugins/dressing')
require('tjl/plugins/nvim-notify')
require('tjl/plugins/diffview')
require('tjl/plugins/lualine')
require('tjl/plugins/help-vsplit')
require('tjl/plugins/lsp_lines')
require('tjl/plugins/fidget')
-- trial mode below this line
require('tjl/plugins/indent-blankline')
require('tjl/plugins/vim-wordmotion')
require('tjl/plugins/arena')

vim.defer_fn(function()
  vim.api.nvim_command('colorscheme catppuccin')
  teg.notify_info(
    'Performed a post-boot sequence 1.0 seconds after init.lua finished.\nThis is expected (you did this to get the catppuccin colorscheme re-applied after boot)'
  )
end, 1000)
