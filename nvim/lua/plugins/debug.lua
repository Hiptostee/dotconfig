return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim" } },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name    = "Launch",
          type    = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd          = "${workspaceFolder}",
          stopOnEntry  = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue,          { desc = "Debug: Continue" })
      vim.keymap.set("n", "<leader>di", dap.step_into,         { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_over,         { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<leader>dO", dap.step_out,          { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>dt", dapui.toggle,          { desc = "Debug: Toggle UI" })
    end,
  },
}
