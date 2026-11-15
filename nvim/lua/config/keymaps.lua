-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use jj to exit Insert mode
vim.keymap.set("i", "jj", "<Esc>", {
  desc = "Exit Insert mode",
})

-- Ctrl+Backspace - Delete word backward
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", {
  desc = "Toggle Neo-tree",
})

vim.keymap.set("n", "<leader>E", function()
  vim.cmd("Neotree position=current toggle")
end, { desc = "Toggle full-window file explorer" })

vim.keymap.set("n", "<leader>ld", function()
  require("trouble").toggle({
    mode = "diagnostics",
    win = {
      type = "split",
      position = "bottom",
      size = 10,
    },
  })
end, { desc = "Diagnostics (Trouble)" })

-- Toggle terminal
vim.keymap.set({ "n", "t" }, "<C-t>", function()
  Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {
  desc = "Terminal Normal Mode",
})

-- Interactive Change/Undo History Picker
vim.keymap.set("n", "<leader>h", function()
  Snacks.picker.undo({
    focus = "list",
    enter = true,
  })
end, { desc = "Change History" })

-- Marks Menu
vim.keymap.set("n", "<leader>m", "", { desc = "Marks" })

-- Jump to Mark - gm<mark>
vim.keymap.set("n", "gm", function()
  local mark = vim.fn.getcharstr()
  if mark == "" then
    return
  end
  vim.cmd("normal! `" .. mark)
end, { desc = "Jump to Mark" })

-- list marks
vim.keymap.set("n", "<leader>mm", function()
  Snacks.picker.marks()
end, { desc = "Browse Marks" })

-- Delete Mark - <leader>md<mark>
vim.keymap.set("n", "<leader>md", function()
  local mark = vim.fn.getcharstr()

  if mark == "" then
    return
  end

  local success

  if mark:match("^[a-z]$") then
    success = vim.api.nvim_buf_del_mark(0, mark)
  elseif mark:match("^[A-Z0-9]$") then
    success = vim.api.nvim_del_mark(mark)
  else
    vim.notify("Invalid mark: " .. mark, vim.log.levels.WARN)
    return
  end

  if success then
    vim.notify("Deleted mark: " .. mark, vim.log.levels.INFO)
  else
    vim.notify("Mark not found: " .. mark, vim.log.levels.WARN)
  end
end, { desc = "Delete Mark" })

vim.keymap.set("n", "<leader>mD", function()
  vim.cmd("delmarks!")
  vim.notify("All marks deleted", vim.log.levels.INFO)
end, { desc = "Delete All Marks" })
