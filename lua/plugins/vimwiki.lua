return {
  "vimwiki/vimwiki",
  keys = {
    {
      "<F2>",
      "<cmd>Telescope find_files search_dirs=/Drive/Docs_unencrypted/VimMd<cr>",
      desc = "Open Vimwiki Index",
    },
    {
      "<leader>wt",
      "<cmd>VimwikiTable 2<cr>",
      desc = "Create new Table",
    },
  },
  config = function()
    vim.g.vimwiki_list = {
      {
        path = "/Drive/Docs_unencrypted/VimMd",
        syntax = "markdown",
        ext = ".md",
      },
    }
    vim.g.vimwiki_ext2syntax = {
      [".md"] = "markdown",
      [".markdown"] = "markdown",
      [".mdown"] = "markdown",
    }
  end,
}
