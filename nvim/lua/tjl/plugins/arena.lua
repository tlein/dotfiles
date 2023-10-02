require('arena').setup({
  -- Keybinds for the arena window.
  keybinds = {
    -- Example. Uncomment to add to your config!
    ['<Esc>'] = function()
      require('arena').close()
    end,
  },
})
