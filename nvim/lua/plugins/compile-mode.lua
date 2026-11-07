return {
  "ej-shafran/compile-mode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>C", "<cmd>Compile<CR>", desc = "Compile project" },
  },
  init = function()
    vim.g.compile_mode = {
      default_command = "",
      input_word_completion = true,
      bang_expansion = true,
    }

    -- Automatically map 'q' to delete the buffer completely when compile-mode opens
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "compilation",
      callback = function(event)
        vim.keymap.set("n", "q", function()
          -- 'bd!' forces the buffer to delete, removing it from your tabs
          vim.cmd("bd!")
        end, { buffer = event.buf, silent = true, desc = "Kill compilation buffer" })
      end,
    })
  end,
}