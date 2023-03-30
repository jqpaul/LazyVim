return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>E", false },
  },
  opts = {
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
    filesystem = {
      group_empty_dirs = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".DS_Store",
          "thumbs.db",
          "node_modules",
          "__pycache__",
        },
        never_show = {
          ".DS_Store",
        },
      },
      window = {
        mappings = {
          ["h"] = "navigate_up",
          ["l"] = "open",
        },
      },
      follow_current_file = true,
      bind_to_cwd = false,
    },
    git_status = {
      window = {
        position = "float",
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
  },
}
