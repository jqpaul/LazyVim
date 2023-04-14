return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      "dockerfile-language-server",
      "bash-language-server",
      -- "shellharden",
      "json-lsp",
      "jsonlint",
      -- "sqlls",
      -- "yamlfmt",
      -- "yamllint",
      -- "yaml-language-server",
    })
  end,
}
