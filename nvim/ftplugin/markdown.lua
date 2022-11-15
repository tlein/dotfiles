-- Add the key mappings only for Markdown files in a zk notebook.
if require('zk.util').notebook_root(vim.fn.expand('%:p')) ~= nil then
  local function map(...)
    vim.api.nvim_buf_set_keymap(0, ...)
  end

  local opts = { noremap = true, silent = false }

  -- Preview a linked note.
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- Open the link under the caret.
  map('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- Zellenkasten
  -- Override basic file fuzzy search for "Open Recent Notes"
  map('n', '<leader>g', '<Cmd>ZkRecents<CR>', opts)
  -- Override basic command fuzzy search for "Find by Tag"
  map('n', '<leader>c', '<Cmd>ZkTags<CR>', opts)
  -- Open notes.
  map('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
  -- Open notes associated with the selected tags.
  map('n', '<leader>zt', '<Cmd>ZkTags<CR>', opts)
  -- Search for the notes matching a given query.
  map('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
  -- Search for the notes matching the current visual selection.
  map('v', '<leader>zf', ":'<,'>ZkMatch<CR>", opts)
  -- Create a new note after asking for its title.
  -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
  -- map('n', '<leader>zn', "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
  map('n', '<leader>zn', ':lua require("tjl/extensions/my_zk").create_zettel({ type = "archive" })<CR>', opts)
  map('n', '<leader>zzn', ':lua require("tjl/extensions/my_zk").create_zettel()<CR>', opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map('v', '<leader>znt', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map(
    'v',
    '<leader>znc',
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    opts
  )
  -- Open notes linking to the current buffer.
  map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', opts)
  -- Open notes linked by the current buffer.
  map('n', '<leader>zl', '<Cmd>ZkLinks<CR>', opts)
  -- Open the code actions for a visual selection.
  map('v', '<leader>zc', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

vim.opt.wrap = true -- Turn on word wrap
vim.opt.colorcolumn = nil -- remove color column indicating 120 length lines.
