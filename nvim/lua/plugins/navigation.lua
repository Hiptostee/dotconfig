return {
  -- 1. Telescope (Fuzzy Finder)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Add the fzf native dependency and tell lazy to compile it
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      -- 🔥 THE FIX: Inject the compatibility patch directly into Telescope's startup!
      if vim.treesitter.language and not vim.treesitter.ft_to_lang then
        vim.treesitter.ft_to_lang = vim.treesitter.language.get_lang
      end

      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      -- Load the ultra-fast C sorter
      telescope.load_extension('fzf')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    end
  },

  -- 2. Neo-tree (File Explorer) (LEAVE THIS EXACTLY AS YOU HAD IT)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
    end
  }
}
