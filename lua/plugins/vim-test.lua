return {
  "vim-test/vim-test",
  cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
  config = function()
    require("user.vim_test").config()
  end,
}
