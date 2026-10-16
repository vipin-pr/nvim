-- Minimal UI
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.ruler = false

-- Opaque popup backgrounds
vim.opt.pumblend = 0
vim.opt.winblend = 0

-- Command-line completion
vim.opt.wildmode = "longest:full,full"

-- Signs and line numbers
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true

-- Editing
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.hidden = true
vim.opt.confirm = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Navigation
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Code readability
vim.opt.showmatch = true

-- Disable diagnostics by default
vim.diagnostic.enable(false)