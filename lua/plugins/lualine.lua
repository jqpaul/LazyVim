return {
  "nvim-lualine/lualine.nvim",
  --enabled = false,
  event = "VeryLazy",
  opts = function(plugin)
    local icons = require("lazyvim.config").icons

    local function fg(name)
      return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    local function search_result()
      if vim.v.hlsearch == 0 then
        return ""
      end
      local last_search = vim.fn.getreg("/")
      if not last_search or last_search == "" then
        return ""
      end
      local searchcount = vim.fn.searchcount({ maxcount = 9999 })
      return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
    end

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
      },
      sections = {
        lualine_a = {
          "bo:filetype",
        },
        --lualine_a = { "mode" },
        -- lualine_b = { "mode" },
        lualine_b = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          -- { "filename", path = 0, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          -- stylua: ignore
          -- {
          --   function() return require("nvim-navic").get_location() end,
          --   cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          -- },
        },
        lualine_c = {
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_x = {},
        -- lualine_y = {
        --   { "progress", separator = " ", padding = { left = 1, right = 0 } },
        --   { "location", padding = { left = 0, right = 1 } },
        -- },
        -- lualine_y = { search_result },
        -- lualine_x = {
        --   {
        --     function()
        --       return vim.api.nvim_buf_line_count(0) .. " "
        --     end,
        --     separator = " ",
        --     padding = { left = 1, right = 0 },
        --   },
        -- },
        lualine_y = {
          {
            "tabs",
            mode = 1,
          },
        },
        lualine_z = {
          function()
            return os.date("%T")
          end,
        },
      },
      extensions = { "neo-tree" },
    }
  end,
}
