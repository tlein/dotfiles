require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'lua',
    'vim',
    'vimdoc',
    'query',
    'markdown',
    'zig',
    'bash',
    'rust',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {
      'markdown',
    },
  },
})
