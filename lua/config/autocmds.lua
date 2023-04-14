-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- close some filetypes with <q>
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float()
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_diff_with_q"),
  pattern = {
    "DiffviewFileHistory",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>DiffviewClose<cr>", { buffer = event.buf, silent = true })
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   group = augroup("format_xml"),
--   pattern = {
--     "xml",
--   },
--   callback = function(event)
--     vim.keymap.set("n", "<leader>xf", vim.cmd([[!xmllint --format --recover -]]), { buffer = event.buf, silent = true })
--   end,
-- })

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
