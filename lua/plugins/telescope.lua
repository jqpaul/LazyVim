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
    {

      "ThePrimeagen/harpoon",
      config = function()
        require("telescope").load_extension("harpoon")
      end,
    },
  },
  keys = {
    { "<leader>cb", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "refactoring" },
    { "<leader>gC", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", require("lazyvim.util").telescope("git_status"), desc = "Git Status" },
    { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<C-a>", require("lazyvim.util").telescope("live_grep"), desc = "Find in Files (Grep)" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = { ["<c-t>"] = nil }, -- require("trouble.providers.telescope").open_with_trouble },
          n = { ["<c-t>"] = nil }, -- require("trouble.providers.telescope").open_with_trouble },
        },
      },
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
