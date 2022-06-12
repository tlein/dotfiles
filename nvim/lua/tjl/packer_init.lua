-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer_init.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

-- Install plugins
return packer.startup(function(use)
    -- Add you plugins here:
    use 'wbthomason/packer.nvim' -- packer can manage itself

    -- File explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Indent line
    use 'lukas-reineke/indent-blankline.nvim'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Tag viewer
    use 'preservim/tagbar'

    -- Treesitter interface
    use 'nvim-treesitter/nvim-treesitter'

    -- Telescope (fuzzy search)
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Statusline
    use {
        'feline-nvim/feline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    -- OneDark Color Theme
    use 'navarasu/onedark.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
