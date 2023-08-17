return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "rcarriga/cmp-dap" },
    { "lukas-reineke/cmp-rg" },
  },
  version = false, -- last release is way too old
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  end,
  event = "InsertEnter",
  config = {
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    -- snippet = {
    --   expand = function(args)
    --     require("luasnip").lsp_expand(args.body)
    --   end,
    -- },
    mapping = require("cmp").mapping.preset.insert({
      ["<C-n>"] = require("cmp").mapping.select_next_item({ behavior = require("cmp").SelectBehavior.Insert }),
      ["<C-p>"] = require("cmp").mapping.select_prev_item({ behavior = require("cmp").SelectBehavior.Insert }),
      ["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
      ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
      ["<C-Space>"] = require("cmp").mapping.complete(),
      ["<C-e>"] = require("cmp").mapping.abort(),
      ["<CR>"] = require("cmp").mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-CR>"] = require("cmp").mapping.confirm({
        behavior = require("cmp").ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = require("cmp").config.sources({
      { name = "nvim_lsp" },
      { name = "crates" },
      -- { name = "buffer" },
      { name = "path" },
      { name = "dap" },
      { name = "rg" },
      -- { name = "luasnip" },
    }),
    filetype = {
      "dap-repl",
      "dapui_watches",
      "dapui_hover",
    },
    formatting = {
      format = function(_, item)
        local icons = require("lazyvim.config").icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  },
}
