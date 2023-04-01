return {
  "telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "ThePrimeagen/refactoring.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("refactoring")
      end,
    },
  },
  keys = {
    { "<leader>cb", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "refactoring" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", require("lazyvim.util").telescope("git_status"), desc = "Git Status" },
    { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<C-a>", require("lazyvim.util").telescope("live_grep"), desc = "Find in Files (Grep)" },
  },
  setup = function()
    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
    })
  end,
}
