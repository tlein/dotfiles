require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'lua',
    'markdown',
    'zig',
    'bash',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      'markdown',
    },
  },
})
