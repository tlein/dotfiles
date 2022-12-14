-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
end

-- Autocmd to sync packer when this file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use but this is effectively the same as:
-- require('packer')
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Packer (can manager itself)
  use('wbthomason/packer.nvim')

  -- File explorer
  use('kyazdani42/nvim-tree.lua')

  -- LSP
  use({
    'neovim/nvim-lspconfig',
    wants = {
      'mason.nvim',
      'mason-lspconfig.nvim',
      'mason-tool-installer.nvim',
    },
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/nvim-cmp',
      'jose-elias-alvarez/null-ls.nvim',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'onsails/lspkind-nvim',
    },
  })

  -- Treesitter provides better syntax highlighting for configured languages
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  })

  -- Icons
  use('kyazdani42/nvim-web-devicons')

  -- Color schemes
  use({ 'catppuccin/nvim', as = 'catppuccin' })

  -- Tag viewer
  use('preservim/tagbar')

  -- common utility library
  use('nvim-lua/plenary.nvim')

  -- Telescope (fuzzy search)
  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })
  use({
    'gfeiyou/command-center.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
  })

  use({ 'smartpde/telescope-recent-files' })

  -- Terminals using FTerm
  use('numToStr/FTerm.nvim')

  -- Markdown preview
  use({
    'iamcco/markdown-preview.nvim',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
  })

  -- Commenting blocks
  use('b3nj5m1n/kommentary')

  -- Git diff
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

  -- Find all in workspace and replace
  use({ 'windwp/nvim-spectre', requires = 'nvim-lua/plenary.nvim' })

  -- Zig language support
  use({ 'ziglang/zig.vim' })

  -- Sets the background to light or dark based on the OS theme (only macOS)
  use('f-person/auto-dark-mode.nvim')

  -- Zettelkasten cmd line tool integration
  use('mickael-menu/zk-nvim')

  -- Highlights the line you're on (supposed to highlight the word and other instances your on with LSP
  -- integration, but that doesn't seem to work for me.
  use('yamatsum/nvim-cursorline')

  -- Status line
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  })

  -- fancy ui for vim.ui.input and vim.ui.select functionality
  use({ 'stevearc/dressing.nvim' })

  -- notification toasts
  use({ 'rcarriga/nvim-notify' })

  -- track LSP status information so we can use it places (such as the statusline)
  use({ 'nvim-lua/lsp-status.nvim' })

  -- for typescript dev
  -- Disabling for now because prettier is breaking an include, with `null-ts`. That is overstepping its bounds and I'ma
  -- put it in time out while I figure out if something so "big" and "opinionated" is appropriate for a plugin that isn't
  -- hyper-constrainted to whatever project requires such opinions.
  -- Also, its commented out in init.lua to configure the plugin and lsp.lua to configure the lsp nature of it
  -- use({ 'MunifTanjim/prettier.nvim', requires = { 'jose-elias-alvarez/null-ls.nvim', 'neovim/nvim-lspconfig' } })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
