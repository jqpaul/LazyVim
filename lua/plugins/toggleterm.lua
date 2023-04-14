return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = [[<c-\>]],
    direction = "float",
    autochdir = true,
    float_opts = {
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "White", -- if not try setting this to Pmenu or String and see what happens
      },
    },
  },
}
