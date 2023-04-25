return {
  "nvim-neotest/neotest",
  enabled = true,
  config = function()
    require("neotest").setup({
      adapters = {
        require("user.neotest-java").setup({}),
      },
    })
  end,
}
