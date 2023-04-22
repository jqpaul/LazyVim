return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  lazy = false,
  keys = {
    { "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", desc = "Git History (File)" },
    { "<leader>gl", "<cmd>DiffviewOpen<cr>", desc = "Local Git Diff" },
    { "<leader>gD", "<cmd>DiffviewFileHistory<cr>", desc = "Git History" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Diff" },
  },
  opts = {
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff4_mixed",
      disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
      winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
    },
    file_history = {
      -- Config for changed files in file history views.
      -- layout = "diff4_mixed", -- Nonesense
      winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
    },
  },
}
