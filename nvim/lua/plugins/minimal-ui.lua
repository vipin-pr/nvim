return {
  -- Use Neovim's native command line instead of Noice's popup UI
  {
    "folke/noice.nvim",
    enabled = false,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        enabled = false,
      },
      explorer = {
        enabled = false,
        replace_netrw = false,
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
