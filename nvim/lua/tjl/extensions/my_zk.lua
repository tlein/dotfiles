local M = {}

local keymaps = require('tjl/core/keymaps')
local teg = require('tjl/core/teg')
local zk = require('zk')

local zk_error = function(msg, opts)
  if opts == nil then
    opts = {}
  end

  opts.title = 'Zettelkasten'
  teg.notify_error(msg, { title = 'Zettelkasten' })
end

local zk_trace = function(msg, opts)
  if opts == nil then
    opts = {}
  end

  opts.title = 'Zettelkasten'
  teg.notify_trace(msg, { title = 'Zettelkasten' })
end

M.note_types = {
  'archive',
  'reference',
  'child_reference',
  'definition',
  'blob',
}

function M.create_zettel()
  vim.ui.select(M.note_types, { prompt = 'Type?' }, M.create_zettel_of_type)
end

function M.create_zettel_of_type(zettel_type)
  if zettel_type == nil then
    return
  end

  vim.ui.input({ prompt = 'What is the _title_ of this new Zettel?: ' }, function(zettel_title)
    M.create_zettel_of_type_and_title(zettel_type, zettel_title)
  end)
end

-- IDEA:
-- Future improvement could pull up a vim.ui.select window of all the base_reference zettels when making a
-- child_reference
function M.create_zettel_of_type_and_title(zettel_type, zettel_title)
  if zettel_title == nil or zettel_type == nil then
    return
  end

  if zettel_title == '' then
    zk_error('Error: Zettel title was empty!')
    return
  end

  local zk_new_opts = {
    group = zettel_type,
    title = zettel_title,
  }
  if zettel_type == 'archive' then
    zk_new_opts.dir = 'archive'
  elseif zettel_type == 'reference' then
    zk_new_opts.dir = 'reference'
  elseif zettel_type == 'child_reference' then
    zk_new_opts.dir = 'reference'
  elseif zettel_type == 'definition' then
    zk_new_opts.dir = 'definition'
  elseif zettel_type == 'blob' then
    zk_new_opts.dir = 'blob'
  else
    zk_error('Error: Zettel type value was unexpected it was: ' .. zettel_type)
  end

  zk_trace(
    'Creating a new zettel of type `'
      .. zettel_type
      .. '`, and with the title: '
      .. zettel_title
      .. '\nopts into zk.new:\n'
      .. vim.inspect(zk_new_opts)
  )
  zk.new(zk_new_opts)
end

M.register_zk_keymaps_if_in_notebook = function()
  -- Add the key mappings only for Markdown files in a zk notebook.
  if require('zk.util').notebook_root(vim.fn.expand('%:p')) ~= nil then
    keymaps.register_zk_keymaps()
  end
end

return M
