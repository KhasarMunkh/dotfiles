return {
  ---------------------------------------------------------------------------
  -- 1. Core DAP + UI --------------------------------------------------------
  ---------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- async helper
    },

    config = function()
      -----------------------------------------------------------------------
      -- UI setup & auto-open / close ---------------------------------------
      -----------------------------------------------------------------------
      local dapui = require("dapui")
      dapui.setup()
      local dap = require("dap")

      dap.listeners.before.attach.dapui = function() dapui.open() end
      dap.listeners.before.launch.dapui = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui = function() dapui.close() end
      dap.listeners.before.event_exited.dapui = function() dapui.close() end

      -----------------------------------------------------------------------
      -- Key-maps -----------------------------------------------------------
      -----------------------------------------------------------------------
      local map = vim.keymap.set
      map("n", "<leader>dt", ":DapToggleBreakpoint<CR>", { desc = "DAP: Breakpoint" })
      map("n", "<leader>dc", ":DapContinue<CR>", { desc = "DAP: Continue" })
      map("n", "<leader>do", ":DapStepOver<CR>", { desc = "DAP: Step over" })
      map("n", "<leader>di", ":DapStepInto<CR>", { desc = "DAP: Step into" })
      map("n", "<leader>du", ":DapStepOut<CR>", { desc = "DAP: Step out" })
      map("n", "<leader>dx", ":DapTerminate<CR>", { desc = "DAP: Terminate" })
      map("n", "<leader>dr", ":DapREPL<CR>", { desc = "DAP: REPL" })

      -----------------------------------------------------------------------
      -- Adapter + configuration definitions --------------------------------
      -----------------------------------------------------------------------
      local mason_bin               = vim.fn.stdpath("data") .. "/mason/bin/"

      -- C / C++ / Rust ------------------------------------------------------
      dap.adapters.codelldb         = {
        type = "server",
        port = "${port}",
        executable = {
          command = mason_bin .. "codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp        = {
        {
          name          = "Launch executable",
          type          = "codelldb",
          request       = "launch",
          program       = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd           = "${workspaceFolder}",
          stopOnEntry   = false,
          runInTerminal = false,
        },
      }
      dap.configurations.c          = dap.configurations.cpp
      dap.configurations.rust       = dap.configurations.cpp

      -- C# / .NET -----------------------------------------------------------
      dap.adapters.coreclr          = {
        type = "executable",
        command = mason_bin .. "netcoredbg",
        args = { "--interpreter=vscode" },
      }
      dap.configurations.cs         = {
        {
          type    = "coreclr",
          name    = "Launch .NET DLL",
          request = "launch",
          program = function()
            return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }

      -- JavaScript / TypeScript (Node) -------------------------------------
      dap.adapters["pwa-node"]      = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = mason_bin .. "js-debug-adapter",
          args = { "${port}" },
        },
      }
      dap.configurations.javascript = {
        {
          type    = "pwa-node",
          request = "launch",
          name    = "Launch current file",
          program = "${file}",
          cwd     = "${workspaceFolder}",
        },
      }
      dap.configurations.typescript = dap.configurations.javascript

      -- Bash ----------------------------------------------------------------
      dap.adapters.bashdb           = {
        type    = "executable",
        command = mason_bin .. "bash-debug-adapter",
      }
      dap.configurations.sh         = {
        {
          type     = "bashdb",
          name     = "Debug script",
          request  = "launch",
          program  = "${file}",
          cwd      = "${workspaceFolder}",
          pathBash = "/bin/bash",
        },
      }
    end,
  },

  ---------------------------------------------------------------------------
  -- 2. Mason-nvim-dap (auto-install adapters) ------------------------------
  ---------------------------------------------------------------------------
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mfussenegger/nvim-dap",
    opts = {
      ensure_installed = {
        "codelldb",          -- C / C++ / Rust
        "netcoredbg",        -- C#
        "js-debug-adapter",  -- Node / Chrome
        "bash-debug-adapter" -- Bash
      },
      automatic_installation = true,
    },
  },
}
