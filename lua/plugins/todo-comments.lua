return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  config = true,
  keys = {
    { "<leader>ct", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    { "<leader>cT", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
  },
}
