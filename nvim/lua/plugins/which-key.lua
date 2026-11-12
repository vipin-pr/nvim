return {
  {
    "folke/which-key.nvim",
    opts = {
      preset = "classic",

      win = {
        no_overlap = false,

        height = {
          min = 10,
          max = 20,
        },

        padding = { 1, 2 },
        border = "rounded",
        title = true,
        title_pos = "center",
      },

      layout = {
        width = {
          min = 25,
        },
        spacing = 3,
      },
    },
  },
}