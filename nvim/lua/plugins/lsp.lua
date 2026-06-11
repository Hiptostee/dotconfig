return {
  -- 1. LSP Management & Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "ts_ls", "eslint", "ruby_lsp", "rubocop" },
      })

      -- Share capabilities with all servers
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- clangd-specific flags
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
        },
      })

      vim.lsp.config("eslint", {
        settings = {
          workingDirectories = { { mode = "auto" } },
        },
      })

      vim.lsp.enable({ "clangd", "ts_ls", "eslint", "ruby_lsp" })

      -- Keymaps applied whenever any LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          vim.keymap.set("n", "gd",          vim.lsp.buf.definition,      { desc = "Go to Definition",    buffer = buf })
          vim.keymap.set("n", "K",            vim.lsp.buf.hover,           { desc = "Hover Docs",          buffer = buf })
          vim.keymap.set("n", "<leader>vws",  vim.lsp.buf.workspace_symbol,{ desc = "Workspace Symbol",    buffer = buf })
          vim.keymap.set("n", "<leader>vd",   vim.diagnostic.open_float,   { desc = "Line Diagnostic",     buffer = buf })
          vim.keymap.set("n", "[d",           vim.diagnostic.goto_next,    { desc = "Next Error",          buffer = buf })
          vim.keymap.set("n", "]d",           vim.diagnostic.goto_prev,    { desc = "Previous Error",      buffer = buf })
          vim.keymap.set("n", "<leader>vca",  vim.lsp.buf.code_action,     { desc = "Code Actions",        buffer = buf })
          vim.keymap.set("n", "<leader>vrr",  vim.lsp.buf.references,      { desc = "Find References",     buffer = buf })
          vim.keymap.set("n", "<leader>vrn",  vim.lsp.buf.rename,          { desc = "Smart Rename",        buffer = buf })
        end,
      })
    end,
  },

  -- 2. Autocompletion Engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
