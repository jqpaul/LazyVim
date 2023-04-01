return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "Tabs" },
        --["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "Code" },
        ["<leader>d"] = { name = "Debug" },
        ["<leader>f"] = { name = "File/find" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>gh"] = { name = "Hunks" },
        ["<leader>j"] = { name = "Java" },
        ["<leader>q"] = { name = "session" },
        --["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "Test" },
        --["<leader>u"] = { name = "+ui" },
        --["<leader>w"] = { name = "+windows" },
        --["<leader>x"] = { name = "+diagnostics/quickfix" },
      }
      wk.register(keymaps)
    end,
  },
}
