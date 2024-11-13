return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = function()
            return {
                { "<c-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
                {
                    "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files",
                }
            }
        end,
        config = function()
            require("telescope").setup()
            require("telescope").load_extension("ui-select")
        end,
    },
}
