local command_center = require("command_center")

-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function command_center_map(command_cmd, command_desc, shortcut_mode, shortcut_keybind)
    local options = {noremap = true}
    command_center.add(
        {
            {
                description = command_desc,
                cmd = command_cmd,
                keybindings = {{shortcut_mode, shortcut_keybind, {noremap = true}}}
            }
        }
    )
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

-- Map Esc to jk
map("i", "jk", "<Esc>")

-- Clear search highlighting with <leader> and c
map("n", "<leader>v", ":nohl<CR>")

-- Create splits
map("n", "<leader>s", ":vsplit<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>")

-- Fast saving with <leader> and s
map("n", "<leader>w", ":w<CR>")

-- Close all windows and exit from Neovim with <leader> and q
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>aq", ":q<CR>")
map("n", "<leader>aaq", ":qa<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Telescope Maps
map("n", "<leader>g", ":Telescope find_files<CR>")
map("n", "<leader>c", ":Telescope command_center<CR>")

-- Packer Sync
command_center_map(":PackerSync<CR>", "Packer (Sync)", "n", "<C-p>")

-- Fterm (floating terminal)
command_center_map('<CMD>lua require("FTerm").toggle()<CR>', "Open Terminal", "n", "<leader>b")
map("t", "<Esc>", '<CMD>lua require("FTerm").toggle()<CR>')
map("t", "<Ctrl-d>", '<CMD>lua require("FTerm").toggle()<CR>')

-- NvimTree
command_center_map(":NvimTreeToggle<CR>", "Toggle NvimTree", "n", "<leader>e")
command_center_map(":NvimTreeRefresh<CR>", "Refresh NvimTree", "n", "<C-n>")
command_center_map(":NvimTreeFindFile<CR>", "Find current file in NvimTree", "n", "<C-f>")

-- Markdown
command_center_map("<Plug>MarkdownPreview", "Preview Markdown (opens browser)", "n", "<C-k>")

-- Neoformat
command_center_map(":Neoformat<CR>", "Neoformat Entire Document")
