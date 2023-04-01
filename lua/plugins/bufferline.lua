return {
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  enabled = true,
  keys = {
    { "<leader>bp", false },
    { "<leader>bP", false },
  },
  setup = function()
    require("bufferline").setup({
      highlights = {
        indicator_selected = {
          guifg = {
            attribute = "fg",
            highlight = "Type",
          },
          guibg = {
            attribute = "bg",
            highlight = "Type",
          },
        },
        buffer_selected = {
          gui = "NONE",
        },
        pick_selected = {
          gui = "NONE",
        },
      },
    })
  end,
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      separator_style = "slant",
      --mode = "tabs",
      themable = true,
      indicator = {
        icon = "▎",
        style = "icon",
      },
      color_icons = true,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
