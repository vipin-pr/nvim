return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = { enabled = false },
        pyright = { enabled = false },
        pylsp = {
          enabled = true,
        },
      },
    },
  },
}
