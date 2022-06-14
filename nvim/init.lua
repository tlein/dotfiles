--------------------------------------------
-- Tucker Lein's Neovim config
--
-- Based On: https://github.com/brainfucksec/neovim-lua
--------------------------------------------
--------------------------------------------
-- Initialize Packer (Plugin Manager)
require("tjl/packer_init")

------------------------------------------
-- Load core vim settings
require("tjl/core/options")
require("tjl/core/keymaps")
require("tjl/core/colors")
require("tjl/core/autocmds")

------------------------------------------
-- Load plugin settings
require("tjl/plugins/lsp")
require("tjl/plugins/nvim-tree")
require("tjl/plugins/FTerm")
require("tjl/plugins/telescope")
require("tjl/plugins/neoformat")
require("tjl/plugins/ale")
