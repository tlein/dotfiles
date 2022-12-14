local M = {}

local command_center = require('command_center')


M.map = function(mode, lhs, rhs, opts)
  local options = { noremap = false, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
local map = M.map

M.command_center_map = function(command_cmd, command_desc, shortcut_mode, shortcut_keybind)
  if shortcut_mode then
    command_center.add({
      {
        description = command_desc,
        cmd = command_cmd,
        keybindings = { { shortcut_mode, shortcut_keybind, { noremap = true } } },
      },
    })
  else
    command_center.add({
      {
        description = command_desc,
        cmd = command_cmd,
      },
    })
  end
end
local command_center_map = M.command_center_map

-- Change leader to a semi-colon
vim.g.mapleader = ';'

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Remap Esc
map('i', 'jk', '<Esc>')

-- Clear search highlighting
map('n', '<leader>v', ':nohl<CR>')

-- Create splits
map('n', '<leader>s', ':vsplit<CR>')
map('n', '<leader>S', ':split<CR>')
map('n', '<leader>n', ':vnew<CR>')
map('n', '<leader>N', ':new<CR>')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<leader>h', '<C-w>h')
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>k', '<C-w>k')
map('n', '<leader>l', '<C-w>l')

-- Resize splits
map('n', '<Up>', '<C-w>+')
map('n', '<Right>', '<C-w>>')
map('n', '<Down>', '<C-w>-')
map('n', '<Left>', '<C-w><')
map('n', '<S-Up>', '10<C-w>+')
map('n', '<S-Right>', '10<C-w>>')
map('n', '<S-Down>', '10<C-w>-')
map('n', '<S-Left>', '10<C-w><')

-- Reload configuration without restart nvim
map('n', '<leader>r', ':Restart<CR>')
command_center_map(':Restart<CR>', "Attempt nvim config reload (probably won't work)", nil, nil)

-- Fast saving with <leader> and s
map('n', '<leader>w', ':w<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>aq', ':q<CR>')
map('n', '<leader>aaq', ':qa!<CR>')

-- :nnoremap <F12> :let &mouse=(empty(&mouse) ? 'a' : '')<CR>
map('n', '<leader>ts', ":let &background=(&background == 'light' ? 'dark' : 'light')<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Telescope Maps
map('n', '<leader>c', ':Telescope command_center<CR>')
command_center_map(':Telescope find_files<CR>', 'Telescope (Fuzzy search files)', 'n', '<leader>g')
command_center_map(':Telescope live_grep<CR>', 'Telescope (Grep in files)', 'n', '<C-f>')

-- Packer Sync
command_center_map(':PackerSync<CR>', 'Packer (Sync)', 'n', '<C-p>')

-- Fterm (floating terminal)
command_center_map('<CMD>lua require("FTerm").toggle()<CR>', 'Open Terminal', 'n', '<leader>b')
map('t', '<Esc>', '<CMD>lua require("FTerm").toggle()<CR>')
map('t', '<Ctrl-d>', '<CMD>lua require("FTerm").toggle()<CR>')

-- NvimTree
command_center_map(':NvimTreeToggle<CR>', 'Toggle NvimTree', 'n', '<leader>e')
command_center_map(':NvimTreeRefresh<CR>', 'Refresh NvimTree', 'n', '<C-n>')
command_center_map(':NvimTreeFindFile<CR>', 'Find current file in NvimTree', 'n', '<C-t>')

-- Markdown
command_center_map(':MarkdownPreview<CR>', 'Preview Markdown (opens browser)', 'n', '<C-k>')

-- Lsp stuff like Format, Sort imports, etc...
command_center_map(':lua vim.lsp.buf.format()<CR>', 'Format Entire Document', nil, nil)
command_center_map(':noa w<CR>', 'Save without formatting', nil, nil)

-- Git diffview
command_center_map(':DiffviewOpen<CR>', 'Git Diff (Open)', 'n', '<C-g>')
command_center_map(':DiffviewClose<CR>', 'Git Diff (Close)', 'n', '<C-c>')

-- Spectre (aka Find and Replace)
command_center_map("<cmd>lua require('spectre').open()<CR>", 'Find and Replace in Workspace (Spectre)', 'n', '<C-j>')

M.register_zk_keymaps = function()
  -- Don't format on save when dealing with zettelkasten buffers
  map('n', '<leader>w', ':set eventignore+=BufWritePre | w | set eventignore-=BufWritePre<CR>')

  -- Preview a linked note.
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  -- Open the link under the caret.
  map('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>')

  -- Zellenkasten
  -- Override basic file fuzzy search for "Open Recent Notes"
  map('n', '<leader>g', '<Cmd>ZkRecents<CR>')
  -- Open notes.
  map('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>")
  -- Open notes associated with the selected tags.
  map('n', '<leader>zt', '<Cmd>ZkTags<CR>')
  -- Search for the notes matching a given query.
  map('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>")
  -- Search for the notes matching the current visual selection.
  map('v', '<leader>zf', ":'<,'>ZkMatch<CR>")
  -- Create a new note after asking for its title.
  map('n', '<leader>zn', ':lua require("tjl/extensions/my_zk").create_zettel_of_type("archive")<CR>')
  map('n', '<leader>zzn', ':lua require("tjl/extensions/my_zk").create_zettel()<CR>')
  -- Create a new note in the same directory as the current buffer, using the current selection for title.
  map('v', '<leader>znt', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>")
  -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
  map('v',
    '<leader>znc',
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>"
  )
  -- Open notes linking to the current buffer.
  map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>')
  -- Open notes linked by the current buffer.
  map('n', '<leader>zl', '<Cmd>ZkLinks<CR>')
  -- Open the code actions for a visual selection.
  map('v', '<leader>zc', ":'<,'>lua vim.lsp.buf.range_code_action()<CR>")
end

return M
