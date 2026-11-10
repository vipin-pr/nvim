-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use jj to exit Insert mode
vim.keymap.set("i", "jj", "<Esc>", {
  desc = "Exit Insert mode",
})

-- Emacs-style transpose words: Alt+t
local function transpose_words()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local words = {}

  for start_pos, word, end_pos in line:gmatch("()([%w_]+)()") do
    table.insert(words, {
      start_pos = start_pos,
      end_pos = end_pos,
      word = word,
    })
  end

  local current
  for i, w in ipairs(words) do
    if col + 1 >= w.start_pos and col + 1 < w.end_pos then
      current = i
      break
    elseif w.start_pos > col + 1 then
      current = i
      break
    end
  end

  if not current or not words[current + 1] then
    return
  end

  local a, b = words[current], words[current + 1]
  local updated =
      line:sub(1, a.start_pos - 1)
      .. b.word
      .. line:sub(a.end_pos, b.start_pos - 1)
      .. a.word
      .. line:sub(b.end_pos)

  vim.api.nvim_set_current_line(updated)
  vim.api.nvim_win_set_cursor(0, { row, a.start_pos - 1 })
end

vim.keymap.set({ "n", "i" }, "<M-t>", function()
  if vim.fn.mode() == "i" then
    vim.cmd.stopinsert()
    transpose_words()
    vim.cmd.startinsert()
  else
    transpose_words()
  end
end, { desc = "Transpose words (Emacs Alt+t)" })

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", {
  desc = "Toggle Neo-tree",
})

-- Ctrl+Backspace - Delete word backward
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })

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
