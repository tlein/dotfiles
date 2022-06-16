-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP =
        fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )
end

-- Autocmd to sync packer when this file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Install plugins
return packer.startup(
    function(use)
        -- Packer (can manager itself)
        use("wbthomason/packer.nvim")

        -- File explorer
        use("kyazdani42/nvim-tree.lua")

        -- LSP
        use("neovim/nvim-lspconfig")

        -- Icons
        use("kyazdani42/nvim-web-devicons")

        -- Tag viewer
        use("preservim/tagbar")

        -- Treesitter interface
        use("nvim-treesitter/nvim-treesitter")

        -- Telescope (fuzzy search)
        use(
            {
                "nvim-telescope/telescope.nvim",
                requires = {{"nvim-lua/plenary.nvim"}}
            }
        )
        use(
            {
                "gfeiyou/command-center.nvim",
                requires = {"nvim-telescope/telescope.nvim"}
            }
        )

        -- Statusline
        use("adelarsq/neoline.vim")

        -- One Color Theme
        use("rakr/vim-one")

        -- Terminals using FTerm
        use("numToStr/FTerm.nvim")

        -- Markdown preview
        use(
            {
                "iamcco/markdown-preview.nvim",
                run = function()
                    vim.fn["mkdp#util#install"]()
                end
            }
        )

        -- Neoformat (code formatter)
        use("sbdchd/neoformat")

        -- Ale (linting)
        use("dense-analysis/ale")

        -- Commenting blocks
        use("b3nj5m1n/kommentary")

        -- Git diff
        use {"sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim"}

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end
)
