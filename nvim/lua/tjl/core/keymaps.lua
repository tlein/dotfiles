local command_center = require("command_center")

-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
    local options = { noremap = false, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function command_center_map(command_cmd, command_desc, shortcut_mode, shortcut_keybind)
    if shortcut_mode then
        command_center.add(
            {
                {
                    description = command_desc,
                    cmd = command_cmd,
                    keybindings = { { shortcut_mode, shortcut_keybind, { noremap = true } } }
                }
            }
        )
    else
        command_center.add(
            {
                {
                    description = command_desc,
                    cmd = command_cmd
                }
            }
        )
    end
end

-- Change leader to a semi-colon
vim.g.mapleader = ";"

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")

-- Remap Esc
map("i", "jk", "<Esc>")

-- Clear search highlighting
map("n", "<leader>v", ":nohl<CR>")

-- Create splits
map("n", "<leader>s", ":vsplit<CR>")
map("n", "<leader>S", ":split<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

-- Reload configuration without restart nvim
map("n", "<leader>r", ":Restart<CR>")

-- Fast saving with <leader> and s
map("n", "<leader>w", ":w<CR>")

-- Close all windows and exit from Neovim with <leader> and q
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>aq", ":q<CR>")
map("n", "<leader>aaq", ":qa!<CR>")

-- :nnoremap <F12> :let &mouse=(empty(&mouse) ? 'a' : '')<CR>
map("n", "<leader>ts", ":let &background=(&background == 'light' ? 'dark' : 'light')<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Telescope Maps
map("n", "<leader>c", ":Telescope command_center<CR>")
command_center_map(":Telescope find_files<CR>", "Telescope (Fuzzy search files)", "n", "<leader>g")
command_center_map(":Telescope live_grep<CR>", "Telescope (Grep in files)", "n", "<C-f>")

-- Packer Sync
command_center_map(":PackerSync<CR>", "Packer (Sync)", "n", "<C-p>")

-- Fterm (floating terminal)
command_center_map('<CMD>lua require("FTerm").toggle()<CR>', "Open Terminal", "n", "<leader>b")
map("t", "<Esc>", '<CMD>lua require("FTerm").toggle()<CR>')
map("t", "<Ctrl-d>", '<CMD>lua require("FTerm").toggle()<CR>')

-- NvimTree
command_center_map(":NvimTreeToggle<CR>", "Toggle NvimTree", "n", "<leader>e")
command_center_map(":NvimTreeRefresh<CR>", "Refresh NvimTree", "n", "<C-n>")
command_center_map(":NvimTreeFindFile<CR>", "Find current file in NvimTree", "n", "<C-t>")

-- Markdown
command_center_map("<Plug>MarkdownPreview", "Preview Markdown (opens browser)", "n", "<C-k>")

-- Coc Stuff like Format, Sort imports, etc...
command_center_map(":call CocAction('format')<CR>", "Format Entire Document", nil, nil)
command_center_map(":call CocActionAsync('runCommand', 'editor.action.organizeImport')<CR>", "Sort imports/includes", nil
    , nil)
command_center_map(":noa w<CR>", "Save without formatting", nil, nil)

-- Git diffview
command_center_map(":DiffviewOpen<CR>", "Git Diff (Open)", "n", "<C-g>")
command_center_map(":DiffviewClose<CR>", "Git Diff (Close)", "n", "<C-c>")

-- Spectre (aka Find and Replace)
command_center_map("<cmd>lua require('spectre').open()<CR>", "Find and Replace in Workspace (Spectre)", "n", "<C-j>")

-- Zellenkasten
-- Open notes.
map("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
map("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)
-- Search for the notes matching a given query.
map("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
-- Search for the notes matching the current visual selection.
map("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
-- Create a new note after asking for its title.
-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
map("n", "<leader>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for title.
map("v", "<leader>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
map("v", "<leader>znc",
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
-- Open notes linking to the current buffer.
map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)
-- Open notes linked by the current buffer.
map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)
-- Open the code actions for a visual selection.
map("v", "<leader>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
