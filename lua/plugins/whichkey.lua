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
        ["g"] = { name = "goto" },
        ["gz"] = { name = "surround" },
        ["<leader>jj"] = { name = "Jdt ls commands" },
        ["<leader>js"] = { name = "Telescope commands" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "Tabs" },
        ["<leader>c"] = { name = "Code" },
        ["<leader>d"] = { name = "Debug" },
        ["<leader>f"] = { name = "File/find" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>j"] = { name = "Java" },
        ["<leader>q"] = { name = "Session" },
        ["<leader>t"] = { name = "Test" },
        ["<leader>w"] = { name = "Vimwiki" },
      }
      wk.register(keymaps)
    end,
  },
}
