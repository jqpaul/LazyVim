local M = {}

M.config = function()
  local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Neovim attach",
      host = function()
        local value = vim.fn.input("Host [127.0.0.1]: ")
        if value ~= "" then
          return value
        end
        return "127.0.0.1"
      end,
      port = function()
        local val = tonumber(vim.fn.input("Port: "))
        assert(val, "Please provide a port number")
        return val
      end,
    },
  }
  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end

  -- NOTE: if you want to use `dap` instead of `RustDebuggables` you can use the following configuration
  if vim.fn.executable("lldb-vscode") == 1 then
    dap.adapters.lldbrust = {
      type = "executable",
      attach = { pidProperty = "pid", pidSelect = "ask" },
      command = "lldb-vscode",
      env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
    }
  end

  local firefox_path = mason_path .. "packages/firefox-debug-adapter/"

  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      firefox_path .. "dist/adapter.bundle.js",
    },
  }

  local firefoxExecutable = "/usr/bin/firefox"
  if vim.fn.has("mac") == 1 then
    firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox"
  end
  local custom_adapter = "pwa-node-custom"
  dap.adapters[custom_adapter] = function(cb, config)
    if config.preLaunchTask then
      local async = require("plenary.async")
      local notify = require("notify").async

      async.run(function()
        ---@diagnostic disable-next-line: missing-parameter
        notify("Running [" .. config.preLaunchTask .. "]").events.close()
      end, function()
        vim.fn.system(config.preLaunchTask)
        config.type = "pwa-node"
        dap.run(config)
      end)
    end
  end

  --Java debugger adapter settings
  dap.configurations.java = {
    {
      name = "Debug (Attach) - Remote",
      type = "java",
      request = "attach",
      hostName = "127.0.0.1",
      port = 8000,
    },
    {
      name = "Debug Non-Project class",
      type = "java",
      request = "launch",
      program = "${file}",
    },
  }

  local path = vim.fn.glob(mason_path .. "packages/codelldb/extension/")
    or vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
  local lldb_cmd = path .. "adapter/codelldb"

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- CHANGE THIS to your path!
      command = lldb_cmd,
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
    },
  }
  dap.configurations.c = dap.configurations.cpp

  dap.configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run or Test Target",
      metals = {
        runType = "runOrTestFile",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
  }
  dap.configurations.python = dap.configurations.python or {}
  table.insert(dap.configurations.python, {
    type = "python",
    request = "launch",
    name = "launch with options",
    program = "${file}",
    python = function() end,
    pythonPath = function()
      local path
      for _, server in pairs(vim.lsp.buf_get_clients()) do
        if server.name == "pyright" or server.name == "pylance" then
          path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
          break
        end
      end
      path = vim.fn.input("Python path: ", path or "", "file")
      return path ~= "" and vim.fn.expand(path) or nil
    end,
    args = function()
      local args = {}
      local i = 1
      while true do
        local arg = vim.fn.input("Argument [" .. i .. "]: ")
        if arg == "" then
          break
        end
        args[i] = arg
        i = i + 1
      end
      return args
    end,
    justMyCode = function()
      local yn = vim.fn.input("justMyCode? [y/n]: ")
      if yn == "y" then
        return true
      end
      return false
    end,
    stopOnEntry = function()
      local yn = vim.fn.input("stopOnEntry? [y/n]: ")
      if yn == "y" then
        return true
      end
      return false
    end,
    console = "integratedTerminal",
  })
end

M.define_dap_signs = function()
  vim.fn.sign_define(
    "DapBreakpoint",
    { text = ">", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
  )
  vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
end

return M
