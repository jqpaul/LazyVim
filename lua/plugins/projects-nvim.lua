return {
  "ahmedkhalf/project.nvim",
  dependencies = {
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope.nvim",
  },
  lazy = false,
  keys = {
    { "<leader>p", "<cmd>Telescope projects<cr>", desc = "Show Projects" },
  },
  config = function()
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",
        "pom.xml",
        "mvnw",
        "Makefile",
        "gradle.settings",
        ".svn",
      },
    })
    require("telescope").load_extension("projects")
  end,
}
