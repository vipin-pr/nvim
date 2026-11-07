return {
    -- Use Neovim's native command line instead of Noice's popup UI
    {
        "folke/noice.nvim",
        enabled = false,
    },

    {
        "folke/snacks.nvim",
        opts = {
            -- Disable the floating input popup to bring back the native command line
            input = {
                enabled = false,
            },
            dashboard = {
                enabled = true,
            },
            explorer = {
                enabled = false,
                replace_netrw = false,
            },
            -- Include hidden and ignored files in snacks picker results
            picker = {
                sources = {
                    files = {
                        hidden = true,
                        ignored = true,
                    },
                },
            },
        },
        keys = {
            { "<leader>e",  false },
            { "<leader>E",  false },
            { "<leader>fe", false },
            { "<leader>fE", false },
        },
    },

    -- Disable animated cursor and window transitions
    {
        "nvim-mini/mini.animate",
        enabled = false,
    },
}