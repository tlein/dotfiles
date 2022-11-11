local lspconfig = require('lspconfig')
local lspconfig_util = require('lspconfig.util')
local lsp_configs = require('lspconfig/configs')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local mason_tool_installer = require('mason-tool-installer')
local cmp = require('cmp')
local luasnip = require('luasnip')
local null_ls = require('null-ls')

mason.setup({
  ui = {
    icons = {
      package_uninstalled = '✗',
      package_installed = '✓',
      package_pending = '➜',
    },
  },
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.zigfmt,
  },
})

lsp_configs.zk = {
  default_config = {
    cmd = { 'zk', 'lsp' },
    filetypes = { 'markdown' },
    root_dir = function()
      return lspconfig_util.root_pattern('.zk')
    end,
    settings = {},
    single_file_support = false,
  },
}

local language_tools = {
  'lua-language-server',
  'stylua',
  'bash-language-server',
  'codelldb',
  'shfmt',
  'misspell',
  'zls',
  'zk',
}

local language_servers = {
  html = {},
  jsonls = {},
  rust_analyzer = {},
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = { enable = false },
        format = { enable = false },
      },
    },
  },
  bashls = {},
  omnisharp = {},
  tsserver = {},
  zk = {},
}

mason_tool_installer.setup({
  ensure_installed = language_tools,
  auto_update = false,
  run_on_start = true,
})

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(language_servers),
  automatic_installation = false,
})

-- Add additional capabilities supported by nvim-cmp
local my_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(nil),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local my_on_attach = function(_, bufnr)
  print('my_on_attach, keyamps')
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

vim.cmd([[
    augroup format_on_save
      au!
      au BufWritePre * lua vim.lsp.buf.format()
    augroup end
  ]])

mason_lspconfig.setup_handlers({
  function(server_name)
    local server_opts = language_servers[server_name] or {}
    server_opts.on_attach = my_on_attach
    server_opts.capabilities = my_capabilities
    lspconfig[server_name].setup(server_opts)
  end,

  -- Example of how to override default config that's done with the initial function directly above, this override
  -- doesn't currently actually do anything different from the default, but you could change something for sumneko_lua
  -- if desired.
  ['sumneko_lua'] = function()
    local server_opts = language_servers.sumneko_lua
    server_opts.on_attach = my_on_attach
    server_opts.capabilities = my_capabilities
    lspconfig.sumneko_lua.setup(server_opts)
  end,
})
