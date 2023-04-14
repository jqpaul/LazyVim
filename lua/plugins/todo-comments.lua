return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  config = true,
  keys = {
    { "<leader>ct", "<cmd>TodoQuickFix<cr>", desc = "Todo (Quickfix)" },
  },
}
