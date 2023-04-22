return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "java" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "jdtls",
        "java-test",
        "java-debug-adapter",
        "lemminx",
        "gradle-language-server",
      })
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    lazy = false,
    config = function()
      require("lsp-inlayhints").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    keys = {
      { "<leader>jo", "<Cmd>lua require('jdtls').organize_imports()<CR>", desc = "Organize Imports" },
      { "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", desc = "Extract Variable" },
      { "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>", desc = "Extract Constant" },
      { "<leader>jt", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", desc = "Test Method" },
      { "<leader>jT", "<Cmd>lua require('jdtls').test_class()<CR>", desc = "Test Class" },
      { "<leader>jjb", "<Cmd>JdtBytecode<CR>", desc = "Show Bytecode" },
      { "<leader>jjc", "<Cmd>JdtCompile full<CR>", desc = "Compile all" },
      { "<leader>jjl", "<Cmd>JdtShowLogs<CR>", desc = "Show Logs" },
      { "<leader>jjr", "<Cmd>JdtWipeDataAndRestart<CR>", desc = "Restart fresh" },
      { "<leader>jjR", "<Cmd>JdtSetRuntime<CR>", desc = "Set Runtime Version" },
      { "<leader>jju", "<Cmd>JdtUpdateConfig<CR>", desc = "Update Config" },
      { "<leader>jr", "<Cmd>lua vim.lsp.buf.references()<CR>", desc = "Show References" },
      { "<leader>ji", "<Cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Show Implementation" },
      { "<leader>jd", "<Cmd>lua vim.lsp.buf.definition()<CR>", desc = "Show Definition" },
      { "<leader>jR", "<Cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
      { "<leader>jsr", "<Cmd>Telescope lsp_references<CR>", desc = "Show Telescope References" },
      { "<leader>jsi", "<Cmd>Telescope lsp_implementations<CR>", desc = "Show Telescope Implementation" },
      { "<leader>jsd", "<cmd>Telescope lsp_definitions<cr>", desc = "Show Telescope Definition" },
    },
    opts = {
      -- configure jdtls and attach to Java ft
      setup = {
        jdtls = function(_, opts)
          -- Determine OS
          local home = vim.env.HOME
          if vim.fn.has("mac") == 1 then
            WORKSPACE_PATH = home .. "/workspace/"
            CONFIG = "mac"
          elseif vim.fn.has("unix") == 1 then
            WORKSPACE_PATH = home .. "/workspace/"
            CONFIG = "linux"
          else
            print("Unsupported system")
          end

          local mason_registry = require("mason-registry")
          local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason")
          local launcher_path = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

          local java_test_pkg = mason_registry.get_package("java-test")
          local java_test_path = java_test_pkg:get_install_path()

          local java_dbg_pkg = mason_registry.get_package("java-debug-adapter")
          local java_dbg_path = java_dbg_pkg:get_install_path()

          local jar_patterns = {
            java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
            java_dbg_path .. "/.vscode-java-test/server/*.jar",
            java_test_path .. "/extension/server/*.jar",
            -- "/home/joe/.config/nvim/org.eclipse.buildship.core_3.1.6.v20220511-1359.jar",
          }

          local bundles = {}
          for _, jar_pattern in ipairs(jar_patterns) do
            for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
              table.insert(bundles, bundle)
            end
          end
          local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
          extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
          local function print_test_results(items)
            if #items > 0 then
              vim.cmd([[Trouble quickfix]])
            else
              vim.cmd([[TroubleClose quickfix]])
            end
          end

          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              -- Set correct sizing
              vim.opt_local.shiftwidth = 4
              vim.opt_local.tabstop = 4
              vim.opt_local.cmdheight = 2 -- more space in the neovim command line for displaying messages
              vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
              vim.bo.softtabstop = 4 -- number of spaces a <Tab> counts for. When 0, feature is off (sts).

              --Find root of project
              local root_markers =
                { ".git", "mvnw", "mvnw.bat", "gradlew", "pom.xml", "build.gradle", "gradle.settings" }
              --local root_dir = require("jdtls.setup").find_root(root_markers)
              local root_dir = require("user.jdtls").find_root(root_markers)
              if root_dir == "" then
                return
              end
              local jdtls = require("jdtls")
              local jdtls_config = vim.tbl_deep_extend("force", opts, {
                on_attach = function(client, buffer)
                  -- require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
                  require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
                  local _, _ = pcall(vim.lsp.codelens.refresh)
                  -- custom keymaps
                  vim.keymap.set("n", "<leader>jq", function()
                    require("jdtls").pick_test({ bufnr = buffer, after_test = print_test_results })
                  end, { buffer = buffer, desc = "Run Test" })
                  require("jdtls").setup_dap({ hotcodereplace = "auto" })
                  require("jdtls.dap").setup_dap_main_class_configs()
                  require("jdtls.setup").add_commands()
                end,
                cmd = {
                  "java",
                  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                  "-Dosgi.bundles.defaultStartLevel=4",
                  "-Declipse.product=org.eclipse.jdt.ls.core.product",
                  "-Dlog.protocol=true",
                  "-Dlog.level=ALL",
                  "-javaagent:" .. mason_path .. "/packages/jdtls/lombok.jar",
                  "-Xms8G",
                  "-Xmx8G",
                  "--add-modules=ALL-SYSTEM",
                  "--add-opens",
                  "java.base/java.util=ALL-UNNAMED",
                  "--add-opens",
                  "java.base/java.lang=ALL-UNNAMED",
                  "-jar",
                  launcher_path,
                  "-configuration",
                  mason_path .. "/packages/jdtls/config_" .. CONFIG,
                  "-data",
                  WORKSPACE_PATH,
                },
                root_dir = root_dir,
                settings = {
                  java = {
                    jdt = {
                      ls = {
                        vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx8G -Xms8G",
                      },
                    },
                    eclipse = {
                      downloadSources = true,
                    },
                    trace = {
                      server = "verbose",
                    },
                    configuration = {
                      updateBuildConfiguration = "automatic",
                      runtimes = {
                        {
                          name = "JavaSE-1.8",
                          path = "/usr/lib/jvm/java-8-openjdk/",
                        },
                        {
                          name = "JavaSE-11",
                          path = "/usr/lib/jvm/java-11-openjdk/",
                        },
                        {
                          name = "JavaSE-17",
                          path = "/usr/lib/jvm/java-17-openjdk/",
                          default = true,
                        },
                        {
                          name = "JavaSE-19",
                          path = "/usr/lib/jvm/java-19-openjdk/",
                        },
                      },
                      maven = {
                        -- Absolute path to settings.xml
                        -- userSettings = "",
                        -- globalSettings = "",
                      },
                    },
                    import = {
                      gradle = {
                        enabled = true,
                        --     -- home = "",
                        --     wrapper = {
                        --       enabled = true,
                        --     },
                        --     annotationProcessing = {
                        --       enabled = true,
                        --     },
                      },
                    },
                    maven = {
                      downloadSources = true,
                      updateSnapshots = true,
                    },
                    implementationsCodeLens = {
                      enabled = true,
                    },
                    referencesCodeLens = {
                      enabled = true,
                    },
                    references = {
                      includeDecompiledSources = true,
                      includeAccessors = true,
                    },
                    inlayHints = {
                      parameterNames = {
                        enabled = "all", -- literals, all, none
                      },
                    },
                    saveActions = {
                      organizeImports = true,
                    },
                    cleanup = {
                      actionsOnSave = {
                        "addOverride",
                        "invertEquals",
                        "addFinalModifier",
                        "lambdaExpression",
                        "switchExpression",
                      },
                    },
                    format = {
                      enabled = true,
                      settings = {
                        profile = "JSONLD-Java Formatter Settings",
                        -- profile = "GoogleStyle",
                        url = home .. "/.config/nvim/.java-google-formatter.xml",
                      },
                    },
                    progressReports = { enabled = true },
                  },
                  signatureHelp = {
                    enabled = true,
                    description = {
                      enabled = true,
                    },
                  },
                  completion = {
                    importOrder = {
                      "java",
                      "javax",
                      "org",
                      "com",
                    },
                    favoriteStaticMembers = {
                      "org.hamcrest.MatcherAssert.assertThat",
                      "org.hamcrest.Matchers.*",
                      "org.hamcrest.CoreMatchers.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "java.util.Objects.requireNonNull",
                      "java.util.Objects.requireNonNullElse",
                      "org.mockito.Mockito.*",
                      "Mockito.*",
                    },
                  },
                  contentProvider = { preferred = "fernflower" },
                  extendedClientCapabilities = extendedClientCapabilities,
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                  codeGeneration = {
                    toString = {
                      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                  },
                },
                flags = {
                  allow_incremental_sync = true,
                  server_side_fuzzy_completion = true,
                },
                init_options = {
                  bundles = bundles,
                },
                on_init = function(client)
                  client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                end,
              })
              jdtls.start_or_attach(jdtls_config)
              vim.cmd(
                "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
              )
              vim.cmd(
                "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
              )
              vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
              vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
              vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
              vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")
            end,
          })
          return true
        end,
      },
    },
  },
}
