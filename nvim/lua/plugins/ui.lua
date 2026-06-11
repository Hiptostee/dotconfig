return {
  -- 1. The Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          treesitter = true,
          telescope = { enabled = true },
          harpoon = true,
          gitsigns = true,
          which_key = true,
          nvimtree = true,
        },
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },

  -- 2. Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin-mocha" },
      })
    end,
  },

  -- 3. Which-key (keybind popup on <Space>)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- 4. Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- 5. Trouble (diagnostics panel)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "All Diagnostics" })
      vim.keymap.set("n", "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
    end,
  },

  -- 6. Treesitter (Advanced Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        -- Automatically install parsers for your core robotics stack
        ensure_installed = { "c", "cpp", "lua", "python", "cmake", "bash", "ruby", "erb", "javascript", "typescript", "tsx", "json", "html", "css" },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },

  -- 7. Startup dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                   ",
        "  ███╗   ██╗██╗   ██╗██╗███╗   ███╗              ",
        "  ████╗  ██║██║   ██║██║████╗ ████║              ",
        "  ██╔██╗ ██║██║   ██║██║██╔████╔██║              ",
        "  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║              ",
        "  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║              ",
        "  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝             ",
        "                                                   ",
        "               ⚙  My Workspace  ⚙                 ",
        "                                                   ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file",    ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Live grep",    ":Telescope live_grep<CR>"),
        dashboard.button("l", "  Lazy",         ":Lazy<CR>"),
        dashboard.button("q", "  Quit",         ":qa<CR>"),
      }

      alpha.setup(dashboard.opts)
    end,
  },

  -- 8. Rainbow brackets/parens/braces
  {
    "HiPhish/rainbow-delimiters.nvim",
  },

  -- 9. Noice (fancy cmdline, LSP progress, notifications)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({ background_colour = "#1e1e2e" })
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
  },

}
