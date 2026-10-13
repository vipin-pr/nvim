return {
    "blazkowolf/gruber-darker.nvim",
    priority = 1000,
    opts = {
        italic = {
            strings = false,
            comments = false,
            operators = false,
            folds = false,
        },
    },
    config = function(_, opts)
        require("gruber-darker").setup(opts)
        vim.cmd.colorscheme("gruber-darker")

        local fg = "#D1C7C5"

        -- Default text and variables
        vim.api.nvim_set_hl(0, "Normal", { fg = fg })
        vim.api.nvim_set_hl(0, "NormalFloat", { fg = fg })
        vim.api.nvim_set_hl(0, "Identifier", { fg = fg })
        vim.api.nvim_set_hl(0, "@variable", { fg = fg })
        vim.api.nvim_set_hl(0, "@variable.builtin", { fg = fg })
        vim.api.nvim_set_hl(0, "@variable.parameter", { fg = fg })
        vim.api.nvim_set_hl(0, "@variable.member", { fg = fg })

        -- Brackets, parentheses, and punctuation
        vim.api.nvim_set_hl(0, "Delimiter", { fg = fg })
        vim.api.nvim_set_hl(0, "Operator", { fg = fg })
        vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = fg })
        vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = fg })
        vim.api.nvim_set_hl(0, "@punctuation.special", { fg = fg })
        vim.api.nvim_set_hl(0, "@operator", { fg = fg })

        -- Numbers
        vim.api.nvim_set_hl(0, "Number", { fg = fg })
        vim.api.nvim_set_hl(0, "Float", { fg = fg })
        vim.api.nvim_set_hl(0, "@number", { fg = fg })
        vim.api.nvim_set_hl(0, "@number.float", { fg = fg })

        -- Environment variables
        vim.api.nvim_set_hl(0, "@variable.environment", {
            fg = "#D1C7C5",
            bold = true,
        })
        vim.api.nvim_set_hl(0, "Constant", {
            fg = "#D1C7C5",
            bold = true,
        })

        -- YAML keys
        vim.api.nvim_set_hl(0, "@property.yaml", { fg = fg })
        vim.api.nvim_set_hl(0, "@field.yaml", { fg = fg })
        vim.api.nvim_set_hl(0, "yamlKey", { fg = fg })
        vim.api.nvim_set_hl(0, "yamlBlockMappingKey", { fg = fg })
    end,
}
