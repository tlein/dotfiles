-- To add a new lspserver do these steps:
-- 1. Get the name of the plugin, upon writing these instructions I'm evalating an extension called
--    "grammar_guard" because it sounds like an interesting thing to try and add spell-checking to
--    my zk repo nvim experience.
-- 2. To configure the lsp plugin, we use mason. Add it to lsp_servers_and_their_configs to have
--    mason register the lsp. This is the entry point for what is normally manually calling
--    `require("lspconfig").PLUGIN_NAME.setup()`. You can pass params to the eventual call to
--    `require("lspconfig").PLUGIN_NAME.setup()` here as well, it's a table key->value pair of lsp
--    plugin name -> options forwarded to `setup()`.
-- 3. If the plugin requires an external, supporting, application (usually a cli tool) check if it
--    can be installed by running :Mason in nvim, search for the plugin. If it is present, install
--    it and add it to lsp_external_supporting_applications

local M = {}

-- # Module: teg-lspconfig
--
-- ## Meta
--
-- Allow the lsp_status lua library capture information about our lsp setup for an extended api to
-- query for information about the state of the nvim-lspconfig system.
local lsp_status = require('lsp-status')
lsp_status.register_progress()
--
-- ## /Meta
--
-- ## Includes (to assist the module's impl)
--
local lspconfig = require('lspconfig') -- base neovim lsp functionality

-- "mason is a plugin that allows you to easily manage external editor tooling such as LSP servers, DAP servers,
-- linters, and formatters through a single interface"
local mason = require('mason')

-- "mason-lspconfig bridges mason.nvim with the lspconfig plugin - making it easier to use both plugins together."
local mason_lspconfig = require('mason-lspconfig')
local mason_tool_installer = require('mason-tool-installer')
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local luasnip = require('luasnip')
local null_ls = require('null-ls')
local teg = require('tjl/core/teg')
--
-- ## /Includes (to assist the module's impl)
--
-- ## Data (for the module)
-- Mason configurations (https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md)
local lsp_servers_and_their_configs = {
  html = {},
  jsonls = {},
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        hint = { enable = true },
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            'vim',
            'teg',
          },
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
  yamlls = {},
  clangd = {},
  wgsl_analyzer = {},
}

local lsp_external_supporting_applications = {
  'lua-language-server',
  'stylua',
  'bash-language-server',
  'codelldb',
  'shfmt',
  'zls',
  'vim-language-server',
  'yaml-language-server',
  'yamlfmt',
  'clangd',
  'wgsl-analyzer',
}

if vim.loop.os_uname().sysname ~= 'Windows_NT' then
  -- These application installs use something that doesn't behave well on my Windows system (such
  -- as `python venv`)
  table.insert(lsp_external_supporting_applications, 'beautysh')
  table.insert(lsp_external_supporting_applications, 'clang-format')
end

local filetypes_to_ignore_formatting_for = teg.create_set_from_table({
  'vim',
  'gitignore',
  'gitconfig',
  'text',
  'markdown',
  'cmake',
})

-- Uses `vim.fn.fnamemodify(vim.fn.getcwd(), ':t')` to get the dirname of the cwd (last part of
-- cwd). Then if that dirname is a key in this map, we can try doing code formatting. This is to
-- prevent external projects from being something that neovim would attempt to format.
local projects_to_allow_formatting_for = teg.create_set_from_table({
  'teg',
  'dotfiles',
  'squatbot',
  'ancona',
  'jat', -- rufus game
  'parallel_programming_course',
})
-- ## /Data (for the module)
--
-- ## Initilization (of the module)
--
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
    null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.yamlfmt,
  },
})

M.get_mason_lsp_server_names = function()
  local arr = {}

  for k, v in pairs(lsp_servers_and_their_configs) do
    local lsp_key = v.mason_lspconfig_name_override or k
    table.insert(arr, lsp_key)
  end

  return arr
end

mason_lspconfig.setup({
  ensure_installed = M.get_mason_lsp_server_names(),
  automatic_installation = false,
})

mason_tool_installer.setup({
  ensure_installed = lsp_external_supporting_applications,
  auto_update = false,
  run_on_start = true,
})

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

-- Add additional capabilities supported by nvim-cmp and lsp-status
M.my_capabilities = teg.merge_tables(cmp_nvim_lsp.default_capabilities(), lsp_status.capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
M.my_on_attach = function(client, bufnr)
  lsp_status.on_attach(client)

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
  if vim.lsp.inlay_hint then
    vim.keymap.set('n', '<leader>uh', function()
      vim.lsp.inlay_hint(0, nil)
    end, { desc = 'Toggle Inlay Hints' })
  else
  end
end

local TjlFormatOnSaveGroup =
  vim.api.nvim_create_augroup('tjl_format_on_save_augroup', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if filetypes_to_ignore_formatting_for[vim.bo.filetype] ~= nil then
      teg.notify_trace(
        'This filetype (' .. vim.bo.filetype .. ') is explicitly ignored for formatting!'
      )
      return
    end

    local project_dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    if projects_to_allow_formatting_for[string.lower(project_dirname)] == nil then
      teg.notify_trace(
        'This project ('
          .. project_dirname
          .. ') is not included in tjl/plugins/lsp.lua projects_to_allow_formatting_for, so '
          .. 'formatting will not be attempted!'
      )
      return
    end

    teg.notify_trace('Attempting to format filetype: ' .. vim.bo.filetype)
    vim.lsp.buf.format()
  end,
  group = TjlFormatOnSaveGroup,
})

mason_lspconfig.setup_handlers({
  function(server_name)
    local server_opts = lsp_servers_and_their_configs[server_name] or {}
    local lsp_key = server_opts.nvim_lspconfig_name or server_name

    server_opts.on_attach = M.my_on_attach
    server_opts.capabilities = M.my_capabilities
    lspconfig[lsp_key].setup(server_opts)
  end,

  -- Example of how to override default config that's done with the initial function directly above, this override
  -- doesn't currently actually do anything different from the default, but you could change something for lua_ls
  -- if desired.
  -- ['lua_ls'] = function()
  --   local server_opts = lsp_servers_and_their_configs.lua_language_server
  --   server_opts.on_attach = M.my_on_attach
  --   server_opts.capabilities = M.my_capabilities
  --   lspconfig['lua-language-server'].setup(server_opts)
  -- end,
})

M.enable_trace_logging = function()
  vim.lsp.set_log_level('trace')
  if vim.fn.has('nvim-0.5.1') == 1 then
    require('vim.lsp.log').set_format_func(vim.inspect)
  end
end

--
-- ## /Initilization (of the module)

return M
