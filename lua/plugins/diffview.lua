return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  lazy = true,
  keys = {
    { "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", desc = "Git History (File)" },
    { "<leader>gD", "<cmd>DiffviewFileHistory<cr>", desc = "Git History" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diff" },
  },
}
