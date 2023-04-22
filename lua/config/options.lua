-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.termguicolors = true
opt.clipboard = "unnamedplus" -- Sync with system clipboard
-- opt.mouse = "" -- Enable mouse mode
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 7 -- Lines of context
opt.sidescrolloff = 10 -- Columns of context
opt.list = true
opt.background = "dark"
vim.lsp.set_log_level(0)
-- opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

-- vim.cmd("let g:gruvbox_material_background = 'hard'")
vim.cmd("let g:ultest_deprecation_notice = 0")
-- vim.opt.termguicolors = true
-- vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]])
-- vim.cmd([[hi def IlluminatedWordText gui=underline]])
