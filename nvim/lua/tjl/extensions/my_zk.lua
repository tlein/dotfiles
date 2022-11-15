local M = {}

local zk = require('zk')

local zk_info = function(msg, opts)
  if opts == nil then
    opts = {}
  end

  opts.title = 'Zettelkasten'
  vim.notify(msg, vim.log.levels.INFO, opts)
end

local zk_error = function(msg, opts)
  if opts == nil then
    opts = {}
  end

  opts.title = 'Zettelkasten'
  vim.notify(msg, vim.log.levels.ERROR, opts)
end

-- IDEA:
-- Future improvement could pull up a vim.ui.select window of all the base_reference zettels when making a
-- child_reference
function M.create_zettel()
  local select_opts = { 'archive', 'reference', 'child_reference' }

  vim.ui.select(select_opts, {
    prompt = 'Type?',
  }, function(zettel_type)
    if zettel_type == nil then
      return
    end

    vim.ui.input({ prompt = 'What is the _title_ of this new Zettel?: ' }, function(zettel_title)
      if zettel_title == nil then
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
      else
        zk_error('Error: Zettel type value was unexpected it was: ' .. zettel_type)
      end

      zk_info(
        'Creating a new zettel of type `'
          .. zettel_type
          .. '`, and with the title: '
          .. zettel_title
          .. '\nopts into zk.new:\n'
          .. vim.inspect(zk_new_opts)
      )
      zk.new(zk_new_opts)
    end)
  end)
end

return M
