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

  -- 7b. Treesitter text objects (vaf, daf, etc.)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({ select = { lookahead = true } })

      local select = require("nvim-treesitter-textobjects.select")
      local move   = require("nvim-treesitter-textobjects.move")

      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, { desc = "Around function" })
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, { desc = "Inside function" })
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer",    "textobjects") end, { desc = "Around class" })
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner",    "textobjects") end, { desc = "Inside class" })
      vim.keymap.set({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer","textobjects") end, { desc = "Around argument" })
      vim.keymap.set({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner","textobjects") end, { desc = "Inside argument" })

      vim.keymap.set("n", "]f", function() move.goto_next_start("@function.outer",  "textobjects") end, { desc = "Next function" })
      vim.keymap.set("n", "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function" })
      vim.keymap.set("n", "]c", function() move.goto_next_start("@class.outer",     "textobjects") end, { desc = "Next class" })
      vim.keymap.set("n", "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class" })
    end,
  },

  -- 8. Rainbow brackets/parens/braces
  {
    "HiPhish/rainbow-delimiters.nvim",
  },

  -- 9. Smooth animations (cursor, scroll, windows)
  {
    "echasnovski/mini.animate",
    version = "*",
    config = function()
      require("mini.animate").setup()
    end,
  },

  -- 10. Make it rain easter egg + custom animations
  {
    "eandrju/cellular-automaton.nvim",
    keys = {
      { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it Rain" },
      { "<leader>gol", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of Life" },
      { "<leader>scr", "<cmd>CellularAutomaton scramble<CR>",     desc = "Scramble" },
      { "<leader>mtr", "<cmd>CellularAutomaton matrix<CR>",       desc = "Matrix Rain" },
    },
    config = function()
      local ca = require("cellular-automaton")

      local matrix_gradient = {
        { "MatrixHead", "#ccffcc", true  },
        { "MatrixG1",   "#00ff41", false },
        { "MatrixG2",   "#00e83b", false },
        { "MatrixG3",   "#00d135", false },
        { "MatrixG4",   "#00bb30", false },
        { "MatrixG5",   "#00a52a", false },
        { "MatrixG6",   "#009024", false },
        { "MatrixG7",   "#007c1f", false },
        { "MatrixG8",   "#006c1c", false },
      }
      for _, g in ipairs(matrix_gradient) do
        vim.api.nvim_set_hl(0, g[1], { fg = g[2], bold = g[3] })
      end

      -- Patch the loader: get_captures_at_pos misses many cells (operators,
      -- plain identifiers, whitespace). inspect_pos sees all highlight sources.
      -- Falls back to a char-based palette for anything still uncolored.
      local hl_palette = { "Function", "Keyword", "String", "Number", "Type", "Special", "Identifier" }
      local load_mod = require("cellular-automaton.load")
      local _orig_load = load_mod.load_base_grid
      load_mod.load_base_grid = function(window, buffer)
        local grid = _orig_load(window, buffer)
        local start_row = vim.fn.line("w0") - 1
        local start_col = vim.fn.winsaveview().leftcol
        for i, row in ipairs(grid) do
          for j, cell in ipairs(row) do
            if cell.char ~= " " and (cell.hl_group == nil or cell.hl_group == "") then
              local ok, pos = pcall(vim.inspect_pos, buffer, start_row + i - 1, start_col + j - 1)
              if ok and pos then
                for _, ts in ipairs(pos.treesitter or {}) do
                  if ts.hl_group and ts.hl_group ~= "" then
                    cell.hl_group = ts.hl_group
                    break
                  end
                end
                if not cell.hl_group or cell.hl_group == "" then
                  for _, syn in ipairs(pos.syntax or {}) do
                    if syn.hl_group and syn.hl_group ~= "" then
                      cell.hl_group = syn.hl_group
                      break
                    end
                  end
                end
              end
              -- final fallback: deterministic color from char byte value
              if not cell.hl_group or cell.hl_group == "" then
                cell.hl_group = hl_palette[(string.byte(cell.char) % #hl_palette) + 1]
              end
            end
          end
        end
        return grid
      end

      -- Scramble: each cell randomly copies a neighbor each frame -> dissolve/glitch effect
      ca.register_animation({
        fps = 50,
        name = "scramble",
        update = function(grid)
          local snap = {}
          for i = 1, #grid do
            snap[i] = {}
            for j = 1, #grid[i] do
              snap[i][j] = { char = grid[i][j].char, hl_group = grid[i][j].hl_group }
            end
          end
          for i = 1, #grid do
            for j = 1, #grid[i] do
              local pool = { snap[i][j] }
              if snap[i - 1] then table.insert(pool, snap[i - 1][j]) end
              if snap[i + 1] then table.insert(pool, snap[i + 1][j]) end
              if snap[i][j - 1] then table.insert(pool, snap[i][j - 1]) end
              if snap[i][j + 1] then table.insert(pool, snap[i][j + 1]) end
              local pick = pool[math.random(#pool)]
              grid[i][j].char = pick.char
              grid[i][j].hl_group = pick.hl_group
            end
          end
          return true
        end,
      })

      -- Matrix rain: columns of new random chars continuously fall, with staggered stream starts
      local matrix_streams = nil
      ca.register_animation({
        fps = 10,
        name = "matrix",
        update = function(grid)
          local rows = #grid
          if rows == 0 then return true end
          local cols = #grid[1]
          if not matrix_streams or #matrix_streams ~= cols then
            matrix_streams = {}
            for j = 1, cols do
              matrix_streams[j] = -math.random(0, rows * 2)
            end
          end
          for j = 1, cols do
            matrix_streams[j] = matrix_streams[j] + 1
            if matrix_streams[j] > rows + math.random(5, 20) then
              matrix_streams[j] = -math.random(rows, rows * 2)
            end
            for i = rows, 2, -1 do
              grid[i][j].char     = grid[i - 1][j].char
              grid[i][j].hl_group = grid[i - 1][j].hl_group
            end
            if matrix_streams[j] >= 1 then
              grid[1][j].char     = string.char(math.random(33, 126))
              grid[1][j].hl_group = "MatrixHead"
            else
              grid[1][j].char     = " "
              grid[1][j].hl_group = "Normal"
            end
            -- remap trail colors by fractional depth (screen-size independent)
            for i = 2, rows do
              local c = grid[i][j].char
              if c ~= " " and c ~= "" then
                local f = (i - 1) / rows
                local hl
                if     i == 2   then hl = "MatrixG1"
                elseif f < 0.08 then hl = "MatrixG2"
                elseif f < 0.18 then hl = "MatrixG3"
                elseif f < 0.30 then hl = "MatrixG4"
                elseif f < 0.44 then hl = "MatrixG5"
                elseif f < 0.60 then hl = "MatrixG6"
                elseif f < 0.76 then hl = "MatrixG7"
                else                 hl = "MatrixG8"
                end
                grid[i][j].hl_group = hl
              end
            end
          end
          return true
        end,
      })
    end,
  },

  -- 11. Falling snow/stars on dashboard
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function()
      require("drop").setup({
        theme = "stars",
        max = 40,
        interval = 100,
        screensaver = 1000 * 60 * 5,
        filetypes = { "dashboard", "alpha" },
      })
    end,
  },

  -- 12. Inline hex/rgb/hsl color swatches
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        enable_tailwind = true,
      })
    end,
  },

  -- 13. Noice (fancy cmdline, LSP progress, notifications)
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
