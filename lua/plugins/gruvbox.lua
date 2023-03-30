return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "catppuccin-frappe",
      --colorscheme = "catppuccin-latte",
      colorscheme = "gruvbox",
    },
  },
}
