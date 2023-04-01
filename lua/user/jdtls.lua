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

function M.find_root3(markers, bufname)
  bufname = bufname or api.nvim_buf_get_name(api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ":p:h")
  local getparent = function(p)
    return vim.fn.fnamemodify(p, ":h")
  end
  while getparent(dirname) ~= dirname do
    for _, marker in ipairs(markers) do
      if uv.fs_stat(path.join(dirname, marker)) then
        -- return dirname
        for _, marker2 in ipairs(markers) do
          if not uv.fs_stat(path.join(getparent(dirname), marker2)) then
            return dirname
          else
            return dirname
          end
        end
        return dirname
      end
    end
    dirname = getparent(dirname)
  end
end

return M
