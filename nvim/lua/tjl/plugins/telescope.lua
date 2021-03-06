local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local command_center = require("command_center")

telescope.setup {
    extensions = {
        command_center = {
            components = {
                command_center.component.DESCRIPTION,
                command_center.component.KEYBINDINGS,
                command_center.component.COMMAND
            },
            auto_replace_desc_with_cmd = false
        }
    },
    defaults = {mappings = {i = {["<esc>"] = telescope_actions.close}}},
    pickers = {
        find_files = {
            hidden = true,
            file_ignore_patterns = {
                ".git/",
                ".cache",
                "%.o",
                "%.a",
                "%.out",
                "%.class",
                "build/",
                "install/",
                ".idea/",
                ".DS_Store"
            }
        }
    }
}

telescope.load_extension("command_center")
