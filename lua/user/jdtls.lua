local M = {}

local path = require("jdtls.path")
local uv = vim.loop
local api = vim.api

function M.find_root(markers, bufname)
  bufname = bufname or api.nvim_buf_get_name(api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ":p:h")
  local getparent = function(p)
    return vim.fn.fnamemodify(p, ":h")
  end
  while getparent(dirname) ~= dirname do
    for _, marker in ipairs(markers) do
      if uv.fs_stat(path.join(dirname, marker)) then
        return dirname
      end
    end
    dirname = getparent(dirname)
  end
end

function M.find_root4()
  return vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1])
end

local getparent = function(p)
  return vim.fn.fnamemodify(p, ":h")
end

local function checkparent(dirname, markers)
  local test = false
  for _, marker2 in ipairs(markers) do
    if uv.fs_stat(path.join(getparent(dirname), marker2)) then
      test = true
    end
  end
  return test
end

function M.find_root3(markers, bufname)
  bufname = bufname or api.nvim_buf_get_name(api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ":p:h")
  while getparent(dirname) ~= dirname do
    for _, marker in ipairs(markers) do
      if uv.fs_stat(path.join(dirname, marker)) then
        if not checkparent(dirname, markers) then
          return dirname
        end
      end
    end
    dirname = getparent(dirname)
  end
end

return M
