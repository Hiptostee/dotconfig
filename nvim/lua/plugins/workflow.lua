return {
  -- 1. Toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = false,
        persist_mode = false,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local vertical_term = Terminal:new({
        direction = "vertical",
        hidden = true,
      })

      vim.keymap.set("n", "<leader>tv", function()
        vertical_term:toggle()
      end, { desc = "Toggle vertical terminal (right)" })

      -- Jump out of terminal without <C-\><C-n> first
      vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
      vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to window below" })
      vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to window above" })
      vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })
    end,
  },

  -- 2. Git Integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      -- Hunk navigation
      vim.keymap.set("n", "]h", require("gitsigns").next_hunk,         { desc = "Next Hunk" })
      vim.keymap.set("n", "[h", require("gitsigns").prev_hunk,         { desc = "Prev Hunk" })
      -- Stage / reset
      vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk,  { desc = "Stage Hunk" })
      vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk,  { desc = "Reset Hunk" })
      vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer,{ desc = "Stage Buffer" })
      vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer,{ desc = "Reset Buffer" })
      -- Preview / blame
      vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk,       { desc = "Preview Hunk" })
      vim.keymap.set("n", "<leader>hb", require("gitsigns").blame_line,         { desc = "Blame Line" })
      vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis,           { desc = "Diff This" })
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>",          { desc = "Git Status" })
      vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>",    { desc = "Git Blame" })
      vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>",   { desc = "Git Diff Split" })
    end,
  },

  -- 3. Diffview
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup()
      vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen<cr>",            { desc = "Diffview Open" })
      vim.keymap.set("n", "<leader>gV", "<cmd>DiffviewClose<cr>",           { desc = "Diffview Close" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",   { desc = "File History" })
    end,
  },

  -- 3. Auto-pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- 4. Commenting (gcc = line, gc = visual block)
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- 5. Auto-format on save (clang-format for C/C++)
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c   = { "clang_format" },
          cpp = { "clang_format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  -- 6. Rails navigation
  {
    "tpope/vim-rails",
  },

  -- 7. Harpoon 2
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to Harpoon" })
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })
      -- Harpoon file switching on leader+number to avoid conflict with terminal nav
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon File 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon File 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon File 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon File 4" })
    end,
  },
}
