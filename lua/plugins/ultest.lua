return {
  "rcarriga/vim-ultest",
  cmd = { "Ultest", "UltestSummary", "UltestNearest" },
  dependencies = { "vim-test/vim-test" },
  keys = {
    { "<leader>tc", "<cmd>Ultest<cr>", desc = "Test Class" },
    { "<leader>tn", "<cmd>UltestNearest<cr>", desc = "Test Nearest Method" },
    { "<leader>ts", "<cmd>UltestSummary<cr>", desc = "Test Summary" },
  },
  build = ":UpdateRemotePlugins",
  lazy = true,
  event = { "BufEnter *_test.*,*_spec.*,*est_*.*" },
}
