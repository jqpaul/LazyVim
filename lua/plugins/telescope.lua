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
    { "<leader>", false },
    { "<leader>,", false }, -- "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    --{ "<leader>/", "<cmd>Telescope grep_string<cr>", desc = "Find in Files (Grep)" },
    { "<leader>:", false }, --  "<cmd>Telescope command_history<cr>", desc = "Command History" },
    --{ "<leader>fF", require("lazyvim.util").telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    --{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
    -- find
    { "<leader>fb", "<cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", desc = "refactoring" },
    { "<leader>ff", false }, --  Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>fF", false }, --  Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>fr", false }, --  "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    -- git
    { "<leader>gc", false }, --  "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", false }, --  "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { "<leader>sa", false }, --  "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", false }, --  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", false }, --  "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", false }, --  "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", false }, --  "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>sg", false }, --  Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leader>sG", false }, --  Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sh", false }, --  "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", false }, --  "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", false }, --  "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", false }, --  "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", false }, --  "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", false }, --  "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", false }, --  "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", false }, --  Util.telescope("grep_string"), desc = "Word (root dir)" },
    { "<leader>sW", false }, --  Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
    { "<leader>uC", false }, --  Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    -- {
    --   "<leader>ss",
    --   Util.telescope("lsp_document_symbols", {
    --     symbols = {
    --       "Class",
    --       "Function",
    --       "Method",
    --       "Constructor",
    --       "Interface",
    --       "Module",
    --       "Struct",
    --       "Trait",
    --       "Field",
    --       "Property",
    --     },
    --   }),
    --   desc = "Goto Symbol",
    -- },
    -- {
    --   "<leader>sS",
    --   Util.telescope("lsp_workspace_symbols", {
    --     symbols = {
    --       "Class",
    --       "Function",
    --       "Method",
    --       "Constructor",
    --       "Interface",
    --       "Module",
    --       "Struct",
    --       "Trait",
    --       "Field",
    --       "Property",
    --     },
    --   }),
    --   desc = "Goto Symbol (Workspace)",
    -- },
  },
}
