return {
  "goolord/alpha-nvim",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      -- dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("p", require("lazyvim.config").icons.kinds.Folder .. " Projects", ":Telescope projects<CR>"),
      dashboard.button("r", require("lazyvim.config").icons.kinds.File .. " Recent files", ":Telescope oldfiles <CR>"),
      -- dashboard.button("g", "" .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", require("lazyvim.config").icons.kinds.Unit .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button(
        "s",
        require("lazyvim.config").icons.kinds.Property .. " Restore Session",
        [[:lua require("persistence").load({last = true}) <cr>]]
      ),
      dashboard.button("l", require("lazyvim.config").icons.kinds.Event .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", require("lazyvim.config").icons.kinds.Class .. " Quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
}
