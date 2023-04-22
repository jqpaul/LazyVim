return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "dockerfile-language-server",
        "bash-language-server",
        -- "shellharden",
        "json-lsp",
        "jsonlint",
        "typescript-language-server",
        "js-debug-adapter",
        -- "eslint",
        -- "html",
        -- "cssls",
        -- "sqlls",
        -- "yamlfmt",
        -- "yamllint",
        -- "yaml-language-server",
      })
    end,
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function()
  --     require("mason-lspconfig").setup({
  --       ensure_installed = { "tsserver" },
  --     })
  --   end,
  -- },
}
