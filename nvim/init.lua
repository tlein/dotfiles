--------------------------------------------
-- Tucker Lein's Neovim config
--
-- Based On: https://github.com/brainfucksec/neovim-lua
--------------------------------------------

-- I'm sick of trying to get the lua lsp to find this, just force it as a global
_G.vim = vim

------------------------------------------
-- Load utils that can be used anywhere
require('tjl/core/utils')

--------------------------------------------
-- Initialize Packer (Plugin Manager)
require('tjl/packer_init')

------------------------------------------
-- Load core vim settings
require('tjl/core/options')
require('tjl/core/keymaps')
require('tjl/core/colors')
require('tjl/core/autocmds')

------------------------------------------
-- Load plugin settings
require('tjl/plugins/lsp')
require('tjl/plugins/lspkind')
require('tjl/plugins/nvim-tree')
require('tjl/plugins/treesitter')
require('tjl/plugins/FTerm')
require('tjl/plugins/telescope')
require('tjl/plugins/kommentary')
require('tjl/plugins/spectre')
require('tjl/plugins/auto_dark_mode')
require('tjl/plugins/zk')
require('tjl/plugins/nvim-cursorline')
require('tjl/plugins/lualine')
require('tjl/plugins/catppuccin')
