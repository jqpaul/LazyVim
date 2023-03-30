return {
  "folke/trouble.nvim",
  opts = { use_diagnostic_signs = true },
  keys = {
    { "<leader>cx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>cX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xx", false }, -- "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
    { "<leader>xX", false }, --"<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    { "<leader>xL", false }, -- "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", false }, -- "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    { "<leader>T", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
  },
}
