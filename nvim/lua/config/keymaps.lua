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


-- Temporary mark with visual highlight 
-- Alt+m: Save the current position with a red highlight.
-- Navigate elsewhere to copy, cut, or delete text.
-- Press Alt+m again to return to the saved position and clear the mark.
-- Press p to paste the copied or cut text.
local ns = vim.api.nvim_create_namespace("temporary_mark")

vim.api.nvim_set_hl(0, "TemporaryMark", {
    fg = "#ffffff",
    bg = "#cc3333",
    bold = true,
})

local active = false
local mark = "Z"
local mark_buf = nil
local highlight_id = nil

local function temporary_mark()
    if active then
        -- Return to the saved global mark
        local pos = vim.fn.getpos("'" .. mark)

        if pos[1] ~= 0 then
            vim.cmd("normal! `" .. mark)
        end

        -- Remove highlight
        if mark_buf and vim.api.nvim_buf_is_valid(mark_buf)
            and highlight_id then
            vim.api.nvim_buf_del_extmark(
                mark_buf, ns, highlight_id
            )
        end

        -- Delete temporary mark
        vim.cmd("delmarks " .. mark)

        active = false
        mark_buf = nil
        highlight_id = nil

        vim.api.nvim_echo({ { "Returned to saved position", "None" } }, false, {})
        return
    end

    -- Set global mark Z
    vim.cmd("normal! m" .. mark)

    mark_buf = vim.api.nvim_get_current_buf()

    -- Get cursor position
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1
    local col = pos[2]

    local line = vim.api.nvim_buf_get_lines(
        mark_buf, row, row + 1, false
    )[1] or ""

    -- Highlight character under cursor
    local opts

    if col < #line then
        opts = {
            end_row = row,
            end_col = col + 1,
            hl_group = "TemporaryMark",
        }
    else
        opts = {
            virt_text = { { "▏", "TemporaryMark" } },
            virt_text_pos = "overlay",
        }
    end

    highlight_id = vim.api.nvim_buf_set_extmark(
        mark_buf, ns, row, col, opts
    )

    active = true

    vim.api.nvim_echo({ { "Temporary mark Z set", "None" } }, false, {})
end

vim.keymap.set("n", "<M-m>", temporary_mark, {
    desc = "Set/return to temporary mark",
})

-- Execute shell command in a terminal buffer
vim.keymap.set("n", "<leader>S", function()
    local command = vim.fn.input("Shell command: ")

    if command == "" then
        return
    end

    vim.cmd("botright 15new")

    local buf = vim.api.nvim_get_current_buf()

    vim.fn.termopen(command, {
        on_exit = function()
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(buf) then
                    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>bwipeout!<CR>", {
                        noremap = true,
                        silent = true,
                    })

                    vim.api.nvim_set_current_buf(buf)
                    vim.cmd("stopinsert")
                end
            end)
        end,
    })

    vim.cmd("stopinsert")
end, { desc = "Execute shell command" })
