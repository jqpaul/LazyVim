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
    "folke/lazy.nvim",
    keys = {
      { "<leader>l", false },
    },
  },
  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>xt", false }, -- "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", false }, --"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", false }, --"<cmd>TodoTelescope<cr>", desc = "Todo" },
    },
  },
  {
    "telescope.nvim",
    keys = {
      { "<leader>", false },
      { "<leader>,", false }, -- "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>:", false }, --  "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>/", false }, -- "<cmd>Telescope grep_string<cr>", desc = "Find in Files (Grep)" },
      { "<leader>fb", false }, --"<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", false }, --  Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", false }, --  Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", false }, --  "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>gc", false },
      { "<leader>sa", false }, --  "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>,", false }, -- "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sb", false }, --"<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
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
      { "<leader>ss", false },
      { "<leader>sS", false },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bp", false },
      { "<leader>bP", false },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = false,
    config = {
      on_attach = function(buffer)
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end
        map("n", "]h", "<nop>", "Next Hunk")
        map("n", "[h", "<nop>", "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", "<nop>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", "<nop>", "Reset Hunk")
        map("n", "<leader>ghS", "<nop>", "Stage Buffer")
        map("n", "<leader>ghu", "<nop>", "Undo Stage Hunk")
        map("n", "<leader>ghR", "<nop>", "Reset Buffer")
        map("n", "<leader>ghp", "<nop>", "Preview Hunk")
        map("n", "<leader>ghb", "<nop>", "Blame Line")
        map("n", "<leader>ghd", "<nop>", "Diff This")
        map("n", "<leader>ghD", "<nop>", "Diff This ~")
        map({ "o", "x" }, "ih", "<nop>", "GitSigns Select Hunk")
      end,
    },
  },
}
