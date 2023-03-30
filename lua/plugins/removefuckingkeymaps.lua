return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", false },
      { "<leader>bD", false },
      { "<leader>l", false },
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>ct", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xt", false}, -- "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", false}, --"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", false}, --"<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },
}
