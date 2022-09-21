require("spectre").setup(
    {
        mapping = {
            ["send_to_qf"] = {
                map = "<leader>s",
                cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                desc = "send all item to quickfix"
            }
        }
    }
)
