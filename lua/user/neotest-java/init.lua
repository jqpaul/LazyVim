local lib = require("neotest.lib")
local async = require("neotest.async")

---@type neotest.Adapter
local JavaNeotestAdapter = { name = "neotest-java" }

JavaNeotestAdapter.root = lib.files.match_root_pattern("pom.xml", "settings.gradle")

-- JavaNeotestAdapter.root = lib.files.match_root_pattern("pom.xml")

function JavaNeotestAdapter.filter_dir(name)
  -- return false
  return name ~= "target"
end

function JavaNeotestAdapter.is_test_file(file_path)
  return vim.endswith(file_path, "Test.java")
end

---@async
---@return neotest.Tree | nil
function JavaNeotestAdapter.discover_positions(file_path)
  local query = [[
  ;; Methods with @Test annotation 
  ((method_declaration
      (modifiers
        (marker_annotation
          name: (identifier) @annotation
          (#match? @annotation "^Test")))
    name: (identifier) @test.definition))
  @test.definition
  ]]
  local trees = lib.treesitter.parse_positions(file_path, query, { nested_tests = true })
  return trees
end

---@async
---@param args neotest.RunArgs
---@return neotest.RunSpec
function JavaNeotestAdapter.build_spec(args)
  local tree = args.tree
  local extra_args = args.extra_args
  local strategy = args.strategy
  local pos = tree:data()
  local class = "TransactionTest"
  local test = "testTransaction"
  local command = vim.tbl_flatten({
    "mvn",
    "test",
    "-Dtest=" .. class .. "#" .. test,
  })
  local result = async.fn.tempname()
  return {
    command = command,
    context = {
      results_path = result,
      file = "",
    },
  }
end

---@async
---@param spec neotest.RunSpec
---@param result neotest.StrategyResult
---@return neotest.Result[]
function JavaNeotestAdapter.results(spec, result, tree)
  local tests = {}
  tests["first"] = {
    status = "passed",
    short = "guter ttest",
    output = "System.out.println('')",
    location = "/home/joe/Documents/",
  }
  return tests
end

setmetatable(JavaNeotestAdapter, {
  __call = function()
    return JavaNeotestAdapter
  end,
})

JavaNeotestAdapter.setup = function(opts)
  opts = opts or {}
  return JavaNeotestAdapter
end

return JavaNeotestAdapter
