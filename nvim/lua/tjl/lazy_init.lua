local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Change leader to a semi-colon, ALSO SET IN keymaps.lua FOR NON-LAZY
vim.g.mapleader = ';'
vim.g.maplocaleader = ';'

-- Install plugins
require('lazy').setup({
  -- File explorer
  { 'kyazdani42/nvim-tree.lua' },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason.nvim',
      'mason-lspconfig.nvim',
      'mason-tool-installer.nvim',
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
  },

  -- Treesitter provides better syntax highlighting for configured languages
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  },

  -- Icons
  { 'kyazdani42/nvim-web-devicons' },

  -- Color schemes
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

  -- Tag viewer
  { 'preservim/tagbar' },

  -- common utility library, mostly for async stuff
  { 'nvim-lua/plenary.nvim' },

  -- Telescope (fuzzy search)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'gfeiyou/command-center.nvim' },
      { 'smartpde/telescope-recent-files' },
      { 'kkharji/sqlite.lua' },
    },
  },

  -- Terminals using FTerm
  { 'numToStr/FTerm.nvim' },

  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },

  -- Commenting blocks
  { 'b3nj5m1n/kommentary' },

  -- Git diff
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  -- Find all in workspace and replace
  { 'windwp/nvim-spectre', dependencies = 'nvim-lua/plenary.nvim' },

  -- Zig language support
  { 'ziglang/zig.vim' },

  -- Sets the background to light or dark based on the OS theme (only macOS)
  { 'f-person/auto-dark-mode.nvim' },

  -- Zettelkasten cmd line tool integration
  { 'mickael-menu/zk-nvim' },

  -- Highlights the line you're on (supposed to highlight the word and other instances your on with LSP
  -- integration, but that doesn't seem to work for me.
  { 'yamatsum/nvim-cursorline' },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
  },

  -- fancy ui for vim.ui.input and vim.ui.select functionality
  { 'stevearc/dressing.nvim' },

  -- notification toasts
  { 'rcarriga/nvim-notify' },

  -- track LSP status information so we can use it places (such as the statusline)
  { 'nvim-lua/lsp-status.nvim' },

  -- I would like help-y things to open in a split
  { 'anuvyklack/help-vsplit.nvim' },

  -- the lsp virtual text bothers me, goes too far off the page. this should more-or-less fix it.
  { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', name = 'lsp_lines.nvim' },

  -- puts virtual symbols on indentation scopes
  { 'lukas-reineke/indent-blankline.nvim' },

  -- better word traversal, so stuff like camelCase and PascalCase and snake_case will let me
  -- move through them as I expect to be able to using w/b/e (hint, use this comment as a test
  -- of the capabilities of the movement)
  { 'chaoren/vim-wordmotion' },

  -- shows a loading widget for lsp symbol loading, I want it there to re-assure me the lsp stuff
  -- is attached at a glance
  { 'j-hui/fidget.nvim', tag = 'legacy' },

  -- frecency buffers for individual sessions
  {
    'dzfrias/arena.nvim',
  },
})
