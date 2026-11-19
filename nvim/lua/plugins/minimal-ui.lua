
return {
    -- Use Neovim's native command line instead of Noice's popup UI
    {
        "folke/noice.nvim",
        enabled = false,
    },

    {
        "folke/snacks.nvim",
        opts = {
            -- Disable the floating input popup
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

            -- Snacks picker configuration
            picker = {
                layout = function(source)
                    if source == "files" then
                        return "ivy"
                    end

                    return {
                        preset = "ivy",
                        hidden = { "preview" },
                        layout = {
                            width = 0.75,
                            height = 0.5,
                            position = "bottom",
                        },
                    }
                end,

                sources = {
                    files = {
                        hidden = true,
                        ignored = true,
                    },
                },
            },
        },

        keys = {
            { "<leader>e", false },
            { "<leader>E", false },
            { "<leader>fe", false },
            { "<leader>fE", false },

            -- Emacs M-x style command launcher
            {
                "<leader>p",
                function()
                    Snacks.picker()
                end,
                desc = "Command Launcher",
            },
        },
    },

    -- Disable animated cursor and window transitions
    {
        "nvim-mini/mini.animate",
        enabled = false,
    },
}
