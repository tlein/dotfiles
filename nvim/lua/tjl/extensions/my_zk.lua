local M = {}

local zk = require('zk')

-- IDEA:
-- Future improvement could pull up a vim.ui.select window of all the base_reference zettels when making a
-- child_reference
function M.create_zettel()
  vim.ui.select({ 'archive', 'reference', 'child_reference' }, {
    prompt = 'Type?',
    telescope = require('telescope.themes').get_cursor(),
  }, function(zettel_type)
    if zettel_type == nil then
      return
    end

    vim.ui.input({ prompt = 'What is the _title_ of this new Zettel?: ' }, function(zettel_title)
      if zettel_title == nil then
        return
      end

      if zettel_title == '' then
        print('Error: Zettel title was empty!')
        return
      end

      local opts = {
        group = zettel_type,
        title = zettel_title,
      }
      if zettel_type == 'archive' then
        opts.dir = 'archive'
      elseif zettel_type == 'reference' then
        opts.dir = 'reference'
      elseif zettel_type == 'child_reference' then
        opts.dir = 'reference'
      else
        print('Error: Zettel type value was unexpected it was: ' .. zettel_type)
      end

      print(
        'Creating a new zettel of type `'
          .. zettel_type
          .. '`, and with the title: '
          .. zettel_title
          .. '\nopts into zk.new:\n'
          .. vim.inspect(opts)
      )
      zk.new(opts)
    end)
  end)
end

return M
