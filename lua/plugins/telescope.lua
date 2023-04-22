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
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").load_extension("ui-select")
      end,
    },
  },
  keys = {
    { "<leader>cb", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "refactoring" },
    { "<leader>gC", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", require("lazyvim.util").telescope("git_status"), desc = "Git Status" },
    { "<leader>sb", false }, --"<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<C-b>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<C-a>", require("lazyvim.util").telescope("live_grep"), desc = "Find in Files (Grep)" },
    { "<C-f>", require("lazyvim.util").telescope("current_buffer_fuzzy_find"), desc = "Find in File (Fuzzy)" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        mappings = {
          i = { ["<c-t>"] = nil }, -- require("trouble.providers.telescope").open_with_trouble },
          n = { ["<c-t>"] = nil }, -- require("trouble.providers.telescope").open_with_trouble },
        },
        file_ignore_patterns = { "target/.*" },
      },
      pickers = {
        git_commits = {
          mappings = {
            i = {
              ["<cr>"] = function()
                -- Open in diffview
                local selected_entry = require("telescope.actions.state").get_selected_entry()
                local value = selected_entry.value
                -- close Telescope window properly prior to switching windows
                vim.api.nvim_win_close(0, true)
                vim.cmd("stopinsert")
                vim.schedule(function()
                  vim.cmd(("DiffviewOpen %s^!"):format(value))
                end)
              end,
            },
          },
        },
        current_buffer_fuzzy_find = {
          layout_strategy = "vertical",
        },
        live_grep = {
          layout_strategy = "vertical",
        },
        find_files = {
          previewer = false,
        },
        buffers = {
          previewer = false,
        },
        git_files = {
          previewer = false,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
      },
    })
  end,
}
