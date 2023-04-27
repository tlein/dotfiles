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
return packer.startup({
  function(use)
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
      requires = {
        { 'nvim-lua/plenary.nvim' },
        { 'gfeiyou/command-center.nvim' },
        { 'smartpde/telescope-recent-files' },
        { 'kkharji/sqlite.lua' },
      },
    })

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

    -- I would like help-y things to open in a split
    use({ 'anuvyklack/help-vsplit.nvim' })

    -- the lsp virtual text bothers me, goes too far off the page. this should more-or-less fix it.
    use({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', as = 'lsp_lines.nvim' })

    -- puts virtual symbols on indentation scopes
    use({ 'lukas-reineke/indent-blankline.nvim' })

    -- better word traversal, so stuff like camelCase and PascalCase and snake_case will let me
    -- move through them as I expect to be able to using w/b/e (hint, use this comment as a test
    -- of the capabilities of the movement)
    use({ 'chaoren/vim-wordmotion' })

    -- shows a loading widget for lsp symbol loading, I want it there to re-assure me the lsp stuff
    -- is attached at a glance
    use({ 'j-hui/fidget.nvim' })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    },
  },
})
